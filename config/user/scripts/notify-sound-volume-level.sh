#!/bin/sh

NAME=$(pactl get-default-sink)
DEVICE=$(
  pactl list sinks \
    | awk "/$NAME$/,/Description/" \
    | sed -n "s/\s*Description: //p"
)
MUTED=$(
  pactl get-sink-mute $NAME \
    | sed "s/Mute: //" \
    | sed "s/no//" \
    | sed "s/yes/, muted/"
)
# muted
VOLUME=($(
  pactl get-sink-volume $(pactl get-default-sink) \
    | grep -o "[^ ]*%" \
    | sed "s/[^0-9]//g"
))
VOLUME_AVRG=$(((${VOLUME[0]} + ${VOLUME[1]}) / 2))

BODY="Sound volume $VOLUME_AVRG%"

notify-send "$DEVICE" "$BODY$MUTED" -h string:synchronous:volume
