typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR=$HOME/.config/zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/history

export EDITOR="nvim"

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
export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME/xmonad"
export XMONAD_DATA_HOME="$XDG_DATA_HOME/xmonad"
export XMONAD_CACHE_HOME="$XDG_CACHE_HOME/xmonad"

# Create xmonad directories if needed be
if [ ! -d "$XDG_DATA_HOME/xmonad" ]; then
  mkdir "$XDG_DATA_HOME/xmonad";
fi

if [ ! -d "$XDG_CACHE_HOME/xmonad" ]; then
  mkdir "$XDG_CACHE_HOME/xmonad";
fi
