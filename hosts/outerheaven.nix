{ config, pkgs, lib, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ../modules/window-management
      ../modules/common
    ];

  boot.blacklistedKernelModules = [ "nouveau" ];

  networking.hostName = "outerheaven";

  services.xserver = {
    layout = "br";
    xkbVariant = "";
    libinput.enable = true;
  };

  console.keyMap = lib.mkForce "br-abnt2";
}
