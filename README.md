# .Dotfiles

## .Whats included?
Pure config files.
ie: neovim config, .bashrc, .gitconfig etc

## .What's not included?
Packages without configuration. ie: .fzf / .nvm / .npm

## .What's a `Symlink`?
Allows individual files and directories to be stored in multiple directories at once.
Creates two working copys of the file. This allows the config files to exist in a different directory,
then their usual home.

## .How to use?
### .New machine?
Packages and dependencies are installed via the ./install.sh script.

Install packages then symlink and source config files.
```bash
./install.sh && ./source.sh
```
### .Current machine?
Assuming all necessary packages are installed.

Symlink and source config files.
```bash
./source.sh
```
