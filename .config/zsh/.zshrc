# Zsh setup
autoload -Uz promptinit compinit
promptinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

prompt bart

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

bindkey -e

# Zsh plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias gst='git status'
alias gco='git checkout'
alias doom='~/.emacs.d/bin/doom'
alias fehbg='feh --randomize --bg-scale'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias mvn='mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml'
alias mbsync='mbsync -c "$XDG_CONFIG_HOME"/isync/mbsyncrc'

# nvm setup
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"

# fzf setup
[ -s "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"
[ -s "/usr/share/fzf/completion.zsh" ] && source "/usr/share/fzf/completion.zsh"

# direnv setup
eval "$(direnv hook zsh)"
