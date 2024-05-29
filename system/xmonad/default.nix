{...}: {
  services = {
    displayManager.defaultSession = "none+xmonad";
    xserver = {
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        enableConfiguredRecompile = true;
      };
    };
  };
  # users.groups.video.members = [ "xmonad" ];
}
