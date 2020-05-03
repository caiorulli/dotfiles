export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export TERMINAL=alacritty

# Gnome keyring setup
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Hub setup
if type hub > /dev/null; then
	eval "$(hub alias -s)"
fi

# Direnv setup
if type direnv > /dev/null; then
	eval "$(direnv hook zsh)"
fi

# Adding custom functions
objetivo() {
  echo "Meu objetivo é a conquista!!!"
}

# Adding quintoandar functions
[[ -s "$HOME/.quintoandar.zsh" ]] && source "$HOME/.quintoandar.zsh"

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"

# fzf setup
[ -s "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"
[ -s "/usr/share/fzf/completion.zsh" ] && source "/usr/share/fzf/completion.zsh"

# sdkman setup
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

