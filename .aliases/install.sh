#!/bin/sh
ROOT=$(dirname "$( cd "$( dirname "$0" )" && pwd )")
nix flake update --extra-experimental-features "nix-command flakes" \
  "$ROOT"#main

sudo nixos-install --flake "$ROOT"#main
