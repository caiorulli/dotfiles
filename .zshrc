export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export TERMINAL=alacritty

# Direnv setup
if type direnv > /dev/null; then
	eval "$(direnv hook zsh)"
fi

# nvm setup
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"

# fzf setup
[ -s "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"
[ -s "/usr/share/fzf/completion.zsh" ] && source "/usr/share/fzf/completion.zsh"

