{...}: {
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
}
