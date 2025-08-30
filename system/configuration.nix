{
  pkgs,
  c,
  users,
  ...
}: {
  imports = [
    ./nix
    ./console

    ./nix-ld
    ./logind
    ./zsh

    ./binfmt

    ./polkit

    ./udev
    ./sound
    ./nvidia

    ./locate

    ./time-and-locale

    ./virtualisation
  ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 50;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];
  boot.kernelModules = ["coretemp"];
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.dbus.enable = true;

  security.allowSimultaneousMultithreading = true;
  security.pam.services.hyprlock = {};

  # Required by home-manager xdg.portal.enable option
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  services.thermald.enable = true;
  powerManagement.enable = true;
  services.tlp.enable = true;

  services.udisks2.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;
  services.dbus.enable = true;

  hardware.bluetooth.enable = true;
  hardware.brillo.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.updateDbusEnvironment = true;
  services.libinput.enable = true; # Touchpad

  programs.dconf.enable = true;
  programs.gnupg.agent.enable = true;
  programs.mtr.enable = true;

  networking = {
    networkmanager.enable = true;
    stevenblack = {
      enable = true;
      block = ["fakenews" "gambling" "porn"];
    };
  };

  environment.shellAliases = {
    nix-store-packages = "nix-store --query --requisites /run/current-system";
    nix-repl-flake =
      pkgs.writeScript "nix-repl-flake"
      (builtins.readFile "/${c}/user/scripts/nix-repl-flake.sh");
  };

  users.users."${users.owner.name}" = {
    isNormalUser = true;
    description = users.owner.description;
    extraGroups = ["networkmanager" "audio" "video" "wheel" "plocate"];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  # man configuration.nix or on https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";
}
