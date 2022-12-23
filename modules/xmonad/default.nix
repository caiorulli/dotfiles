{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
      };
    };

    picom.enable = true;
    unclutter.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xmobar
    feh
    pulsemixer
    pamixer
    xclip
    playerctl
  ];
}
