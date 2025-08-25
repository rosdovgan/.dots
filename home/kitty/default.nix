{
  c,
  colors,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = with colors.cssHex;
      builtins.readFile /${c}/kitty/kitty.conf
      + ''
        background                ${blackT10}
        foreground                ${white}

        selection_background      ${blackT11}
        selection_foreground      ${grayT35}

        url_color                 ${neutralBlue}

        cursor                    ${grayT35}
        cursor_text_color         ${black}

        active_border_color       ${blackT11}
        inactive_border_color     ${blackT17}
        bell_border_color         ${neutralRed}

        active_tab_background     ${blackT10}
        active_tab_foreground     ${whiteS01}
        inactive_tab_background   ${blackT11}
        inactive_tab_foreground   ${grayS15}

        # Black
        color0                    ${black}
        color8                    ${grayS15}

        # Red
        color1                    ${lightRed}
        color9                    ${lightRed}
        # color9                    ${neutralRed}

        # Green
        color2                    ${lightGreen}
        color10                   ${lightGreen}
        # color10                   ${neutralGreen}

        # Yellow
        color3                    ${lightYellow}
        color11                   ${lightYellow}
        # color11                   ${neutralYellow}

        # Blue
        color4                    ${lightBlue}
        color12                   ${lightBlue}
        # color12                   ${neutralBlue}

        # Magenta
        color5                    ${lightPurple}
        color13                   ${lightPurple}
        # color13                   ${neutralPurple}

        # Cyan
        color6                    ${lightCyan}
        color14                   ${lightCyan}
        # color14                   ${neutralCyan}

        # White
        color7                    ${grayT35}
        color15                   ${whiteS01}
      '';
  };
}
