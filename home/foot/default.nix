{
  pkgs,
  colors,
  ...
}: {
  home.packages = with pkgs; [
    papirus-icon-theme
    terminus_font_ttf
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        font = "Terminus (TTF):size=11";
        dpi-aware = "yes";
        selection-target = "both";
      };

      colors = with colors.bareHex; {
        background = blackT10;
        foreground = white;

        regular0 = black;
        bright0 = grayS15;
        regular1 = lightRed;
        bright1 = lightRed;
        regular2 = lightGreen;
        bright2 = lightGreen;
        regular3 = lightYellow;
        bright3 = lightYellow;
        regular4 = lightBlue;
        bright4 = lightBlue;
        regular5 = lightPurple;
        bright5 = lightPurple;
        regular6 = lightCyan;
        bright6 = lightCyan;
        regular7 = grayT35;
        bright7 = whiteS01;
      };

      mouse = {
        hide-when-typing = "yes";
      };

      key-bindings = {
        clipboard-paste = "Control+v XF86Paste";
      };
    };
  };
}
