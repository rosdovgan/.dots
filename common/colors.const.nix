{lib}: let
  colors = rec {
    whiteS01 = shade white 0.01;
    white = ["ff" "ff" "ff"];

    black = ["00" "00" "00"];
    blackT06 = tint black 0.06;
    blackT10 = tint black 0.1;
    blackT11 = tint black 0.11;
    blackT12 = tint black 0.12;
    blackT17 = tint black 0.17;

    grayS65 = shade gray 0.65;
    grayS62 = shade gray 0.62;
    grayS52 = shade gray 0.52;
    grayS15 = shade gray 0.15;
    gray = ["a9" "a9" "a9"];
    grayT35 = tint gray 0.35;

    darkRed = ["b2" "22" "22"];
    neutralRed = ["f3" "19" "40"];
    lightRed = ["fa" "80" "72"];

    darkGreen = ["2e" "8b" "57"];
    neutralGreen = ["38" "d0" "6b"];
    lightGreen = ["c1" "ff" "c1"];

    darkBlue = ["46" "82" "b4"];
    neutralBlue = ["64" "95" "ed"];
    lightBlue = ["87" "ce" "eb"];

    darkYellow = ["da" "a5" "20"];
    neutralYellow = ["ff" "df" "00"];
    lightYellow = ["ff" "fa" "cd"];

    darkPurple = ["66" "33" "99"];
    neutralPurple = ["8a" "2b" "e2"];
    lightPurple = ["d3" "a5" "e1"];

    darkCyan = ["00" "8b" "8b"];
    neutralCyan = ["00" "ce" "d1"];
    lightCyan = ["b0" "e0" "e6"];
  };

  toCssHex = x: "#${builtins.concatStringsSep "" x}";
  toBareHex = x: "${builtins.concatStringsSep "" x}";
  toRgbHex = x: "rgb(${builtins.concatStringsSep "" x})";

  modifyColor = f: color: intToHex (f (hexToInt color));
  shade = color: factor:
    map (modifyColor (x: round (x * (1 - factor)))) color;
  tint = color: factor:
    map (modifyColor (x: round (x + (255 - x) * factor))) color;

  round = x: let
    x' = builtins.floor x;
  in
    if x - x' < 0.5
    then x'
    else builtins.ceil x;

  hexToInt = x: (builtins.fromTOML "x = 0x${x}").x;
  intToHex = x: pad (lib.toHexString x);

  pad = x:
    if (lib.strings.stringLength x == 1)
    then "0${x}"
    else x;
in {
  rgbHex = builtins.mapAttrs (_: toRgbHex) colors;
  bareHex = builtins.mapAttrs (_: toBareHex) colors;
  cssHex = builtins.mapAttrs (_: toCssHex) colors;
}
