# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  ProcDaemon = pkgs.perlPackages.buildPerlPackage {
    pname = "Proc-Daemon";
    version = "0.23";
    src = builtins.fetchurl {
      url = "https://cpan.metacpan.org/authors/id/A/AK/AKREAL/Proc-Daemon-0.23.tar.gz";
      sha256 = "0scv11s9847b761vvb9vyk61br9m11cfwz69mg5k3d28g5dvih1l";
    };
    propagatedBuildInputs = with pkgs.perlPackages; [
      ProcProcessTable
    ];
  };
  ProcPIDFile = pkgs.perlPackages.buildPerlPackage {
    pname = "Proc-PID-File";
    version = "1.29";
    src = builtins.fetchurl {
      url = "https://cpan.metacpan.org/authors/id/D/DM/DMITRI/Proc-PID-File-1.29.tar.gz";
      sha256 = "196lbhszv4lri91d19jhb7a2yvq5n98jl35pd20ksb8qvx4xmkiv";
    };
  };
  FileTemp = pkgs.perlPackages.buildPerlPackage {
    pname = "Proc-Daemon";
    version = "0.2311";
    src = builtins.fetchurl {
      url = "https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-Temp-0.2311.tar.gz";
      sha256 = "0jkgnfc4bzjr5iarw5mf4pwbsbglqzhrrnhi6gy85663yldxd412";
    };
  };
  NetCUPS = pkgs.perlPackages.buildPerlPackage {
    pname = "Net-CUPS";
    version = "0.64";
    src = builtins.fetchurl {
      url = "https://cpan.metacpan.org/authors/id/N/NI/NINE/Net-CUPS-0.64.tar.gz";
      sha256 = "11asx383ap24xpdp9yx2953x9fw05aqhwn9whi68ggv21zzpgg6p";
    };
  };
  ParseEDID = pkgs.perlPackages.buildPerlPackage {
    pname = "Parse-EDID";
    version = "1.0.7";
    src = builtins.fetchurl {
      url = "https://cpan.metacpan.org/authors/id/G/GR/GROUSSE/Parse-EDID-1.0.7.tar.gz";
      sha256 = "1wavcxfic3kr18cndqwwv7z5xw45z7hb19ad5cm8l69jb880zp0s";
    };
    propagatedBuildInputs = with pkgs.perlPackages; [
      TestWarn
    ];
  };
  NmapParser = pkgs.perlPackages.buildPerlPackage {
    pname = "Nmap-Parser";
    version = "1.37";
    src = builtins.fetchurl {
      url = "https://cpan.metacpan.org/authors/id/A/AP/APERSAUD/Nmap-Parser-1.37.tar.gz";
      sha256 = "1p2fb7c4fimwb3wgvpvkvz9dpbb1yksilbmqx3ygfwf68698b6p3";
    };
    propagatedBuildInputs = with pkgs.perlPackages; [
      XMLTwig
    ];
  };
  Ocsinventory-Unix-Agent = pkgs.perlPackages.buildPerlPackage rec {
    pname = "Ocsinventory-Unix-Agent";
    version = "2.4.2";
    src = builtins.fetchurl {
      url = "https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.4.2/${pname}-${version}.tar.gz";
      sha256 = "0ggywrqbm7xl5dgcl511q17ccjxrwdjrn01j9agism5aas65vnny";
    };
    patches = [ ../patches/ocsinventory.patch ];
    propagatedBuildInputs = with pkgs.perlPackages; [
      XMLSimple IOSocketSSL CompressZlib NetSSLeay NetIP NetSNMP DigestMD5 LWP FileTemp ProcDaemon ProcPIDFile FileTemp LWPProtocolHttps
      ParseEDID NetNetmask NetPing NmapParser
      # NetCUPS
    ];
  };

  deps = with pkgs; [
    # plugify
    Ocsinventory-Unix-Agent
    nmap
    dmidecode
    read-edid
    smartmontools
    pciutils
    nettools

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
  ];
  in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ../modules/window-management
      ../modules/bluetooth.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  networking.hostName = "pipovni"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.enable = false;

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.caio = {
    isNormalUser = true;
    description = "Caio Rulli Thomaz";
    extraGroups = [ "networkmanager" "wheel" "docker"];
  };
  users.defaultUserShell = pkgs.zsh;

  home-manager = {
    users.caio = import ../home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = deps;

  fonts.fonts = with pkgs; [
    emacs-all-the-icons-fonts
    hanazono
    ipafont
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 */1 * * *     root    ocsinventory-agent"
    ];
  };

  virtualisation.docker.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
