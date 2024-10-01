#!/bin/sh

sudo nix flake update "$ROOT"
sudo nixos-rebuild switch --flake "$ROOT"#main
