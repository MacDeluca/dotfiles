#! /bin/bash

# NOTE: Fresh machine installation script

# stow - symlink manager
sudo apt-get install stow

# nvm - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm use 18

# tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# fzf - cli fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# neovim - terminal code editor
mkdir -p ~/Downloads # create Download dir if doesn't already exist
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz --output-dir ~/Downloads
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf ~/Downloads/nvim-linux64.tar.gz

# remove bashrc (its included in dotfiles)
rm ~/.bashrc

# symlink files and directories with stow
./link.sh

# source bash configuration
source ~/.bashrc


