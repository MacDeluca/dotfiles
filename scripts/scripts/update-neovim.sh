#!/bin/bash

#
# Author:   Mac Deluca
# Date:     21-04-25
#
# Purpose:  Helper script for updating Neovim to the latest version
# Info:     This script will check if the current version of Neovim is up to date.
#           If not, it will download the latest version and swap it in /opt/nvim.
#
# How to:   `./update-neovim.sh`
#

# Check if currently running the latest version of Neovim
echo -e "Checking if Neovim is already up to date...\n"
nvim_version_raw=$(nvim --version || "NOT INSTALLED")
nvim_version=$($nvim_version_raw | head -n 1 | cut -d ' ' -f 2)
latest_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)

echo "Current Neovim version: $nvim_version"
echo -e "Latest Neovim version: $latest_version\n"

# If up to date, exit
[ "$nvim_version" == "$latest_version" ] && echo "Neovim is already up to date: $latest_version" && exit 0

# Download the latest Neovim AppImage
echo -e "Downloading the latest Neovim AppImage...\n"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

# Make the AppImage executable
chmod u+x nvim-linux-x86_64.appimage &&

# Create the directory /opt/nvim if it doesn't exist
sudo mkdir -p /opt/nvim &&

# Move the AppImage to /opt/nvim/nvim
echo -e "Moving the Neovim AppImage to /opt/nvim/nvim...\n" &&
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim &&

echo -e "Neovim has been updated to the latest version!\n" &&
nvim --version &&

exit 0
