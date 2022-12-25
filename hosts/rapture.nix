{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ../modules/common
    ];

  networking.hostName = "rapture";

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    deviceSection = ''
      Option "VariableRefresh" "true"
      Option "TearFree" "true"
    '';
  };

  environment.systemPackages = with pkgs; [
    steam-run
    minecraft
    mangohud
    gamemode
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
