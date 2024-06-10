{
  pkgs,
  users,
  ...
}: {
  imports = [
    ./nix

    ./nix-ld
    ./logind
    ./zsh

    ./xorg
    ./xmonad
    ./lightdm

    ./binfmt

    ./polkit

    ./sound
    ./nvidia
    ./opengl

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

  security.allowSimultaneousMultithreading = false;
  boot.initrd.systemd.dbus.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {common = {default = ["gtk"];};};
  };

  services.thermald.enable = true;
  powerManagement.enable = true;

  services.flatpak.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;

  hardware.bluetooth.enable = true;
  hardware.brillo.enable = true;

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
  };

  users.users."${users.main.name}" = {
    isNormalUser = true;
    description = users.main.description;
    extraGroups = ["networkmanager" "audio" "video" "wheel" "plocate"];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  # man configuration.nix or on https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";
}
