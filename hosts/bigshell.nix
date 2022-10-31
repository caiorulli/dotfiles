{ config, pkgs, lib, ... }:

{
  imports = [<nixos-hardware/raspberry-pi/4>];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = "bigshell";
    networkmanager = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ 
    neovim 
    git 
    bat 
    bottom
    nmap
    gh
  ];

  services = {
    openssh.enable = true;
    prometheus.enable = true;
    grafana.enable = true;
  };
  
  users = {
    users.caio = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  nix.settings = {
    trusted-public-keys = [
      "rapture-cache:Pqqrc9pEfzYwCguwLwKRXsrvWtC6vg2CewKeYez7IDc="
    ];
    require-sigs = false; # Temporary
  };

  system.stateVersion = "22.11";
}
