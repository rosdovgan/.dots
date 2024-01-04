{ pkgs, lib, user, ... }:
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
  };

  userStyling = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    "layout.css.backdrop-filter.enabled" = true;
    "svg.context-properties.content.enabled" = true;
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
in
{
  programs.firefox = {
    enable = true;
    profiles."${user.name}" = {
      isDefault = true;

      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        force = true;
        order = [ "DuckDuckGo" "Startpage" ];

        engines = {
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
        sidebery
        proton-vpn
        betterttv
        # startpage-private-search
       ];

      settings = lib.attrsets.mergeAttrsList [
        general
        userStyling
        ];
      extraConfig = lib.readFile (pkgs.fetchurl {
        url =
          "https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js";
        hash = "sha256-PH9ZR6U8l5p7hViMyuDliYoTuikdZOqo+PmvsPsBPao=";
      }) + ''
        user_pref("browser.search.suggest.enabled", true);
        user_pref("browser.newtabpage.enabled", false);
      '';
      userChrome = ''
        #main-window:not([privatebrowsingmode="temporary"]) #TabsToolbar {
          visibility: collapse;
        }
      '';
    };
  };
}
