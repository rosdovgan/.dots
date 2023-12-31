{ ... }: {
  services.xserver = { 
    displayManager.defaultSession = "none+xmonad";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      enableConfiguredRecompile = true;
    };
  };

  # users.groups.video.members = [ "xmonad" ];
}
