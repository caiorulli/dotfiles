{ config, pkgs, ... }: 

{
  home = {
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = true;

    packages = with pkgs; [
      firefox
      spotify
      discord
      telegram-desktop
      libreoffice

      zellij
      bat
      bottom

      wget
      ripgrep
      fd
      du-dust
      neofetch
      cmatrix
      unzip
      tig
      lazygit
      xclip
      tree-sitter
      nodejs
      python3

      cargo
      zulu11
      cmake
      pandoc
      shellcheck

      # clojure
      clojure
      babashka
      clj-kondo

      # haskell
      haskell-language-server
      haskellPackages.hoogle
      haskellPackages.cabal-install

      # idris
      idris2

      # rust
      rustc
      rust-analyzer

      # nix
      nixfmt
    ];

    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

    sessionVariables = {
      LESSHISTFILE = "-";
      PROTON_LOG_DIR = "${config.xdg.dataHome}/proton_log";
      PROTON_LOG = 1;
      XMONAD_CONFIG_HOME = "${config.xdg.configHome}/xmonad";
      XMONAD_DATA_HOME = "${config.xdg.dataHome}/xmonad";
      XMONAD_CACHE_HOME = "${config.xdg.cacheHome}/xmonad";
    };
  
  
    file = {
      # xmonad
      "${config.xdg.configHome}/xmonad/xmonad.hs".source =
        ./xmonad/xmonad.hs;
      "${config.xdg.configHome}/xmobar/xmobarrc".source =
        ./xmonad/xmobarrc;

      # zellij
      "${config.xdg.configHome}/zellij".source = ./zellij;
    };

    shellAliases = {
      doom = "${config.xdg.configHome}/emacs/bin/doom";
    };
  };

  
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      defaultKeymap = "emacs";

      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        save = 1000000000;
        size = 1000000000;
      };
    };

    git = {
      enable = true;
      userName = "Caio Rulli Thomaz";
      userEmail = "caiorulli@gmail.com";

      aliases = {
        s = "status";
        co = "checkout";
      };

      extraConfig = {
        core.editor = "nvim";
        pull.rebase = false;
        init.defaultBranch = "deck";
      };

      difftastic.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    emacs.enable = true;

    alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.8;
        font.size = 7;
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
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
  };
}
