#!/bin/sh
ROOT=$(dirname "$( cd "$( dirname "$0" )" && pwd )")
sudo nixos-rebuild switch --flake "$ROOT"#main
