{ config, pkgs, c, ... }: 
let
  ghcWithPkgs = pkgs.haskellPackages.ghcWithPackages (haskellPackages: 
    with haskellPackages; [
      xmobar
      ini
  ]);
in
{
  home.packages = [ ghcWithPkgs ];

  # xdg.configFile."xmobar/scripts/padding-icon.sh".source = 
  #   /${c}/config/xmobar/scripts/padding-icon.sh;

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
