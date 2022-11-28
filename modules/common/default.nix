{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    networkmanager.enable = true;
    hosts = {
      "192.168.0.35" = [
        "bigshell"
        "grafana.bigshell"
        "prometheus.bigshell"
        "photo.bigshell"
      ];
    };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.utf8";
      LC_IDENTIFICATION = "pt_BR.utf8";
      LC_MEASUREMENT = "pt_BR.utf8";
      LC_MONETARY = "pt_BR.utf8";
      LC_NAME = "pt_BR.utf8";
      LC_NUMERIC = "pt_BR.utf8";
      LC_PAPER = "pt_BR.utf8";
      LC_TELEPHONE = "pt_BR.utf8";
      LC_TIME = "pt_BR.utf8";
    };
  };

  services = {
    blueman.enable = true;
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  console.keyMap = "us";

  sound.enable = true;
  security.rtkit.enable = true;

  users = {
    users.caio = {
      isNormalUser = true;
      description = "Caio Rulli Thomaz";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };

    defaultUserShell = pkgs.zsh;
  };

  home-manager = {
    users.caio = import ../../home;
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  nixpkgs = {
    overlays = [
      (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];
    config.allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  fonts.fonts = with pkgs; [
    emacs-all-the-icons-fonts
    hanazono
    ipafont
  ];

  programs = {
    zsh.enable = true;
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "22.05";
}

