{
  c,
  colors,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig =
      builtins.readFile /${c}/kitty/kitty.conf
      + ''
        background                ${colors.blackT10}
        foreground                ${colors.white}

        selection_background      ${colors.blackT11}
        selection_foreground      ${colors.grayT35}

        url_color                 ${colors.neutralBlue}

        cursor                    ${colors.grayT35}
        cursor_text_color         ${colors.black}

        active_border_color       ${colors.blackT11}
        inactive_border_color     ${colors.blackT17}
        bell_border_color         ${colors.neutralRed}

        active_tab_background     ${colors.blackT10}
        active_tab_foreground     ${colors.whiteS01}
        inactive_tab_background   ${colors.blackT11}
        inactive_tab_foreground   ${colors.grayS15}

        # Black
        color0                    ${colors.black}
        color8                    ${colors.grayS15}

        # Red
        color1                    ${colors.lightRed}
        color9                    ${colors.lightRed}
        # color9                    ${colors.neutralRed}

        # Green
        color2                    ${colors.lightGreen}
        color10                   ${colors.lightGreen}
        # color10                   ${colors.neutralGreen}

        # Yellow
        color3                    ${colors.lightYellow}
        color11                   ${colors.lightYellow}
        # color11                   ${colors.neutralYellow}

        # Blue
        color4                    ${colors.lightBlue}
        color12                   ${colors.lightBlue}
        # color12                   ${colors.neutralBlue}

        # Magenta
        color5                    ${colors.lightPurple}
        color13                   ${colors.lightPurple}
        # color13                   ${colors.neutralPurple}

        # Cyan
        color6                    ${colors.lightCyan}
        color14                   ${colors.lightCyan}
        # color14                   ${colors.neutralCyan}

        # White
        color7                    ${colors.grayT35}
        color15                   ${colors.whiteS01}
      '';
  };
}
