#!/bin/bash

# Script to install Yay on Steam Deck
# Based on: https://www.reddit.com/r/SteamDeck/comments/10yyjw8/cloudflare_warp_vpn_for_your_steamdeck_updated/

# Disable read-only mode
sudo steamos-readonly disable

sudo pacman -Syu base-devel

# Install additional dependencies
sudo pacman -Syu holo-rel/linux-headers
sudo pacman -Syu linux-neptune-headers
sudo pacman -Syu holo-rel/linux-lts-headers
sudo pacman -Syu git
sudo pacman -Syu glibc
sudo pacman -Syu gcc
sudo pacman -Syu gcc-libs
sudo pacman -Syu fakeroot
sudo pacman -Syu linux-api-headers
sudo pacman -Syu libarchive
sudo pacman -S libalpm

# Clone and install Yay
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R deck ./yay
cd yay
makepkg -si

# Reminder to undo unmerge if used
echo "If you used 'sudo systemd-sysext unmerge' earlier, run the following command:"
echo "sudo systemd-sysext merge"

echo "Yay has been installed successfully!"
