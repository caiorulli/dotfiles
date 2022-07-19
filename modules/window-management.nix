{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
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

  fonts.fonts = with pkgs; [ fantasque-sans-mono ];
}
