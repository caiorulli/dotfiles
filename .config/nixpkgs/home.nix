{ config, pkgs, ... }:

{
  home = {
    stateVersion = "22.05";
    # enableNixpkgsReleaseCheck = true;

    username = "caio";
    homeDirectory = "/home/caio";

    packages = with pkgs; [
      # cli
      maim
      xh
      ripgrep
      fd
      gh
      du-dust
      neofetch
      jq
      cmatrix
      rsync
      unzip
      tig
      cowsay
      lolcat

      # applications
      slack
      discord
      tdesktop
      signal-desktop
      spotify
      thunderbird
      brave

      # TODO how to add nixGL?
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
      NVM_DIR = "${config.xdg.dataHome}/nvm";
      NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      PSQL_HISTORY = "${config.xdg.cacheHome}/pg/psql_history";
      PROTON_LOG_DIR = "${config.xdg.dataHome}/proton_log";
      XMONAD_CONFIG_HOME = "${config.xdg.configHome}/xmonad";
      XMONAD_DATA_HOME = "${config.xdg.dataHome}/xmonad";
      XMONAD_CACHE_HOME = "${config.xdg.cacheHome}/xmonad";
      WEECHAT_HOME = "${config.xdg.configHome}/weechat";
      MBSYNC_CONFIG = "${config.xdg.configHome}/isync/mbsyncrc";
      PROTON_LOG = 1;
      SDKMAN_DIR = "$HOME/.sdkman";
      GOPATH = "$HOME/Software/go";
    };

    shellAliases = {
      doom = "${config.xdg.configHome}/emacs/bin/doom";
      fehbg = "feh --randomize --bg-scale";
      telegram-desktop = "nixGL telegram-desktop";
      alacritty = "nixGL alacritty";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      defaultKeymap = "emacs";

      initExtra = ''
        [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

        update-pkglist() {
          pacman -Qqe > "$XDG_CONFIG_HOME/pkglist.txt"
        }

        sdseq() {
          sudo pacman -Syu --noconfirm && poweroff
        }
      '';

      profileExtra = ''
        if [ -z "''${DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
            exec ssh-agent startx
        fi
      '';

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

    # TODO crashes on arch xmonad?
    # rofi = {
    #   enable = true;
    #   font = "Fantasque Sans Mono 10";
    #   theme = "Arc-Dark";
    # };

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
      urls = [
        { tags = [ "news" ]; url = "https://clojure.org/feed.xml"; }
      ];
    };

    direnv.enable = true;
    starship.enable = true;
    bat.enable = true;
    bottom.enable = true;
    fzf.enable = true;

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

    udiskie.enable = true;
    unclutter.enable = true;
    mpris-proxy.enable = true;

    # TODO make it work with nixGL
    # picom.enable = true;
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
