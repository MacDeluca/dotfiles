#!/bin/bash
#
# Author:   Mac Deluca
# Date:     20-08-23
# Purpose:  Helper script for launching common directories
# How to:   `gd .` OR `gd ~/dir`
#

# default to projects directory if no arg provided.
cd ${1:-~/projects}/

# select and change to directory
cd $(ls -d */ | fzf)
