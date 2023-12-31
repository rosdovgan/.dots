#!/bin/sh

if [ "$1" = "" ]; then
  echo "Specify device"
  set -x
  lsblk
  set +x
  exit 1
fi

sudo parted /dev/$1 -- mklabel gpt
sudo parted /dev/$1 -- mkpart root ext4 512MB -17GB
sudo parted /dev/$1 -- mkpart swap linux-swap -17GB 100%
sudo parted /dev/$1 -- mkpart ESP fat32 1MB 512MB
sudo parted /dev/$1 -- set 3 esp on

sudo mkfs.ext4 -L nixos /dev/$1p1
sudo mkswap -L swap /dev/$1p2
sudo mkfs.fat -F 32 -n boot /dev/$1p3

sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/$1p2
