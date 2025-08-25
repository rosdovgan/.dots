{
  colors,
  fonts,
  ...
}: {
  services.dunst = {
    enable = true;
    settings = with colors.cssHex; {
      global = {
        font = fonts.main12;
        origin = "top-right";
        offset = "0x30";
        frame_width = 1;
        frame_color = blackT10;
        separator_color = grayS15;
        separator_height = 1;
        padding = 10;
        horizontal_padding = 20;
        transparency = 10;
        background = blackT10;
        foreground = white;

        mouse_left_click = "close_current";
        mouse_right_click = "do_action";
        mouse_middle_click = "context";

        history = "mod4+grave";
      };
      urgency_low = {
        timeout = "5s";
      };
      urgency_normal = {
        timeout = "15s";
      };
      urgency_critical = {
        timeout = "30s";
        frame_color = neutralRed;
      };
    };
  };
}
