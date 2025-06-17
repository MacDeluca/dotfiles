# .Dotfiles

## How to Use?

1. Fresh Install Packages and Dependencies:
Run the install.sh script to automate the installation of required packages and dependencies.
```bash
./install.sh
```
2. Symlink Dotfiles:
Once dependencies are installed, symlink dotfiles to your home directory.
```bash
# To dry run and check for errors
stow -n .
# To execute and symlink
stow .
```

## Adding Additional Dotfiles:
1. Move Existing Config Files:
To add additional dotfiles, move existing config files to the exact location in the dotfiles directory.
```bash
# symlink file ~/.bashrc <--> ~/dotfiles/bash/.bashrc
mv ~/.bashrc ~/dotfiles/bash/.bashrc
# symlink dir ~/.config/nvim <--> ~/dotfiles/nvim/.config/nvim
mv ~/.config/nvim ~/dotfiles/nvim/.config
```

## Package Dependencies
- [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html): GNU Stow is used for managing symlinks.

## Whats included?
This repository contains pure configuration files and directories for various applications, including:
- Nvim - Neovim terminal code editor
- Bash - Bash terminal configurations and aliases
- Tmux - Tmux configurations
- Git - Git configurations and preferences

## What's not included?
Packages without configuration are excluded from this repository. Examples include:
- .fzf
- .nvm
- .npm

## What's a `Symlink`?
A symlink (symbolic link) is a file that points to another file or directory. It allows files to be stored in multiple directories simultaneously, providing a convenient way to manage configurations across different locations.


## Additional commands
- Swap caps with esc (for vim) - Run in powershell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout" -Name "Scancode Map" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x01,0x00,0x3A,0x00,0x3A,0x00,0x01,0x00,0x00,0x00,0x00,0x00))

