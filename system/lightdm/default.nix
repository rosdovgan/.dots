{ pkgs, users, colors, ... }:
let
  xsr = pkgs.xorg.xsetroot + /bin/xsetroot;

  lightdmGreeterSetup = let
    xorgBlankCursor = pkgs.writeText "xorg-blank-cursor" ''
      #define blank_width 1
      #define blank_height 1
      #define blank_x_hot 0
      #define blank_y_hot 0
      static unsigned char blank_bits[] = {
          0x00 };
    '';
  in
  pkgs.writeShellScript "lightdm-greeter-setup" ''
    ${xsr} -cursor ${xorgBlankCursor} ${xorgBlankCursor}
  '';

  lightdmSessionSetup = let
    xr = pkgs.xorg.xrandr + /bin/xrandr;
    awk = pkgs.gawk + /bin/awk;
  in
  pkgs.writeShellScript "lightdm-session-setup" ''
    ${pkgs.xdotool}/bin/xdotool mousemove \
      $(expr $(${xr} | grep '*' | uniq | ${awk} '{print $1}' | cut -d 'x' -f1) \
      / 2) \
      $(expr $(${xr} | grep '*' | uniq | ${awk} '{print $1}' | cut -d 'x' -f2) \
      / 2)
    ${xsr} -cursor_name left_ptr
  '';
in
{
  services.xserver = {
    displayManager.setupCommands = ''
      # Staircase messages fix
      ${pkgs.coreutils}/bin/stty -F /dev/console opost onlcr
    '';

    displayManager.lightdm = {
      extraConfig = ''
        [Seat:*]
        # Hide cursor
        greeter-setup-script=${lightdmGreeterSetup}
        # Move cursor to center and show it
        session-setup-script = ${lightdmSessionSetup}
      '';

      greeters.mini = {
        enable = true;
        user = users.main.name;
        extraConfig = ''
        [greeter]
        show-password-label = false
        password-label-text = Password:
        invalid-password-text = Invalid Password
        show-input-cursor = true
        # "left", "center", or "right"
        password-alignment = center
        password-input-width = 32
        show-image-on-all-monitors = false
        show-sys-info = false

        [greeter-hotkeys]
        mod-key = meta
        shutdown-key = s
        restart-key = r
        hibernate-key = h
        suspend-key = u
        session-key = e

        [greeter-theme]
        font = "Monospace sans-serif"
        font-size = 1.1em
        font-weight = regular
        font-style = normal
        text-color = "${colors.pureWhite}"
        error-color = "${colors.red}"
        background-image = ""
        background-image-size = auto
        background-color = "${colors.pureBlack}"
        window-color = "${colors.pureBlack}"
        border-color = "${colors.pureBlack}"
        border-width = 0px
        layout-space = 0
        password-character = -1
        password-color = "${colors.pureWhite}"
        password-background-color = "${colors.pureBlack}"
        password-border-radius = 0em
        '';
      };
    };
  };
}
