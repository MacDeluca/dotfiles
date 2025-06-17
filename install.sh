#! /bin/bash

# NOTE: Fresh machine installation script

# Homebrew
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

# Install linux dependencies
sudo apt install stow
sudo apt install jq
sudo apt install npm
sudo apt install ripgrep
sudo apt install bat
# makes bat binary usable (clash with existing package)
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install dependencies for syncing WSL and Windows clipboards
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
sudo apt install unzip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /bin

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add docker to the user group
sudo usermod -aG docker $USER
newgrp docker

# Lazy Docker
brew install jesseduffield/lazydocker/lazydocker

# Note: Need to investigate putting this in the correct file location ie: .config/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install catppuccin theme
mkdir -p "$HOME/dotfiles/bat/.config/bat/themes"
wget -P "$HOME/dotfiles/bat/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$HOME/dotfiles/bat/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$HOME/dotfiles/bat/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$HOME/dotfiles/bat/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

# rebuild cache
bat cache --build

echo "--theme="Catppuccin Mocha"" > "$HOME/dotfiles/bat/.config/bat/config"

# nvm - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20
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
./stow.sh

# source bash configuration
source ~/.bashrc


