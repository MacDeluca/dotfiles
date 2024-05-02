#! /bin/bash

# NOTE: Fresh machine installation script

# stow - symlink manager
sudo apt-get install stow

# nvm - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm use 18

# fzf - cli fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# neovim
# make download directory if doesn't already exist
mkdir -p ~/Downloads
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz --output-dir ~/Downloads
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf ~/Downloads/nvim-linux64.tar.gz

# remove bashrc (its included in dotfiles)
rm ~/.bashrc

# symlink files and directories with stow
./link.sh

# source bash configuration
source ~/.bashrc


