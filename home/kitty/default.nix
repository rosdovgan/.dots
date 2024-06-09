{ c, colors, ... }: {
  programs.kitty = { 
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = builtins.readFile /${c}/kitty/kitty.conf + ''
      background                ${colors.blackT10}
      foreground                ${colors.white}

      selection_background      ${colors.blackT11}
      selection_foreground      ${colors.grayT35}

      url_color                 ${colors.blue}

      cursor                    ${colors.grayT35}
      cursor_text_color         ${colors.black}

      active_border_color       ${colors.blackT11}
      inactive_border_color     ${colors.blackT17}
      bell_border_color         ${colors.red}

      active_tab_background     ${colors.blackT10}
      active_tab_foreground     ${colors.whiteS01}
      inactive_tab_background   ${colors.blackT11}
      inactive_tab_foreground   ${colors.grayS15}

      # Black
      color0                    ${colors.black}
      color8                    ${colors.grayS15}

      # Red
      color1                    ${colors.red}
      color9                    ${colors.redT55}

      # Green
      color2                    ${colors.green}
      color10                   ${colors.greenT40}

      # Yellow
      color3                    ${colors.yellow}
      color11                   ${colors.yellowT70}

      # Blue
      color4                    ${colors.blue}
      color12                   ${colors.blueT60}

      # Magenta
      color5                    ${colors.orange}
      color13                   ${colors.orangeT50}

      # Cyan
      color6                    ${colors.cyan}
      color14                   ${colors.cyanT40}

      # White
      color7                    ${colors.grayT35}
      color15                   ${colors.whiteS01}
    '';
  };
}
# # Black
# color0                    ${colors.black}
# color8                    ${colors.grayS15}
#
# # Red
# color1                    ${colors.red}
# color9                    ${colors.lightRed}
#
# # Green
# color2                    ${colors.green}
# color10                   ${colors.lighterGreen}
#
# # Yellow
# color3                    ${colors.yellow}
# color11                   ${colors.lightYellow}
#
# # Blue
# color4                    ${colors.cyan}
# color12                   ${colors.lightGreen}
#
# # Magenta
# color5                    ${colors.yellow}
# color13                   ${colors.lightYellow}
#
# # Cyan
# color6                    ${colors.blue}
# color14                   ${colors.lightBlue}
#
# # White
# color7                    ${colors.grayT35}
# color15                   ${colors.whiteS01}
