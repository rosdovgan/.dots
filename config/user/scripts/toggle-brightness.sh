#!/bin/sh

if [ $(brillo) = "0.00" ]; then
  brillo -I
else
  brillo -O
  brillo -S 0
fi
