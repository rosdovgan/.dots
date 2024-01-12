{ config, pkgs, c, ... }: 
let
  ghcWithPkgs = pkgs.haskellPackages.ghcWithPackages (haskellPackages: 
    with haskellPackages; [
      xmobar
      ini
  ]);
in
{
  home.packages = with pkgs; [ libnotify ghcWithPkgs ];

  programs.xmobar = {
    enable = true;
    # extraConfig = builtins.readFile /${c}/config/xmobar/.xmobarrc;
  };

  xdg.configFile."xmobar/xmobar.hs" = {
    source = /${c}/xmobar/xmobar.hs;
    onChange = ''
      rm -rf ${config.xdg.configHome}/xmobar/xmobar \
             ${config.xdg.configHome}/xmobar/xmobar.hi \
             ${config.xdg.configHome}/xmobar/xmobar.o
    '';
  };
}
