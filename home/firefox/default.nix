{
  config,
  pkgs,
  lib,
  user,
  ...
}: let
  general = {
    "sidebar.position_start" = false;
    "general.smoothScroll" = false;
    "browser.startup.page" = 3; # restore previous session
    "browser.shell.checkDefaultBrowser" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.newtabpage.enabled" = false;
    "browser.newtab.url" = "about:blank";
    "startup.homepage_welcome_url" = "about:blank";
    "browser.newtabpage.activity-stream.feeds.newtabinit" = false;
    "browser.newtabpage.activity-stream.default.sites" = "";
    "browser.urlbar.suggest.topsites" = false;
    "browser.toolbars.bookmarks.visibility" = "newtab";
  };

  userStyling = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    "layout.css.backdrop-filter.enabled" = true;
    "svg.context-properties.content.enabled" = true;
    "browser.tabs.inTitlebar" = 0;
    "browser.theme.native-theme" = false;
  };

  clearOnClose = {
    "privacy.sanitize.sanitizeOnShutdown" = true;
    "privacy.clearOnShutdown.cache" = true;
    "privacy.clearOnShutdown.cookies" = true;
    "privacy.clearOnShutdown.downloads" = true;
    "privacy.clearOnShutdown.formdata" = true;
    "privacy.clearOnShutdown.history" = true;
    "privacy.clearOnShutdown.offlineApps" = true;
    "privacy.clearOnShutdown.sessions" = true;
    "privacy.clearOnShutdown.openWindows" = true;
  };

  userAgent = {
    "general.useragent.override" = "Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0";
    "general.appname.override" = "Netscape";
    "general.appversion.override" = "5.0 (Windows)";
    "general.platform.override" = "Win32";
    "general.oscpu.override" = "Windows NT 6.1";
  };

  sidebar = {
    "sidebar.verticalTabs" = true;
    "sidebar.revamp" = true;
    "sidebar.visibility" = "expand-on-hover";
    "sidebar.expandOnHover" = true;
    "sidebar.animation.enabled" = false;
    "sidebar.animation.duration-ms" = 0;
    "sidebar.animation.expand-on-hover.duration-ms" = 0;
    "sidebar.main.tools" = "history";
    "toolkit.scrollbox.smoothScroll" = false;
  };

  bookmarks = {
    "browser.bookmarks.file" = config.sops.secrets.firefoxBookmarks.path;
    "browser.places.importBookmarksHTML" = true;
  };
in {
  programs.firefox = {
    enable = true;
    profiles."${user.name}" = {
      isDefault = true;

      search = {
        default = "searxng";
        privateDefault = "searxng";
        force = true;
        order = ["searxng" "qwant" "ddg" "Startpage"];

        engines = let
          daily = 86400000;
          nix-icon =
            pkgs.nixos-icons
            + "/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        in {
          searxng = {
            urls = [
              {template = "http://localhost:49152/search?q={searchTerms}";}
            ];
            icon = "http://localhost:49152/favicon.ico";
            updateInterval = daily;
            definedAliases = ["@s"];
          };

          qwant = {
            urls = [
              {template = "https://www.qwant.com/?q={searchTerms}";}
            ];
            icon = "https://www.qwant.com/favicon.ico";
            updateInterval = daily;
            definedAliases = ["@q"];
          };

          ddg.metaData.alias = "@ddg";

          startpage = {
            urls = [
              {template = "https://www.startpage.com/do/dsearch?q={searchTerms}";}
            ];
            icon = "https://www.startpage.com/favicon.ico";
            updateInterval = daily;
            definedAliases = ["@sp"];
          };

          youtube = {
            urls = [
              {template = "https://www.youtube.com/results?search_query={searchTerms}";}
            ];
            icon = "https://www.youtube.com/favicon.ico";
            updateInterval = daily;
            definedAliases = ["@yt"];
          };

          "MyNixOS" = {
            urls = [
              {template = "https://mynixos.com/search?q={searchTerms}";}
            ];
            icon = "https://mynixos.com/favicon-dark.svg";
            updateInterval = daily;
            definedAliases = ["@mn"];
          };

          "Nix Packages" = {
            urls = [
              {
                template =
                  "https://search.nixos.org/packages"
                  + "?type=options"
                  + "&query={searchTerms}";
              }
            ];
            icon = nix-icon;
            definedAliases = ["@np"];
          };

          "Nix Options" = {
            urls = [
              {
                template =
                  "https://search.nixos.org/options"
                  + "?type=options"
                  + "&query={searchTerms}";
              }
            ];
            icon = nix-icon;
            definedAliases = ["@no"];
          };

          "NixOS Wiki" = {
            urls = [
              {template = "https://nixos.wiki/index.php?search={searchTerms}";}
            ];
            icon = "https://nixos.wiki/favicon.ico";
            updateInterval = daily;
            definedAliases = ["@nw"];
          };

          google.metaData.hidden = true;
          bing.metaData.hidden = true;
          amazondotcom.metaData.hidden = true;
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        consent-o-matic
        proton-vpn
        betterttv
        darkreader
        leechblock-ng
      ];

      settings = lib.attrsets.mergeAttrsList [
        general
        userStyling
        sidebar
        bookmarks
      ];
      extraConfig =
        lib.readFile (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js";
          hash = "sha256-sY2MHDmq8LC8yhYgyI7uEIBRZIweW0FxvJhhMUzS2kE=";
        })
        + ''
          user_pref("browser.search.suggest.enabled", true);
          user_pref("browser.newtabpage.enabled", false);
        '';
      userChrome = ''
        .tabbrowser-tab .tab-close-button {
          visibility: collapse !important;
        }
      '';
    };
  };
}
