{
  config,
  pkgs,
  user,
  env,
  ...
}: {
  imports = [
    ./sops

    ./xdg
    ./portal
    ./gtk
    ./qt

    ./ssh
    ./zsh
    ./direnv
    ./git
    ./fzf

    ./xorg
    ./xmonad
    ./xmobar
    ./stalonetray
    ./rofi
    ./dunst
    # ./betterlockscreen

    ./kitty
    ./nvim
    ./helix

    ./flameshot
    ./mpv
    ./aria2

    ./firefox
    ./thunderbird
    ./krusader

    ./udiskie

    ./conky

    ./gstreamer
  ];

  home.packages = with pkgs; [
    nix-index
    fd

    lshw
    hwinfo
    dmidecode
    lm_sensors
    xorg.xwininfo
    xclip
    shpool

    pavucontrol
    alsa-utils

    gimp
    atool
    calibre

    ungoogled-chromium
    tor-browser
    # chromium

    htop
    keepassxc
    gnome-clocks

    flatpak
    (bottles.override {removeWarningPopup = true;})
    heroic
    gamescope
    gamemode
    dosbox-x

    telegram-desktop
    slack
    webcord
    zoom-us

    # ventoy
    woeusb

    gpick
    autokey

    obs-studio

    # ilspycmd
    # dotnet-sdk_7
    # csharp-ls

    quickemu
  ];

  services.screen-locker.xautolock.enable = false;

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.sessionVariables = {
    DOTS_DIR = env.DOTS_DIR;
  };

  home.shellAliases = {
    "ns" = "/${config.xdg.configHome}/user/scripts/new-script.sh";
  };

  programs.home-manager.enable = true;

  home.keyboard = {
    layout = "us,ua";
    variant = "rstu_ru";
    options = ["grp:lctrl_lshift_toggle" "caps:none"];
  };

  home.username = user.name;
  home.homeDirectory = "/home/${user.name}";

  # See the Home Manager release notes for a list of
  # state version changes in each release.
  home.stateVersion = "23.11";
}
