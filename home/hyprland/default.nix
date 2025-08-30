{
  config,
  pkgs,
  colors,
  ...
}: {
  home.packages = with pkgs; [
    libnotify
    wl-clipboard
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = let
      wpctl = "${pkgs.wireplumber}/bin/wpctl";
      brillo = "${pkgs.brillo}/bin/brillo";
      playerctl = "${pkgs.playerctl}/bin/playerctl";

      m = "SUPER";
      terminal = "${pkgs.foot}/bin/foot";

      userScriptPath = name: "${config.xdg.configHome}/user/scripts/${name}.sh";

      notifyBrightness = x: "${x} && ${userScriptPath "notify-brightness-level"}";
      brightnessUp = notifyBrightness "${brillo} -A 25";
      brightnessDown = notifyBrightness "${brillo} -U 25";

      notifySound = x: "${x} && ${userScriptPath "notify-sound-volume-level"}";
      raiseVolume = notifySound "${wpctl} set-volume @DEFAULT_SINK@ 10%+";
      lowerVolume = notifySound "${wpctl} set-volume @DEFAULT_SINK@ 10%-";
      muteVolume = notifySound "${wpctl} set-mute @DEFAULT_SINK@ toggle";

      audioPlay = "${playerctl} play";
      audioStop = "${playerctl} pause";
      audioNext = "${playerctl} next";
      audioPrev = "${playerctl} previous";

      screenshot = let
        wayfreeze = "${pkgs.wayfreeze}/bin/wayfreeze";
        slurp = "${pkgs.slurp}/bin/slurp";
        grim = "${pkgs.grim}/bin/grim";
        wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        tee = "${pkgs.coreutils}/bin/tee";
      in
        pkgs.writeScript "wl-screenshot" ''
          ${wayfreeze} & PID=$!;
          sleep .1;
          ${slurp} | ${grim} -g - - | ${tee} ~/Pictures/$(date +%s).png | ${wl-copy};
          kill $PID
        '';
    in
      with colors.rgbHex; ''
        # Refer to the wiki for more information.
        # https://wiki.hypr.land/Configuring/

        ### MONITORS ###

        monitor=,preferred,auto,1

        ### AUTOSTART ###

        # exec-once = waybar

        ### ENVIRONMENT VARIABLES ###

        env = XCURSOR_SIZE,16
        env = XCURSOR_THEME,Adwaita

        ### PERMISSIONS ###

        # ecosystem {
        #   enforce_permissions = 1
        # }

        # permission = /usr/(bin|local/bin)/grim, screencopy, allow
        # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
        # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow


        ### LOOK AND FEEL ###

        general {
          gaps_in = 0
          gaps_out = 0
          border_size = 0
          allow_tearing = false
          layout = master
        }

        decoration {
          active_opacity = 1.0
          inactive_opacity = 0.75
          shadow:enabled = false
          blur:enabled = false
        }

        animations:enabled = false

        master {
          mfact = 0.6
        }

        misc {
          force_default_wallpaper = 0
          disable_hyprland_logo = true
          background_color = ${black}
        }

        ### INPUT ###

        input {
          kb_layout = ${config.home.keyboard.layout}
          kb_variant =
          kb_model =
          kb_options = ${builtins.concatStringsSep "," config.home.keyboard.options}
          kb_rules =

          repeat_rate = 40
          repeat_delay = 200
          follow_mouse = 0
          mouse_refocus = false
        }

        cursor {
          enable_hyprcursor = false
          no_warps = true
        }

        ### KEYBINDINGS ###

        bind = ${m}, return, exec, ${terminal}
        bind = ${m}, D, exec, ${terminal} -D "$DOTS_DIR"
        # bind = ${m}, N, exec, ${terminal} ${userScriptPath "open-notes"}
        bind = ${m}, M, exec, ${userScriptPath "toggle-conky"}
        bind = , print, exec, ${screenshot}
        bind = ${m}, Q, killactive,
        bind = ${m} SHIFT, Q, exit,
        bind = ${m}, space, togglefloating,
        bind = ${m}, F, fullscreen, 1
        bind = ${m} SHIFT, F, fullscreen, 0
        bind = ${m}, P, exec, ${pkgs.fuzzel}/bin/fuzzel

        bind = ${m}, H, layoutmsg, cycleprev
        bind = ${m}, L, layoutmsg, cyclenext
        bind = ${m} SHIFT, tab, layoutmsg, cycleprev
        bind = ${m}, tab, layoutmsg, cyclenext

        bind = ${m} SHIFT, H, swapnext, prev
        bind = ${m} SHIFT, L, swapnext,

        bind = ${m} CTRL, H, resizeactive, -100 0
        bind = ${m} CTRL, L, resizeactive, 100 0
        bind = ${m} CTRL, J, resizeactive, 0 100
        bind = ${m} CTRL, K, resizeactive, 0 -100

        bind = ${m}, 1, workspace, 1
        bind = ${m}, 2, workspace, 2
        bind = ${m}, 3, workspace, 3
        bind = ${m}, 4, workspace, 4
        bind = ${m}, 5, workspace, 5
        bind = ${m}, 6, workspace, 6
        bind = ${m}, 7, workspace, 7
        bind = ${m}, 8, workspace, 8
        bind = ${m}, 9, workspace, 9

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = ${m} SHIFT, 1, movetoworkspace, 1
        bind = ${m} SHIFT, 2, movetoworkspace, 2
        bind = ${m} SHIFT, 3, movetoworkspace, 3
        bind = ${m} SHIFT, 4, movetoworkspace, 4
        bind = ${m} SHIFT, 5, movetoworkspace, 5
        bind = ${m} SHIFT, 6, movetoworkspace, 6
        bind = ${m} SHIFT, 7, movetoworkspace, 7
        bind = ${m} SHIFT, 8, movetoworkspace, 8
        bind = ${m} SHIFT, 9, movetoworkspace, 9
        bind = ${m} SHIFT, 0, movetoworkspace, 10

        # Example special workspace (scratchpad)
        # bind = ${m}, S, togglespecialworkspace, magic
        # bind = ${m} SHIFT, S, movetoworkspace, special:magic

        bind = ${m}, comma, workspace, e-1
        bind = ${m}, period, workspace, e+1

        bind = ${m}, mouse_up, workspace, e-1
        bind = ${m}, mouse_down, workspace, e+1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = ${m}, mouse:272, movewindow
        bindm = ${m}, mouse:273, resizewindow

        # Laptop multimedia keys for volume and LCD brightness
        bindel = ,XF86AudioRaiseVolume, exec, ${raiseVolume}
        bindel = ,XF86AudioLowerVolume, exec, ${lowerVolume}
        bindl = ,XF86AudioMute, exec, ${muteVolume}
        bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bindel = ,XF86MonBrightnessUp, exec, ${brightnessUp}
        bindel = ,XF86MonBrightnessDown, exec, ${brightnessDown}
        bindl = ,XF86PowerOff, dpms, toggle

        # Requires playerctl
        bindl = , XF86AudioNext, exec, ${audioNext}
        bindl = , XF86AudioPause, exec, ${audioStop}
        bindl = , XF86AudioPlay, exec, ${audioPlay}
        bindl = , XF86AudioPrev, exec, ${audioPrev}

        ### WINDOWS AND WORKSPACES ###

        # Ignore maximize requests from apps. You'll probably like this.
        # windowrule = suppressevent maximize, class:.*

        # Fix some dragging issues with XWayland
        windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
      '';
  };

  programs.hyprlock = let
    transparent = "rgba(00000000)";
  in {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      animations.enabled = false;

      background = with colors.rgbHex; [
        {
          color = black;
          blur_passes = 0;
        }
      ];

      input-field = with colors.cssHex; [
        {
          size = "680, 50";
          position = "0, 0";
          dots_size = 0.5;
          fade_on_empty = false;
          font_color = with colors.rgbHex; white;
          inner_color = transparent;
          fail_color = transparent;
          check_color = transparent;
          placeholder_text = "";
          fail_text = "";
          outline_thickness = 0;
          shadow_passes = 0;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = let
      loginctl = "${pkgs.systemd}/bin/loginctl";
      hyprctl = "${pkgs.hyprland}/bin/hyprctl";
      lock = "${pkgs.hyprlock}/bin/hyprlock";
    in {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = lock;
        before_sleep_cmd = "${loginctl} lock-session";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${loginctl} lock-session";
        }
        {
          timeout = 600;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
