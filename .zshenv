typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH
export PATH="$HOME/.cache/cabal/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000

export EDITOR="nvim"

export LESSHISTFILE=-
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_CACHE_HOME/cabal"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PROTON_LOG_DIR="$XDG_DATA_HOME/proton_log"
export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME/xmonad"
export XMONAD_DATA_HOME="$XDG_DATA_HOME/xmonad"
export XMONAD_CACHE_HOME="$XDG_CACHE_HOME/xmonad"
export PROTON_LOG=1
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
