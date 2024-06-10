#!/bin/sh
ROOT=$(dirname "$( cd "$( dirname "$0" )" && pwd )")
sudo nix flake update "$ROOT"
sudo nixos-rebuild switch --flake "$ROOT"#main
