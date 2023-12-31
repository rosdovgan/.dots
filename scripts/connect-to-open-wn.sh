#!/bin/sh

if [ "$1" = "" ]; then
  echo "Specify SSID"
  exit 1
fi

sudo systemctl start wpa_supplicant
wpa_cli
add_network
set_network 0 ssid "$1"
set_network 0 key_mgmt
enable_network 0 NONE
quit
