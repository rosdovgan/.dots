{ pkgs, c, user, env, colors, fonts, ... }: {
  imports = [
    ./gtk ./qt

    ./zsh ./direnv ./git

    ./xmonad ./xmobar ./stalonetray ./rofi ./dunst

    ./kitty ./nvim ./tmux

    ./flameshot 

    ./firefox ./thunderbird ./krusader

    ./udiskie

    ./conky
  ];

  home.packages = with pkgs; [ 
    nix-index  
    lshw hwinfo dmidecode lm_sensors xorg.xwininfo xclip xkb-switch
    pavucontrol pulseaudio pulseaudio-ctl alsa-utils
    vlc gimp notepadqq peazip cinnamon.xreader
    ungoogled-chromium
    htop qbittorrent keepassxc 
    gnome.gnome-clocks
    flatpak bottles virt-manager
    telegram-desktop slack webcord
    ventoy woeusb
    gpick autokey
    obs-studio

    # ilspycmd
    # dotnet-sdk_7
    # csharp-ls
    ];

  services.betterlockscreen = {
    enable = true;
    inactiveInterval = 0;
    arguments = [
      "--show-layout"
    ];
  };
  services.screen-locker.xautolock.enable = false;

  services.sxhkd = { 
    enable = true;
    keybindings = {
      "XF86MonBrightnessUp" = "brillo -A 25";
      "XF86MonBrightnessDown" = "brillo -U 25";
      "XF86AudioRaiseVolume" = "pactl -- set-sink-volume 0 +10%";
      "XF86AudioLowerVolume" = "pactl -- set-sink-volume 0 -10%";
      "XF86AudioMute" = "pactl set-sink-mute 0 toggle";
      # "super + l" = "xdg-screensaver activate";
      "Print" = "flameshot gui";
      "shift + Print" = "gpick -s";
    };
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  xdg.configFile = {
    "floskell/config.json".source = /${c}/floskell/config.json;
    "user/user.ini".source = 
        (pkgs.formats.ini {}).generate "user.ini" { inherit colors fonts; };
    "user/scripts".source = /${c}/user/scripts;
  };

  home.sessionVariables = {
    DOTS = env.DOTS;
  };

  programs.home-manager.enable = true;

  home.keyboard = {
    layout = "us,ua";
    variant = "rstu_ru";
    options = [ "grp:lctrl_lshift_toggle" "caps:none" ];
  };

  home.username = user.name;
  home.homeDirectory = "/home/${user.name}";

  # See the Home Manager release notes for a list of 
  # state version changes in each release.
  home.stateVersion = "23.11";
}
