{ c, colors, ... }: {
  programs.kitty = { 
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = builtins.readFile /${c}/kitty/kitty.conf + ''
      background                ${colors.black}
      foreground                ${colors.pureWhite}

      selection_background      ${colors.lightBlack}
      selection_foreground      ${colors.lighterGray}

      url_color                 ${colors.darkBlue}

      cursor                    ${colors.lighterGray}
      cursor_text_color         ${colors.pureBlack}

      active_border_color       ${colors.lightBlack}
      inactive_border_color     ${colors.lightestBlack}
      bell_border_color         ${colors.red}

      active_tab_background     ${colors.black}
      active_tab_foreground     ${colors.white}
      inactive_tab_background   ${colors.lightBlack}
      inactive_tab_foreground   ${colors.lightGray}

      color0                    ${colors.pureBlack}
      color1                    ${colors.red}
      color2                    ${colors.green}
      color3                    ${colors.yellow}
      color4                    ${colors.cyan}
      color5                    ${colors.yellow}
      color6                    ${colors.blue}
      color7                    ${colors.lighterGray}

      color8                    ${colors.lightGray}
      color9                    ${colors.lightRed}
      color10                   ${colors.lighterGreen}
      color11                   ${colors.lightYellow}
      color12                   ${colors.lightGreen}
      color13                   ${colors.lightYellow}
      color14                   ${colors.lightBlue}
      color15                   ${colors.white}
    '';
  };
}
# color3                    ${colors.purple}
# color11                   ${colors.lightPuple}
