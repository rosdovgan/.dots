{pkgs, ...}: {
  runtimeInputs = with pkgs; [
    procps
    coreutils
  ];

  text = ''
    PIDS=$(pgrep -f -x "$1" || true)

    if [[ -z "$PIDS" ]]; then
        echo "Starting: $1"
        nohup "$1" >/dev/null 2>&1 &
    else
        echo "Killing: $1"
        kill -15 "$PIDS"
    fi
  '';
}
