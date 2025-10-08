autoload -Uz compinit
compinit

# Prompt
PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# Aliases
alias vim='nvim'
alias vimnew='NVIM_APPNAME=nvim_new nvim'
alias :q='exit'
alias la='ls -A'
alias ls='ls --color=auto'
alias cd='z'
alias cdd='builtin cd'

# Exports
export HUSKY=0

# Add custom bin directory to PATH
export PATH="$HOME/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

eval "$(zoxide init zsh)"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH=~/Library/Android/sdk/platform-tools:/opt/homebrew/opt/openjdk@17/bin:/Users/macd/.rbenv/shims:/Users/macd/.rbenv/bin:/Users/macd/.nvm/versions/node/v20.19.2/bin:/Users/macd/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/opt/homebrew/bin:/Users/macd/.rbenv/shims:/Users/macd/.rbenv/bin:/Users/macd/.nvm/versions/node/v20.19.2/bin:/Users/macd/bin
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
