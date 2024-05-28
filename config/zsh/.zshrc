bindkey "''${key[Up]}" up-line-or-search
bindkey '^ ' autosuggest-accept

bindkey -M vicmd '0' backward-char
bindkey -M vicmd 'H' beginning-of-line

bindkey -M vicmd '$' forward-char
bindkey -M vicmd 'L' end-of-line
