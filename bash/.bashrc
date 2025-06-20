# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable vim mode for terminal
#set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export TERM=tmux-256color

if [ -z "$TMUX" ]; then
  export TERM="xterm-256color"
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='\[\e[94;1m\]\w\[\e[0m\] \[\e[31;1m\]>\[\e[0m\] '
    #PS1='\[\e[32m\][${PS1_CMD1}]\[\e[0m\] \[\e[94;1m\]\w\[\e[0m\] \[\e[31;1m\]>\[\e[0m\] '
    #PS1='\[\e[32m\][${PS1_CMD1}]\[\e[0m\] \[\e[94;1m\]\w\[\e[0m\] \[\e[31;1m\]>\[\e[0m\] '
    PS1='\[\e[94;1m\]\w\[\e[0m\] \[\e[31;1m\]>\[\e[0m\] '
    #PROMPT_COMMAND='PS1_CMD1=$(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2)';
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1=$PS1
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

#https://github.com/neovim/neovim/blob/master/INSTALL.md
export PATH="$PATH:/opt/nvim/"

export PATH=$PATH:~/scripts:~/tools/openshift-developer-tools/bin:/opt/homebrew/bin:~/.local/bin
export PATH=/opt/homebrew/bin:$PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# . "$HOME/.cargo/env"

export PATH=$HOME/.dotnet/tools:$PATH

export PATH=$PATH:/usr/local/go/bin
[[ -e ~/bin ]] && export PATH=$PATH:~/bin

export ANDROID_HOME=/usr/lib/android-sdk
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
