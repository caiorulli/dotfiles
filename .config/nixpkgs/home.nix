{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "caio";
  home.homeDirectory = "/home/caio";

  home.packages = with pkgs; [
    direnv
    maim
    bottom
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
