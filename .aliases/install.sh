#!/bin/sh
ROOT="$(dirname $(dirname $(realpath ${BASH_SOURCE:-$0})))"
nix flake update --extra-experimental-features "nix-command flakes" \
  $ROOT#main
sudo nixos-install --flake $(dirname $0)#main
