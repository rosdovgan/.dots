{ pkgs, colors, ... }: {
  home.packages = with pkgs; [ (conky.override ({ nvidiaSupport = true; })) ];

  xdg.configFile."conky/conky.conf".text = ''
    conky.config = {
        alignment = "middle_right",
        background = false,
        border_width = 1,
        cpu_avg_samples = 2,
        default_outline_color = "white",
        default_shade_color = "white",
        double_buffer = true,
        draw_borders = false,
        draw_graph_borders = true,
        draw_outline = false,
        draw_shades = false,
        extra_newline = false,
        font = "Monospace sans-serif:size=12",
        gap_x = 0,
        gap_y = 0,
        minimum_height = 5,
        minimum_width = 5,
        net_avg_samples = 2,
        no_buffers = true,
        out_to_console = false,
        out_to_ncurses = false,
        out_to_stderr = false,
        out_to_x = true,
        own_window = true,
        own_window_class = "Conky",
        own_window_type = "utility",
        own_window_transparent = false,
        own_window_argb_visual = true,
        own_window_argb_value = 145,
        show_graph_range = false,
        show_graph_scale = false,
        stippled_borders = 0,
        update_interval = 1.0,
        uppercase = false,
        use_xft = true,
        pad_percents = 3,
        use_spacer = "left",
        top_name_width = 15,
        own_window_hints = 'undecorated,sticky,skip_taskbar,skip_pager,below',
        own_window_colour = "${colors.black}",
        default_color = "${colors.pureWhite}",
        color0 = "${colors.lightGray}",
        color1 = "${colors.lighterGray}",
    }

    conky.text = [[
    ''${color0}Info:$color $nodename $kernel $machine
    ''${color0}Uptime:$color $uptime
    ''${color0}Processes:$color ''${running_processes}/''${processes}
    $hr                                                                   
    ''${color0}CPU 1:$color ''${cpu cpu1}% ''${hwmon coretemp temp 2}°C $alignr ''${color0}CPU 2:$color ''${cpu cpu2}% ''${hwmon coretemp temp 3}°C 
    ''${color0}CPU 3:$color ''${cpu cpu3}% ''${hwmon coretemp temp 4}°C $alignr ''${color0}CPU 4:$color ''${cpu cpu4}% ''${hwmon coretemp temp 5}°C 
    ''${color0}CPU 5:$color ''${cpu cpu5}% ''${hwmon coretemp temp 6}°C $alignr ''${color0}CPU 6:$color ''${cpu cpu6}% ''${hwmon coretemp temp 7}°C 
    ''${color0}Frequency:$color ''${freq}MHz
    $hr
    ''${color0}RAM: $color $mem/$memmax
    ''${color0}Swap:$color $swap/$swapmax
    $hr
    ''${color0}Nvidia GPU:$color ''${nvidia gpuutil}% ''${nvidia gputemp}°C 
    ''${color0}Frequency: $color ''${nvidia gpufreqcur}MHz
    $hr
    ''${color}Name                 $alignr PID    CPU  MEM 
    ''${color1}''${top name 1} $alignr ''${top pid 1} ''${top cpu 1} ''${top mem 1} 
    ''${color1}''${top name 2} $alignr ''${top pid 2} ''${top cpu 2} ''${top mem 2} 
    ''${color1}''${top name 3} $alignr ''${top pid 3} ''${top cpu 3} ''${top mem 3} 
    ''${color1}''${top name 4} $alignr ''${top pid 4} ''${top cpu 4} ''${top mem 4} 
    ''${color1}''${top name 5} $alignr ''${top pid 5} ''${top cpu 5} ''${top mem 5} 
    ]]
  '';
}
