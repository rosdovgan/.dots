{
  pkgs,
  colors,
  ...
}: {
  home.packages = with pkgs; [
    nerd-fonts.noto
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.main = with colors.cssHex; let
      wpctl = "${pkgs.wireplumber}/bin/wpctl";
    in {
      layer = "top";
      position = "top";
      height = 30;
      output = ["eDP-1"];
      spacing = 15;

      modules-left = [
        "hyprland/workspaces"
        "privacy"
        "hyprland/window"
      ];
      modules-center = [];
      modules-right = [
        "network"
        "cpu"
        "memory"
        "battery"
        "backlight"
        "pulseaudio#sink"
        "pulseaudio#source"
        "hyprland/language"
        "clock"
        "tray"
      ];

      "hyprland/workspaces" = {
        persistent-workspaces."*" = 9;
      };

      network = {
        format = "<small>{bandwidthTotalBits}</small>";
        interval = 10;
      };

      cpu.format = "<span size=\"2000\"> </span>{usage}%";

      memory.format = "<span size=\"5000\"> </span>{used:0.1f}/{total:0.1f}<small>GiB</small>";

      battery = {
        interval = "10";
        format = "󰂄{capacity}%";
        format-discharging = "󰁹{capacity}%";
      };

      backlight = {
        format = "󰃠<span size=\"1000\"> </span>{percent}%";
        tooltip-format = "{percent}%";
        scroll-step = 25;
      };

      "pulseaudio#sink" = {
        format = "<span size=\"9000\"> </span>{volume}%";
        format-muted = "<span size=\"9000\"> </span>{volume}%";
        format-source = "󰍬 {volume}%";
        format-source-muted = "󰍭 {volume}%";
        scroll-step = 10;
        on-click-middle = "${wpctl} set-mute @DEFAULT_SINK@ toggle";
      };

      "pulseaudio#source" = {
        format = "{format_source}";
        format-muted = "{format_source}";
        format-source = "󰍬{volume}%";
        format-source-muted = "󰍭{volume}%";
        tooltip = false;
        on-scroll-up = "${wpctl} set-volume @DEFAULT_SOURCE@ 10%+";
        on-scroll-down = "${wpctl} set-volume @DEFAULT_SOURCE@ 10%-";
        on-click-middle = "${wpctl} set-mute @DEFAULT_SOURCE@ toggle";
      };

      clock = {
        format = "{:%a %d <span color=\"${lightBlue}\">%H:%M</span>}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "{}";
            days = "{}";
            weeks = "W{}";
            weekdays = "{}";
            today = "<span color='${lightBlue}'><b><u>{}</u></b></span>";
          };
        };
      };

      "hyprland/language" = {
        format = "{short}";
      };

      privacy = {
        transition-duration = 0;
        modules = [
          {
            type = "screenshare";
          }
          {
            type = "audio-out";
          }
          {
            type = "audio-in";
          }
        ];
        ignore-monitor = true;
      };

      tray = {
        spacing = 5;
        show-passive-items = true;
      };
    };
    style = with colors.cssHex; ''
      button, tooltip {
        border: none;
        border-radius: 0;
      }

      button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: inherit;
        transition: none;
      }

      window#waybar, .module, tooltip {
        background-color: ${blackT06};
      }

      window#waybar {
        font-size: 16px;
        font-family: Noto Nerd Font, monospace;
      }

      tooltip {
        font-size: 18px;
      }

      #workspaces button {
        color: ${grayS15};
        padding: 0 2px;
      }

      #workspaces button:not(.empty) {
        color: ${white};
      }

      #workspaces button.active {
        border-bottom: 2px solid ${lightBlue};
      }

      #privacy {
        color: ${lightRed};
      }

      #window {
        color: ${lightBlue};
      }

      #pulseaudio.sink.muted {
        color: ${lightRed};
      }

      #pulseaudio#source {
        color: ${lightBlue};
      }

      #pulseaudio.source.source-muted {
        color: ${lightRed};
      }
    '';
  };
}
