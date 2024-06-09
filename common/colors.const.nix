{lib}: let
  round = x: let
    x' = builtins.floor x;
  in
    if x - x' < 0.5
    then x'
    else builtins.ceil x;

  rgbToHex = rgb: let
    pad = x: if (lib.strings.stringLength x == 1) then "0${x}" else x;
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

  beige = "#fffac8";

  blue = "#4363d8";
  blueT60 = tintHex blue 0.60;

  cyan = "#42d4f4";
  cyanT40 = tintHex cyan 0.40;

  red = "#e6194B";
  redT55 = tintHex red 0.55;

  orange = "#f58231";
  orangeT50 = tintHex orange 0.50;

  yellow = "#ffe119";
  yellowT70 = tintHex yellow 0.70;

  green = "#3cb44b";
  greenT40 = tintHex green 0.40;
  greenT80 = tintHex green 0.80;

  lavender = "#dcbeff";

  purple = "#911eb4";
  purpleT60 = tintHex purple 0.60;

  White = "#ffffff";
  Black = "#000000";
  Red = "#e6194B";
  Green = "#3cb44b";
  Yellow = "#ffe119";
  Blue = "#4363d8";
  Orange = "#f58231";
  Purple = "#911eb4";
  Cyan = "#42d4f4";
  Magenta = "#f032e6";
  Lime = "#bfef45";
  Pink = "#fabed4";
  Teal = "#469990";
  Lavender = "#dcbeff";
  Brown = "#9A6324";
  Beige = "#fffac8";
  Maroon = "#800000";
  Mint = "#aaffc3";
  Olive = "#808000";
  Apricot = "#ffd8b1";
  Navy = "#000075";
  Grey = "#a9a9a9";

  # testS90 = shadeHex test 0.90;
  # testS80 = shadeHex test 0.80;
  # testS70 = shadeHex test 0.70;
  # testS60 = shadeHex test 0.60;
  # testS50 = shadeHex test 0.50;
  # testS40 = shadeHex test 0.40;
  # testS30 = shadeHex test 0.30;
  # testS20 = shadeHex test 0.20;
  # testS10 = shadeHex test 0.10;
  # test = purple;
  # testT10 = tintHex test 0.10;
  # testT20 = tintHex test 0.20;
  # testT30 = tintHex test 0.30;
  # testT40 = tintHex test 0.40;
  # testT50 = tintHex test 0.50;
  # testT60 = tintHex test 0.60;
  # testT70 = tintHex test 0.70;
  # testT80 = tintHex test 0.80;
  # testT90 = tintHex test 0.90;

  # darkBlue = "#0085CC";
  # blue = "#33b8ff";
  # lightBlue = "#99c1f1";
}
