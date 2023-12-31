#!/bin/sh
ROOT="$(dirname $(dirname $(realpath ${BASH_SOURCE:-$0})))"
sudo nixos-rebuild switch --flake $ROOT#main
