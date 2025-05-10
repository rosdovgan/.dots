{ config, pkgs, lib, user, ... }:
let
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
    "general.useragent.override" =
      "Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0";
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
in
{
  programs.firefox = {
    enable = true;
    profiles."${user.name}" = {
      isDefault = true;

      search = {
        default = "Qwant";
        privateDefault = "Qwant";
        force = true;
        order = [ "Qwant" "DuckDuckGo" "Startpage" ];

        engines = {
          "Qwant" = {
            urls = [{
              template = "https://www.qwant.com";
              params = [
                { name = "q"; value = "{searchTerms}"; }
                { name = "t"; value = "web"; }
              ];
            }];
            iconUpdateURL = "https://www.qwant.com/public/"
              + "favicon-196.b2a1214ee3c261334512a377f1d678f7.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@q" ];
          };
          "DuckDuckGo".metaData.alias = "@ddg";
          "Startpage" = {
            urls = [{
              template = "https://www.startpage.com/do/dsearch";
              params = [
                { name = "q"; value = "{searchTerms}"; }
                { name = "cat"; value = "web"; }
                { name = "language"; value = "english"; }
              ];
            }];
            iconUpdateURL = "https://www.startpage.com"
              + "/sp/cdn/favicons/android-icon-192x192.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@sp" ];
          };
          "YouTube" = {
            urls = [{
              template = "https://www.youtube.com/results";
              params = [
                { name = "search_query"; value = "{searchTerms}"; }
              ];
            }];
            iconUpdateURL = "https://www.youtube.com"
              + "/s/desktop/bcd251ee/img/favicon_144x144.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@yt" ];
          };

          "MyNixOS" = {
            urls = [{
              template = "https://mynixos.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            iconUpdateURL = "https://mynixos.com/favicon-dark.svg";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@mn" ];
          };

          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = pkgs.nixos-icons
              + "/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "type"; value = "options"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = pkgs.nixos-icons
              + "/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
          "NixOS Wiki" = {
            urls = [{
              template = "https://nixos.wiki/index.php?search={searchTerms}";
              }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Google".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
        };
      };


      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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
      extraConfig = lib.readFile (pkgs.fetchurl {
        url =
          "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js";
        hash = "sha256-XME9G1LBbnj4DybzzDUP5iC0DDmwgNt0GP5r+Y+KILs=";
 }) + ''
        user_pref("browser.search.suggest.enabled", true);
        user_pref("browser.newtabpage.enabled", false);
      '';
    };
  };
}

