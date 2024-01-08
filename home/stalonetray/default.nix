{ pkgs, colors, ... }: {
  home.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) 
  ];

  fonts.fontconfig.enable = true;

  services.stalonetray = {
    enable = true;
    config = {
      background = colors.lighterBlack;
      geometry = "1x1-0+0";
      icon_size = 20;
      grow_gravity = "E";
      icon_gravity = "E";
      kludges = "force_icons_size";
      slot_size = 30;
      sticky = true;
      window_layer = "bottom";
    };
  };

  systemd.user.services.stalonetray.Service.RestartSec = 10;
}
