# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias cat='bat'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ld='lazydocker'

# scripts
alias gd='. gd'
alias gdls='cat ~/dotfiles/scripts/scripts/gd-config.txt'

# configs
alias vimconfig="cd ~/dotfiles/nvim/.config/nvim && vim ."
alias alacrittyconfig="vim /mnt/c/Users/MacD/AppData/Roaming/alacritty"
alias tmuxconfig="vim ~/dotfiles/tmux/.config/tmux/tmux.conf"
alias bashconfig="vim ~/dotfiles/bash/.bashrc && source ~/.bashrc"
alias aliasconfig="vim ~/dotfiles/bash/.bash_aliases && source ~/.bashrc"

# neovim
alias vim='nvim'
alias v='vim .'

# tmux
alias tmux='tmux -u'
alias ta='tmux new-session -A -s'
alias tk='tmux kill-session -t'
alias tn='session'
alias :q="exit"

# oc
oc_port_forward() {
  oc get pods | tail -n +2 | fzf | cut -d' ' -f1 | xargs -I {} oc port-forward {} "$1":5432
}

alias oc-projects="oc get projects| tail -n +2 | fzf | cut -d' ' -f1 | xargs oc project"
alias oc-pf="oc_port_forward"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
