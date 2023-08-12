{ config, pkgs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "caio";
    homeDirectory = "/home/caio";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05";
    enableNixpkgsReleaseCheck = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      #
      # cli
      maim
      xh
      wget
      ripgrep
      fd
      du-dust
      neofetch
      cmatrix
      unzip
      tig
      cowsay
      lolcat
      rtorrent
      mpv
      feh
      arp-scan
      gifsicle
      i3lock
      menyoki
      yamllint
      zathura

      # applications
      #discord
      #tdesktop
      #signal-desktop
      #spotify
      #firefox
      xterm

      # clojure
      clj-kondo
      clojure
      babashka

      # haskell
      ghc
      cabal-install
      haskell-language-server
      cabal2nix
      haskellPackages.hoogle

      # nix
      nixfmt
      nix-index
      nix-diff
      nixos-option
      nixos-generators
      colmena
    ];


    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/caio/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.
    sessionVariables = {
      LESSHISTFILE = "-";
      PROTON_LOG_DIR = "${config.xdg.dataHome}/proton_log";
      PROTON_LOG = 1;
      XMONAD_CONFIG_HOME = "${config.xdg.configHome}/xmonad";
      XMONAD_DATA_HOME = "${config.xdg.dataHome}/xmonad";
      XMONAD_CACHE_HOME = "${config.xdg.cacheHome}/xmonad";
    };

    shellAliases = {
      fehbg = "feh --randomize --bg-scale";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
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

    ssh = {
      enable = true;
      extraOptionOverrides = { "AddKeysToAgent" = "yes"; };
    };

    # alacritty = {
    #   enable = true;
    #   settings = {
    #     env.TERM = "xterm-256color";
    #     window = {
    #       opacity = 0.7;
    #       padding = {
    #         x = 5;
    #         y = 5;
    #       };
    #     };
    #     font = {
    #       normal.family = "Fantasque Sans Mono";
    #       size = 11.0;
    #     };
    #     colors = {
    #       primary = {
    #         background = "0x2E3440";
    #         foreground = "0xD8DEE9";
    #       };
    #       cursor = {
    #         text = "0x2E3440";
    #         cursor = "0xD8DEE9";
    #       };
    #       normal = {
    #         black = "0x3B4252";
    #         red = "0xBF616A";
    #         green = "0xA3BE8C";
    #         yellow = "0xEBCB8B";
    #         blue = "0x81A1C1";
    #         magenta = "0xB48EAD";
    #         cyan = "0x88C0D0";
    #         white = "0xE5E9F0";
    #       };
    #       bright = {
    #         black = "0x4C566A";
    #         red = "0xBF616A";
    #         green = "0xA3BE8C";
    #         yellow = "0xEBCB8B";
    #         blue = "0x81A1C1";
    #         magenta = "0xB48EAD";
    #         cyan = "0x8FBCBB";
    #         white = "0xECEFF4";
    #       };
    #     };
    #   };
    # };

    rofi = {
      enable = true;
      font = "Fantasque Sans Mono 10";
      theme = "Arc-Dark";
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
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

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  xdg.enable = true;
}
