{lib}: let
  round = x: let
    x' = builtins.floor x;
  in
    if x - x' < 0.5
    then x'
    else builtins.ceil x;

  rgbToHex = rgb: let
    pad = x:
      if (lib.strings.stringLength x == 1)
      then "0${x}"
      else x;
    intToHex = x: pad (lib.toHexString x);
  in "#${intToHex rgb.r}${intToHex rgb.g}${intToHex rgb.b}";

  hexToRgb = hex: let
    hexToInt = hex: (builtins.fromTOML "x = 0x${hex}").x;
  in {
    r = hexToInt (lib.strings.substring 1 2 hex);
    g = hexToInt (lib.strings.substring 3 2 hex);
    b = hexToInt (lib.strings.substring 5 2 hex);
  };

  shadeRgb = rgb: factor: {
    r = round (rgb.r * (1 - factor));
    g = round (rgb.g * (1 - factor));
    b = round (rgb.b * (1 - factor));
  };

  shadeHex = hex: factor: rgbToHex (shadeRgb (hexToRgb hex) factor);

  tintRgb = rgb: factor: {
    r = round (rgb.r + (255 - rgb.r) * factor);
    g = round (rgb.g + (255 - rgb.g) * factor);
    b = round (rgb.b + (255 - rgb.b) * factor);
  };

  tintHex = hex: factor: rgbToHex (tintRgb (hexToRgb hex) factor);
in rec {
  whiteS01 = shadeHex white 0.01;
  white = "#ffffff";

  black = "#000000";
  blackT06 = tintHex black 0.06;
  blackT10 = tintHex black 0.1;
  blackT11 = tintHex black 0.11;
  blackT12 = tintHex black 0.12;
  blackT17 = tintHex black 0.17;

  grayS65 = shadeHex gray 0.65;
  grayS62 = shadeHex gray 0.62;
  grayS52 = shadeHex gray 0.52;
  grayS15 = shadeHex gray 0.15;
  gray = "#a9a9a9";
  grayT35 = tintHex gray 0.35;

  darkRed = "#B22222";
  neutralRed = "#f31940";
  lightRed = "#FA8072";

  darkGreen = "#2E8B57";
  neutralGreen = "#38d06b";
  lightGreen = "#C1FFC1";

  darkBlue = "#4682B4";
  neutralBlue = "#6495ED";
  lightBlue = "#87CEEB";

  darkYellow = "#DAA520";
  neutralYellow = "#FFDF00";
  lightYellow = "#FFFACD";

  darkPurple = "#663399";
  neutralPurple = "#8A2BE2";
  lightPurple = "#D3A5E1";

  darkCyan = "#008B8B";
  neutralCyan = "#00CED1";
  lightCyan = "#B0E0E6";
}
