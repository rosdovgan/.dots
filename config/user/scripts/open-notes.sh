#!/bin/sh

notes_dir="$HOME/Notes"

entry=$(fd . "$notes_dir" | sed "1i$notes_dir" | fzf) || exit 1

if [ -d "$entry" ]; then
  cd "$entry" || exit 1
  exec "$EDITOR"
else
  cd "$(dirname "$entry")" || exit 1
  exec "$EDITOR" "$(basename "$entry")"
fi
