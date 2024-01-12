#!/bin/sh

SUMMARY="Screen"
BODY="Brightness: $(brillo | sed "s/\.[0-9]*//")%"

notify-send "$SUMMARY" "$BODY" -h string:synchronous:brightness
