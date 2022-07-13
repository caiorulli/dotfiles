{ config, pkgs, ... }:

{
  home = {
    stateVersion = "22.05";
    enableNixpkgsReleaseCheck = true;

    username = "caio";
    homeDirectory = "/home/caio";

    packages = with pkgs; [
      # cli
      maim
      xh
      ripgrep
      fd
      du-dust
      neofetch
      cmatrix
      rsync
      unzip
      tig
      cowsay
      lolcat
      rtorrent
      mpv
      feh

      # applications
      slack
      discord
      tdesktop
      signal-desktop
      spotify
      thunderbird
      brave
      xterm

      # dev
      ansible
      clj-kondo
      clojure
      babashka
      nixfmt
      nixos-option
      ghc
      cabal-install
      haskell-language-server
      haskellPackages.hoogle
    ];

    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      EDITOR = "nvim";
      MAILDIR = "$HOME/Mail";
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
      GOPATH = "$HOME/Software/go";
    };

    shellAliases = {
      doom = "${config.xdg.configHome}/emacs/bin/doom";
      fehbg = "feh --randomize --bg-scale";
      telegram-desktop = "nixGL telegram-desktop";
    };

    file = {
      # clojure
      "${config.xdg.configHome}/clj-kondo/config.edn".source =
        ./clojure/clj_kondo.edn;
      "${config.xdg.configHome}/clojure/deps.edn".source = ./clojure/deps.edn;
      "${config.xdg.configHome}/clojure/tools".source = ./clojure/tools;

      # xmonad
      "${config.xdg.configHome}/xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
      "${config.xdg.configHome}/xmobar/xmobarrc".source = ./xmonad/xmobarrc;

      # emacs
      "${config.xdg.configHome}/doom".source = ./doom;

      # misc
      "${config.xdg.configHome}/isync/mbsyncrc".source = ./misc/mbsyncrc;
      "${config.home.homeDirectory}/.xinitrc".source = ./misc/xinitrc;
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      defaultKeymap = "emacs";

      history = {
        path = "$XDG_DATA_HOME/zsh/history";
        save = 1000000000;
        size = 1000000000;
      };
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
          opacity = 0.7;
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

    rofi = {
      enable = true;
      font = "Fantasque Sans Mono 10";
      theme = "Arc-Dark";
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

    starship.enable = true;
    bat.enable = true;
    bottom.enable = true;
    fzf.enable = true;
    jq.enable = true;
    gh.enable = true;

    home-manager.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      settings = { global = { font = "Fantasque Sans Mono 8"; }; };
    };

    redshift = {
      enable = true;
      latitude = -23.5446877;
      longitude = -46.6821469;
    };

    syncthing.enable = true;
    udiskie.enable = true;
    mpris-proxy.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = { name = "Adwaita"; };

    theme = { name = "Arc-Dark"; };

    font = {
      name = "Fantasque Sans Mono";
      size = 11;
    };

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };

  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      associations.added = {
        "x-scheme-handler/tg" = [
          "userapp-Telegram Desktop-PGCD00.desktop"
          "userapp-Telegram Desktop-4LGCE1.desktop"
        ];
        "image/png" = "feh.desktop";
        "application/pdf" = "brave-browser.desktop";
      };

      defaultApplications = {
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknown" = "brave-browser.desktop";
        "x-scheme-handler/tg" = "userapp-Telegram Desktop-4LGCE1.desktop";
        "x-scheme-handler/mailto" = "brave-browser.desktop";
        "x-scheme-handler/webcal" = "brave-browser.desktop";
      };
    };

    userDirs = {
      enable = true;
      desktop = "$HOME/";
      publicShare = "$HOME/";
      templates = "$HOME/";
    };
  };
}
