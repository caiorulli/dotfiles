{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "caio";
  home.homeDirectory = "/home/caio";

  home.packages = with pkgs; [
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
  ];

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

    udiskie.enable = true;
    unclutter.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
