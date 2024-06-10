#!/bin/sh
ROOT=$(dirname "$( cd "$( dirname "$0" )" && pwd )")
sudo nixos-rebuild dry-build --flake "$ROOT"#main
