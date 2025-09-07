{
  config,
  pkgs,
  ...
}: {
  runtimeInputs = with pkgs; [
    coreutils
    wayfreeze
    slurp
    grim
    wl-clipboard
  ];

  text = let
    screenshotsDir = config.xdg.userDirs.pictures + "/Screenshots";
  in ''
    wayfreeze & PID=$!;
    sleep .1;
    if region=$(slurp); then
      grim -g "$region" - \
        | tee ${screenshotsDir}/"$(date +"%Y-%m-%d_%H-%M-%S").png" \
        | wl-copy;
    fi
    kill $PID
  '';
}
