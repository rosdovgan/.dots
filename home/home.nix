{
  pkgs,
  c,
  user,
  env,
  colors,
  fonts,
  ...
}: {
  imports = [
    ./sops

    ./gtk
    ./qt

    ./ssh
    ./zsh
    ./direnv
    ./git
    ./fzf

    ./xmonad
    ./xmobar
    ./stalonetray
    ./rofi
    ./dunst
    ./betterlockscreen

    ./kitty
    ./nvim
    ./helix

    ./flameshot
    ./mpv

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

    pavucontrol
    alsa-utils

    gimp
    atool
    calibre

    ungoogled-chromium
    tor-browser
    # chromium

    htop
    qbittorrent
    keepassxc
    gnome-clocks

    flatpak
    bottles
    heroic
    gamescope
    gamemode

    dosbox-x

    telegram-desktop
    slack
    webcord
    zoom-us

    ventoy
    woeusb

    gpick
    autokey

    obs-studio

    # ilspycmd
    # dotnet-sdk_7
    # csharp-ls
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

  xdg.configFile = {
    "floskell/config.json".source = /${c}/floskell/config.json;
    "user/user.ini".source =
      (pkgs.formats.ini {}).generate "user.ini" {inherit colors fonts;};
    "user/scripts".source = /${c}/user/scripts;
  };

  xsession.initExtra = ''
    telegram-desktop -startintray &
    # slack -u &
    # webcord -m &
  '';

  home.sessionVariables = {
    DOTS_DIR = env.DOTS_DIR;
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
