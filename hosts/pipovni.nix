{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ../modules/xmonad
      ../modules/plugify
      ../modules/common
    ];

  networking.hostName = "pipovni";

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };

    opengl.enable = true;
  };

  environment.systemPackages =  with pkgs; [
    # dev
    clojure
    clj-kondo
    babashka
    jet
    jdk11
    maven
    awscli2

    # infra
    kubectl
    kubectx
    stern
    kops
    k9s
    terraform
    sentry-cli
    nodePackages.firebase-tools

    # tools
    gnumake
    bash
    plantuml
    libreoffice
  ];
}
