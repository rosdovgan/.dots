bindkey "''${key[Up]}" up-line-or-search
bindkey '^ ' autosuggest-accept

tmuxp() {
  local SESSION_NAME=$(basename "$PWD")
  SESSION_NAME="${SESSION_NAME//[^a-zA-Z0-9]/_}"
  TMUXP_SESSION_NAME=$SESSION_NAME command tmuxp "$@"
}

# bindkey -M vicmd '0' backward-char
# bindkey -M vicmd 'H' beginning-of-line

# bindkey -M vicmd '$' forward-char
# bindkey -M vicmd 'L' end-of-line
