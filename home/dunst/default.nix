{ colors, fonts, ... }: {
  services.dunst = { 
    enable = true;
    settings = { 
      global = {
        font = fonts.main12;
        origin = "top-right";
        offset = "0x30";
        frame_width = 1;
        frame_color = colors.black;
        separator_color = colors.lightGray;
        separator_height = 1;
        padding = 10;
        horizontal_padding = 20;
        transparency = 10;
        background = colors.black;
        foreground = colors.pureWhite;
      };
      urgency_low = {
        timeout = "5s";
      };
      urgency_normal = {
        timeout = "15s";
      };
      urgency_critical = {
        timeout = "30s";
        frame_color = colors.red;
      };
    };
  };
}
