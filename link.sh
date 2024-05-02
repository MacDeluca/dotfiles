#! /bin/bash

# get dotfile directories to symlink with stow
STOW=$(ls -d */ | sed 's#/##' | tr '\n' ' ')

echo "Checking for symlink issues..." && \
# dry run to check for errors
echo "$STOW" | xargs stow -n && \

# if successful run stow to symlink
echo "$STOW" | xargs stow && echo "Stow symlink successful!"
