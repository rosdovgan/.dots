{...}: {
  programs.mpv = {
    enable = true;
    config = {
      no-input-builtin-bindings = "";
    };
    bindings = {
      "q" = "quit";
      "Q" = "quit-watch-later";
      "p" = "show-progress";
      "ESC" = "set fullscreen no";
      "MBTN_LEFT_DBL" = "cycle fullscreen";
      "MBTN_BACK" = "playlist-prev";
      "MBTN_FORWARD" = "playlist-next";
      "WHEEL_UP" = "add volume 2";
      "WHEEL_DOWN" = "add volume -2";
      "f" = "cycle fullscreen";
      "space" = "cycle pause";
      "j" = "add volume -10";
      "k" = "add volume 10";
      "m" = "cycle mute";
      "h" = "seek -5";
      "l" = "seek 5";
      "H" = "seek -60";
      "L" = "seek 60";
      "," = "frame-back-step";
      "." = "frame-step";
      "Ctrl+n" = "playlist-next";
      "Ctrl+p" = "playlist-prev";
      "Shift+." = "add speed 0.2";
      "Shift+," = "add speed -0.2";
      "Ctrl+u" = "add chapter 1";
      "Ctrl+d" = "add chapter -1";
      "c" = "cycle sub";
      "Alt+a" = "cycle audio";
      "Alt+v" = "cycle video";
      "=" = "add sub-scale 0.1";
      "-" = "add sub-scale -0.1";
      "w" = "add video-pan-y 0.1";
      "s" = "add video-pan-y -0.1";
      "a" = "add video-pan-x 0.1";
      "d" = "add video-pan-x -0.1";
      "KP_ADD" = "add video-zoom 0.1";
      "KP_SUBTRACT" = "add video-zoom -0.1";
    };
  };
}
