#!/bin/sh

runningConkys=$(pidof -S $'\n' conky)
if [[ -z "$runningConkys" ]]; then
    conky -q  &
else
    echo "$runningConkys" | xargs -n 1 kill -15
fi


