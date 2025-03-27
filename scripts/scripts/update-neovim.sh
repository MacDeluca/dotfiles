#!/bin/bash

# Download the latest Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

# Make the AppImage executable
chmod u+x nvim-linux-x86_64.appimage

# Create the directory /opt/nvim
mkdir -p /opt/nvim

# Move the AppImage to /opt/nvim/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
