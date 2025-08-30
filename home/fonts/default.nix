{pkgs, ...}: {
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Noto Mono"
      ];
      serif = [
        "Noto Serif"
      ];
      sansSerif = [
        "Noto Sans"
      ];
      emoji = ["Noto Emoji"];
    };
  };
}
