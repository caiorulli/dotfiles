# Zsh setup
autoload -Uz promptinit compinit
promptinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

prompt_mytheme_setup() {
  PS1="(%F{green}%M%f/%F{blue}%n%f %B%~%b)> "
}

prompt_themes+=( mytheme )
prompt mytheme

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY

bindkey -e

system_type=$(uname -s)


# Aliases
alias l='ls -la --color'
alias gst='git status'
alias gco='git checkout'
alias doom='~/.emacs.d/bin/doom'
alias fehbg='feh --randomize --bg-scale'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias mvn='mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml'
alias mbsync='mbsync -c "$XDG_CONFIG_HOME"/isync/mbsyncrc'
alias csi='chicken-csi'
alias csc='chicken-csc'

# fzf setup
[ -s "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"
[ -s "/usr/share/fzf/completion.zsh" ] && source "/usr/share/fzf/completion.zsh"

# direnv setup
eval "$(direnv hook zsh)"

# ghcup setup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# scripts setup
[ -f "$HOME/Scripts/shell.zsh" ] && source "$HOME/Scripts/shell.zsh"

if [ "$system_type" = "Darwin" ]; then
  # sdkman setup
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  
  # nvm setup
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

else
  # Zsh plugins
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

  # nvm setup
  [ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"
fi

# functions
update-pkglist() {
  pacman -Qqe > .config/pkglist.txt
}

