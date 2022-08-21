{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ../modules/xmonad
      ../modules/common
    ];

  networking.hostName = "rapture";

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";

    deviceSection = ''
      Option "VariableRefresh" "true"
      Option "TearFree" "true"
    '';
  };

  environment.systemPackages = with pkgs; [
    steam-run
    # maybe I need this?
    # (steam.override {
    #   extraPkgs = pkgs: [ mono gtk3 gtk3-x11 libgdiplus zlib ];
    #   withJava = true;
    # }).run
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  fileSystems."/mnt/steam" = {
    device = "/dev/disk/by-label/steam";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

}
