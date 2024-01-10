#!/bin/sh

TEXT=$(xclip -out)

W=$(expr $(xrandr | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1) / 2)
H=$(expr $(xrandr | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2) / 2)

trans -b "$(xclip -out)" -t $1 \
  | yad --text-info --wrap --fixed --center --close-on-unfocus --no-buttons \
  --width=$W --height=$H
