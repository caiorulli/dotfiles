{ config, pkgs, ... }:

{
  home = {
    stateVersion = "22.05";
    username = "caio";
    homeDirectory = "/home/caio";
    packages = with pkgs; [
      # cli
      direnv
      maim
      xh
      ripgrep
      fd
      newsboat
      gh
      du-dust
      neofetch
      fzf

      # applications
      slack
      discord
      tdesktop
      signal-desktop
      spotify
      thunderbird
      brave
    ];
  };

  programs = {
    exa.enable = true;
    bat.enable = true;
    bottom.enable = true;

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

    ssh = {
      enable = true;
      extraOptionOverrides = {
        "AddKeysToAgent" = "yes";
      };
    };

    home-manager.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          font = "Fantasque Sans Mono 8";
        };
      };
    };

    redshift = {
      enable = true;
      latitude = -23.5446877;
      longitude = -46.6821469;
    };

    udiskie.enable = true;
    unclutter.enable = true;
    mpris-proxy.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
    };

    theme = {
      name = "Arc-Dark";
    };

    font = {
      name = "Fantasque Sans Mono";
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  xdg.mimeApps = {
    enable = true;

    associations.added = {
      "x-scheme-handler/tg" = ["userapp-Telegram Desktop-PGCD00.desktop"
                               "userapp-Telegram Desktop-4LGCE1.desktop"];
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
}
