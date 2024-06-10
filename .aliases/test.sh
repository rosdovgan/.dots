#!/bin/sh
ROOT=$(dirname "$( cd "$( dirname "$0" )" && pwd )")
sudo nixos-rebuild test --flake "$ROOT"#main
