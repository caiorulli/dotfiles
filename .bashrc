#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias l='ls -la'
alias gst='git status'
alias gco='git checkout'

PS1='\n\[\e[34m\]<== \u@\h \W ==>\[\e[00m\]\n\$ '

# Hub setup
if type hub > /dev/null; then
    eval "$(hub alias -s)"
fi

# Direnv setup
if type direnv > /dev/null; then
    eval "$(direnv hook bash)"
fi

# nvm setup
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"

# fzf setup
[ -s "/usr/share/fzf/key-bindings.bash" ] && source "/usr/share/fzf/key-bindings.bash"
[ -s "/usr/share/fzf/completion.bash" ] && source "/usr/share/fzf/completion.bash"
