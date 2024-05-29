{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
