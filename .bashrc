#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Aliases
alias ls='ls --color=auto'
alias l='ls -la'
alias gst='git status'
alias gco='git checkout'
alias doom='~/.emacs.d/bin/doom'
alias fehbg='feh --randomize --bg-scale'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias mvn='mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml'

PS1='\n\[\e[34m\]<== \u@\h \W ==>\[\e[00m\]\n\$ '

# Keep empty for UNLIMITED POWER I mean unlimited history
HISTSIZE= 
HISTFILESIZE=

export HISTFILE="$XDG_DATA_HOME/bash/history"
export LESSHISTFILE=-
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# Direnv setup
if type direnv > /dev/null; then
    eval "$(direnv hook bash)"
fi

# nvm setup
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"

# fzf setup
[ -s "/usr/share/fzf/key-bindings.bash" ] && source "/usr/share/fzf/key-bindings.bash"
[ -s "/usr/share/fzf/completion.bash" ] && source "/usr/share/fzf/completion.bash"

powerwolf() {
  echo "Meu objetivo é a conquista!" | cowsay | lolcat
  sleep 1
  poweroff
}
