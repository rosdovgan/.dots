#!/bin/sh

sudo nix flake update --flake "$ROOT"
sudo nixos-rebuild switch --flake "$ROOT"#main
