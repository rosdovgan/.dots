#!/bin/sh
ROOT="$(dirname $(dirname $(realpath ${BASH_SOURCE:-$0})))"
sudo nixos-rebuild dry-build --flake $ROOT#main
