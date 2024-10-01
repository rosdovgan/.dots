#!/bin/sh

sudo nixos-rebuild dry-build --flake "$ROOT"#main
