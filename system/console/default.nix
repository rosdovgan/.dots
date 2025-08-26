{
  pkgs,
  colors,
  ...
}: {
  console = {
    colors = with colors.bareHex; [
      black
      lightRed
      lightGreen
      lightYellow
      lightBlue
      lightPurple
      lightCyan
      grayT35
      grayS15
      lightRed
      lightGreen
      lightYellow
      lightBlue
      lightPurple
      lightCyan
      whiteS01
    ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-222n.psf.gz";
  };
}
