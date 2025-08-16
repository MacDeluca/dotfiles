# Prompt
PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# Aliases
alias vim=nvim
alias :q=exit
alias la='ls -A'
alias ls='ls --color=auto'

# Exports
export HUSKY=0

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
