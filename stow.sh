#! /bin/bash

# get dotfile directories to symlink with stow
# skip windows we will handle seperately
STOW=$(ls -d */ | grep -v '^windows' | sed 's#/##' | tr '\n' ' ')

echo "Checking for symlink issues with linux files..." &&

# dry run to check for errors
echo "$STOW" | xargs stow -n -v 2 &&

# if successful run stow to symlink
echo "$STOW" | xargs stow &&

echo "Stow symlink successful!"

# copy the windows files to the correct location
# windows does not allow symlinks to WSL

#cp -f windows/.wslconfig /mnt/c/Users/MacD/.wslconfig &&
#cp -f windows/caps_esc.reg /mnt/c/Users/MacD/caps_esc.reg &&
#cp -f windows/.wezterm.lua /mnt/c/Users/MacD/.wezterm.lua

