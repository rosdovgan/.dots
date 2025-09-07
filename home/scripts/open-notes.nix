{
  config,
  pkgs,
  ...
}: {
  runtimeInputs = with pkgs; [
    fd
    fzf
    coreutils
  ];

  text = let
    notesDir = config.xdg.userDirs.documents + "/Notes";
  in ''
    entry=$(fd . "${notesDir}" | sed "1i${notesDir}" | fzf) || exit 1

    if [ -d "$entry" ]; then
      cd "$entry" || exit 1
      exec "$EDITOR"
    else
      cd "$(dirname "$entry")" || exit 1
      exec "$EDITOR" "$(basename "$entry")"
    fi
  '';
}
