{ pkgs, lib, c, user, env, colors, fonts, ... }:
let
  # TODO: Come up with something else
  private = let
      repo = let env = import ../common/env.const.nix; in
      builtins.fetchGit {
      url = "file:///etc/" +  env.DOTS_PRIVATE_DIR;
      rev = "fc1a7a285755f7b2345e993db6000d5626dc691a";
    };
    in
    path: (lib.optional
      (builtins.pathExists (repo + path))
      (repo + path));
in
{
  imports = [
    ./gtk ./qt

    ./zsh ./direnv ./git

    ./xmonad ./xmobar ./stalonetray ./rofi ./dunst

    ./kitty ./nvim ./tmux

    ./flameshot 

    ./firefox ./thunderbird ./krusader

    ./udiskie

    ./conky

    ./gstreamer
  ] ++ (private "/home/home.nix");

  home.packages = with pkgs; [ 
    nix-index  
    lshw hwinfo dmidecode lm_sensors xorg.xwininfo xclip xkb-switch
    pavucontrol alsa-utils
    vlc gimp notepadqq peazip cinnamon.xreader
    ungoogled-chromium
    # chromium
    htop qbittorrent keepassxc 
    gnome.gnome-clocks
    flatpak bottles
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
        (pkgs.formats.ini {}).generate "user.ini" { inherit colors fonts; };
    "user/scripts".source = /${c}/user/scripts;
  };

  xsession.initExtra = ''
    telegram-desktop -startintray &
    slack -u &
    webcord -m &
  '';

  home.sessionVariables = {
    DOTS_DIR = env.DOTS_DIR;
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
