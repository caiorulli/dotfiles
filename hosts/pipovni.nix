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
    jdk11
    maven

    # infra
    awscli2
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
    jet
    nodePackages.prettier
  ];
}
