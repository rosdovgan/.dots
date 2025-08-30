{
  lib,
  pkgs,
  colors,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        layer = "overlay";
        vertical-pad = 30;
        inner-pad = 10;
        width = 40;
        lines = 25;
        list-executables-in-path = true;
        icon-theme = "Papirus-Dark";
      };

      colors = with lib.mapAttrs (_: x: "${x}ff") colors.bareHex; {
        background = blackT06;
        text = whiteS01;
        input = whiteS01;
        prompt = lightPurple;
        match = lightYellow;
        selection = neutralBlue;
        selection-text = black;
        selection-match = blackT10;
      };

      border = {
        width = 0;
        radius = 0;
      };
    };
  };
}
