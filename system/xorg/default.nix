{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
