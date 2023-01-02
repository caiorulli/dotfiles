{ config, pkgs, ... }:

let
  dotfilesDir = "/etc/dotfiles";
in {
  home = {
    stateVersion = "22.11";
    enableNixpkgsReleaseCheck = true;

    username = "caio";
    homeDirectory = "/home/caio";

    packages = import ./deps.nix { pkgs = pkgs; } ++ import ./doom/deps.nix { pkgs = pkgs; };

    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

    sessionVariables = {
      EDITOR = "nvim";
      MAILDIR = "${config.home.homeDirectory}/Mail";
      LESSHISTFILE = "-";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/pass";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      CABAL_CONFIG = "${config.xdg.configHome}/cabal/config";
      CABAL_DIR = "${config.xdg.cacheHome}/cabal";
      STACK_ROOT = "${config.xdg.dataHome}/stack";
      NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      PSQL_HISTORY = "${config.xdg.cacheHome}/pg/psql_history";
      PROTON_LOG_DIR = "${config.xdg.dataHome}/proton_log";
      XMONAD_CONFIG_HOME = "${config.xdg.configHome}/xmonad";
      XMONAD_DATA_HOME = "${config.xdg.dataHome}/xmonad";
      XMONAD_CACHE_HOME = "${config.xdg.cacheHome}/xmonad";
      MBSYNC_CONFIG = "${config.xdg.configHome}/isync/mbsyncrc";
      PROTON_LOG = 1;
      GOPATH = "${config.home.homeDirectory}/Software/go";
      CLJ_CONFIG = "${dotfilesDir}/home/clojure";
    };

    shellAliases = {
      doom = "${config.xdg.configHome}/emacs/bin/doom";
      fehbg = "feh --randomize --bg-scale";
    };

    file = {
      # xmonad
      "${config.xdg.configHome}/xmonad/xmonad.hs".source =
        ../modules/xmonad/xmonad.hs;
      "${config.xdg.configHome}/xmobar/xmobarrc".source =
        ../modules/xmonad/xmobarrc;

      # emacs
      "${config.xdg.configHome}/doom".source = ./doom;

      # misc
      "${config.xdg.configHome}/isync/mbsyncrc".source = ./misc/mbsyncrc;
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      defaultKeymap = "emacs";

      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        save = 1000000000;
        size = 1000000000;
      };
    };

    tmux = {
      enable = true;
      # customPaneNavigationAndResize = true;
      extraConfig = ''
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

set -g history-limit 10000
'';
    };

    git = {
      enable = true;
      userName = "Caio Rulli Thomaz";
      userEmail = "caio@crthomaz.com.br";

      aliases = {
        s = "status";
      };

      extraConfig = {
        core.editor = "nvim";
        pull.rebase = false;
        init.defaultBranch = "deck";
      };

      difftastic.enable = true;
    };

    ssh = {
      enable = true;
      extraOptionOverrides = { "AddKeysToAgent" = "yes"; };
    };

    alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        window = {
          padding = {
            x = 5;
            y = 5;
          };
        };
        font = {
          normal.family = "Fantasque Sans Mono";
          size = 11.0;
        };
        colors = {
          primary = {
            background = "0x2E3440";
            foreground = "0xD8DEE9";
          };
          cursor = {
            text = "0x2E3440";
            cursor = "0xD8DEE9";
          };
          normal = {
            black = "0x3B4252";
            red = "0xBF616A";
            green = "0xA3BE8C";
            yellow = "0xEBCB8B";
            blue = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan = "0x88C0D0";
            white = "0xE5E9F0";
          };
          bright = {
            black = "0x4C566A";
            red = "0xBF616A";
            green = "0xA3BE8C";
            yellow = "0xEBCB8B";
            blue = "0x81A1C1";
            magenta = "0xB48EAD";
            cyan = "0x8FBCBB";
            white = "0xECEFF4";
          };
        };
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    newsboat = {
      enable = true;
      autoReload = true;
      extraConfig = ''
        bind-key j next
        bind-key k prev
        bind-key J next-feed
        bind-key K prev-feed
        bind-key j down article
        bind-key k up article
        bind-key J next article
        bind-key K prev article
      '';
      urls = [{
        tags = [ "news" ];
        url = "https://clojure.org/feed.xml";
      }];
    };

    emacs = {
      enable = true;
      package = pkgs.emacsNativeComp;
    };

    neovim = {
      enable = true;
      extraConfig = ''
        set nocompatible
        set ruler
        set laststatus=2
        set showcmd
        set showmode
        set number relativenumber
        set incsearch
        set ignorecase
        set smartcase
        set hlsearch
        set shortmess+=Ic
        set splitbelow splitright
        set wildmode=longest,list
        set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
        set cmdheight=2
        set nobackup
        set nowritebackup
        set hidden
        set updatetime=300
        set signcolumn=yes

        let mapleader=" "

        nnoremap <leader>n :NERDTreeToggle<CR>
        nnoremap <leader>. :Files<CR>
        nnoremap <leader><space> :GFiles<CR>
        nnoremap <leader>b :Buffers<CR>
        nnoremap <leader>h :History<CR>
        nnoremap <leader>f :Rg<CR>
      '';

      plugins = with pkgs.vimPlugins; [
        {
          plugin = nord-vim;
          config = "colorscheme nord";
        }
        nerdtree
        vim-fugitive
        vim-gitgutter
        vim-commentary
        fzf-vim
        vim-polyglot
        {
          plugin = ale;
          config = ''
            let g:ale_fixers = { 'javascript': ['eslint'], 'rust': ['rustfmt'] }
            let g:ale_fix_on_save = 1
          '';
        }
        vim-fireplace
        vim-parinfer
      ];

      viAlias = true;
      vimAlias = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      settings.battery.disabled = true;
    };

    bat.enable = true;
    bottom.enable = true;
    fzf.enable = true;
    jq.enable = true;
    gh.enable = true;
    go.enable = true;

    home-manager.enable = true;
  };

  services = {
    syncthing.enable = true;
  };
}
