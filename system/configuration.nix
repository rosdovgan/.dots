{ pkgs, users, ... }: {
  imports = [
    ./system-packages-list.nix 

    ./nix-ld ./logind ./zsh

    ./xorg ./xmonad ./lightdm

    ./binfmt

    ./polkit

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
  services.libinput.enable = true; # Touchpad

  programs.dconf.enable = true;
  programs.gnupg.agent.enable = true;
  programs.mtr.enable = true;

  networking = {
    networkmanager.enable = true;
    stevenblack = {
      enable = true;
      block = [ "fakenews" "gambling" "porn" ];
    };
  };

  nix.settings = {
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "ghc-nix.cachix.org-1:wI8l3tirheIpjRnr2OZh6YXXNdK2fVQeOI4SVz/X8nA="
      "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cache.iog.io"
      "https://ghc-nix.cachix.org"
      "https://static-haskell-nix.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://digitallyinduced.cachix.org"
    ];
  };

  users.users."${users.main.name}" = {
    isNormalUser = true;
    description = users.main.description;
    extraGroups = [ "networkmanager" "audio" "video" "wheel" "plocate" ];
    shell = pkgs.zsh;
  };

  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 3month";
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # man configuration.nix or on https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";
}
