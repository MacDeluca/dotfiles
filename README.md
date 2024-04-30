# .Dotfiles

## Whats included?
Pure config files.
ie: neovim config, .bashrc, .gitconfig etc

## What's not included?
Packages without configuration. ie: .fzf / .nvm / .npm

## What's a `Symlink`?
Allows files to be stored in multiple directories at once.
Essentially creates a live copy of a file.

## How to use?
### .New machine?
Packages and dependencies are installed via the ./install.sh script.
Install dependencies and symlink configuration files.
```bash
./install.sh && ./source.sh
```
### Current machine?
Assuming all necessary packages are installed.
Symlink and source configuration files.
```bash
./source.sh
```
