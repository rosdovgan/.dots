{ config, pkgs, colors, ... }: {
  home.packages = with pkgs; [ rofi-power-menu ];

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = with pkgs; [ rofimoji rofi-calc rofi-emoji ];
    theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          lightblack = mkLiteral colors.lighterBlack;
          red = mkLiteral colors.red;
          green = mkLiteral colors.green;
          blue = mkLiteral colors.darkBlue;
          lightblue = mkLiteral colors.blue;
          black = mkLiteral colors.pureBlack;
          darkblack = mkLiteral colors.black;
          white = mkLiteral colors.pureWhite;

          text-color = mkLiteral "@white";
          background-color = mkLiteral "@darkblack";
        };
        "window" = {
          height = mkLiteral "90%";
          width = mkLiteral "35%";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          border = mkLiteral "0px 2px 0px 0px";
          text-color = mkLiteral "@white";
        };
        "mode-switcher" = {
          border = mkLiteral "2px 0px 0px 0px";
          background-color = mkLiteral "@darkblack";
          padding = mkLiteral "4px";
        };
        "button selected" = {
          border-color = mkLiteral "@green";
          text-color = mkLiteral "@green";
        };
        "inputbar" = {
          background-color = mkLiteral "@lightblack";
          text-color = mkLiteral "@green";
          padding = mkLiteral "0.5em 1em";
        };
        "entry" = {
          background-color = mkLiteral "@lightblack";
        };
        "prompt" = {
          background-color = mkLiteral "@lightblack";
        };
        "case-indicator" = {
          background-color = mkLiteral "@lightblack";
        };
        "mainbox" = {
          expand = true;
          background-color = mkLiteral "@darkblack";
          spacing = mkLiteral "1em";
        };
        "listview" = {
          padding = mkLiteral "0em 1em 0em 1em";
          dynamic = false;
          lines = 0;
        };
        "element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral       "inherit";
        };
        "element selected normal" = {
          background-color = mkLiteral "@blue";
          text-color = mkLiteral "@black";
        };
        "element normal active" = {
          text-color = mkLiteral "@lightblue";
        };
        "element normal urgent" = {
          text-color = mkLiteral "@red";
        };
        "element alternate normal" = {};
        "element alternate active" = {
          text-color = mkLiteral "@lightblue";
        };
        "element alternate urgent" = {
          text-color = mkLiteral "@red";
        };
        "element selected active" = {
          background-color = mkLiteral "@lightblue";
          text-color = mkLiteral "@lightblack";
        };
        "element selected urgent" = {
          background-color = mkLiteral "@red";
          text-color = mkLiteral "@lightblack";
        };
        "error-message" = {
          expand = true;
          background-color = mkLiteral "@lightblack";
          border-color = mkLiteral "red";
          border = mkLiteral "2px";
          padding = mkLiteral "1em";
        };
      };
  };

  xdg.desktopEntries = {
    calculator = {
      name = "Power menu";
      genericName = "Power menu";
      exec = "rofi -show power-menu -modi power-menu:rofi-power-menu";
      terminal = false;
      categories = [ "Application" "System" ];
    };

    powerMenu = {
      name = "Calculator";
      genericName = "Calculator";
      exec = "rofi -show calc";
      terminal = false;
      categories = [ "Application" "Utility" ];
    };
  };
}
