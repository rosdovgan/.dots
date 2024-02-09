{ pkgs, users, ... }: {
  imports = [ 
    ./system-packages-list.nix 
    
    ./nix-ld ./logind ./zsh

    ./xorg ./xmonad ./lightdm

    ./binfmt

    ./sound ./nvidia ./opengl

    ./locate

    ./time-and-locale

    ./virtualisation
    ];

  environment.systemPackages = with pkgs; [ 
    where-is-my-sddm-theme
    neovim 
    wget curl 
    git  
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelModules = [ "coretemp" ];

  security.allowSimultaneousMultithreading = false;
  boot.initrd.systemd.dbus.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      ];
    config = { common = { default = [ "gtk" ]; }; };
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
  services.xserver.libinput.enable = true; # Touchpad

  programs.dconf.enable = true;
  programs.gnupg.agent.enable = true;
  programs.mtr.enable = true;

  networking.networkmanager.enable = true;

  nix.settings.trusted-public-keys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.settings.substituters = [
    "https://cache.iog.io"
  ];

  users.users."${users.main.name}" = {
    isNormalUser = true;
    description = users.main.description;
    extraGroups = [ "networkmanager" "audio" "video" "wheel" "plocate" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # man configuration.nix or on https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";
}
