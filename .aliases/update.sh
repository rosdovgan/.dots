#!/bin/sh
ROOT="$(dirname $(dirname $(realpath ${BASH_SOURCE:-$0})))"
sudo nix flake update $ROOT
sudo nixos-rebuild switch --flake $ROOT#main
