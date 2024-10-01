#!/bin/sh

nix flake update --extra-experimental-features "nix-command flakes" \
  "$ROOT"#main

sudo nixos-install --flake "$ROOT"#main
