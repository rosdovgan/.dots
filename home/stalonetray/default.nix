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

      # decorations = "none";
      # transparent = false;
      # dockapp_mode = "none";

      # grow_gravity = "NW";
      # icon_gravity = "NW";

      sticky = true;
      #window_strut none;
      # window_type = "dock";
      window_layer = "bottom";
      # no_shrink = false;
      # skip_taskbar = true;
    };
  };
}
