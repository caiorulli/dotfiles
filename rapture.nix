# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ./modules/window-management.nix
      ./modules/bluetooth.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "rapture";
    networkmanager.enable = true;
    hosts = {
      "192.168.0.42" = [
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
    xserver = {
      layout = "us";
      xkbVariant = "altgr-intl";

      deviceSection = ''
        Option "VariableRefresh" "true"
        Option "TearFree" "true"
      '';
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;

  # Configure console keymap
  console.keyMap = "us";

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  users = {
    users.caio = {
      isNormalUser = true;
      description = "Caio Rulli Thomaz";
      extraGroups = [ "networkmanager" "wheel" "docker" "dotfiles" ];
    };

    users.pipo = {
      isNormalUser = true;
      description = "Pipo Saúde";
      extraGroups = [ "networkmanager" "wheel" "docker" "dotfiles" ];
    };

    groups = {
      dotfiles = {};
    };

    defaultUserShell = pkgs.zsh;
  };

  home-manager = {
    users.caio = import /etc/dotfiles/home.nix;
    users.pipo = import /etc/dotfiles/pipo.nix;

    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    wget
    vim
    git

    # steam
    steam-run
    # maybe I need this?
    # (steam.override {
    #   extraPkgs = pkgs: [ mono gtk3 gtk3-x11 libgdiplus zlib ];
    #   withJava = true;
    # }).run
  ];

  fonts.fonts = with pkgs; [
    emacs-all-the-icons-fonts
    hanazono
    ipafont
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };

}
