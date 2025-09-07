{...}: {
  text = ''
    if [ ! -f "./flake.nix" ]; then
        echo "Error: flake.nix not found in the current directory."
        exit 1
    fi

    if [ "$1" != "" ]; then
      ATTRIBUTE_PATH=".$1"
    else
      ATTRIBUTE_PATH=""
    fi

    echo "$ATTRIBUTE_PATH"
    FLAKE_PATH="$(pwd)"
    nix repl --expr "(builtins.getFlake \"$FLAKE_PATH\")$ATTRIBUTE_PATH"
  '';
}
