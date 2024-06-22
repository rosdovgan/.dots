{ pkgs, ... }: {
  home.packages = with pkgs; [ xkb-switch ];

  xdg.configFile = {
    "betterlockscreen/custom-pre.sh".text = 
      let xs = pkgs.xkb-switch + /bin/xkb-switch; 
          sed = pkgs.gnused + /bin/sed;
      in ''
      ${xs} -s $(${xs} -l | ${sed} -n '1p')
    '';

    "betterlockscreen/betterlockscreenrc".text = ''
      lock_timeout=0
    '';
  };

  services.betterlockscreen = {
    enable = true;
    inactiveInterval = 90;
  };
}
