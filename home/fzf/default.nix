{
  config,
  pkgs,
  ...
}: {
  programs.fzf = let
    fd = "${pkgs.fd}/bin/fd";
    fdh = fd + " --hidden";
    keyBindings = "down:toggle+down,up:toggle+up,tab:down,shift-tab:up";
  in {
    enable = true;
    defaultCommand = fdh;
    defaultOptions = ["--bind \"${keyBindings}\"" "--color 16"];

    # Alt + T
    fileWidgetCommand =
      fdh
      + " . ${config.home.homeDirectory}";
    fileWidgetOptions = [];

    # Alt + C
    changeDirWidgetCommand =
      fdh
      + " --type d";
    changeDirWidgetOptions = [];
  };
}
