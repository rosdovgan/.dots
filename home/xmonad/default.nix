{ pkgs, c, colors, ... }: {
  home.packages = with pkgs; [ xdotool ];

  services.picom.enable = true;
  xsession = {
    enable = true;
    initExtra = ''
      xsetroot -solid "${colors.pureBlack}"
    '';

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      # config = /${c}/config/xmonad/xmonad.hs;
      extraPackages = haskellPackages: with pkgs.haskellPackages; [ 
        ini
        xmobar 
        # taffybar
      ];
    };
  };

  xdg.configFile."xmonad/xmonad.hs" = {
    source = /${c}/xmonad/xmonad.hs;
    onChange = ''
      rm -rf $HOME/.xmonad
    '';
  };
}
