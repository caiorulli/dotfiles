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
    patches = [ ./patches/ocsinventory.patch ];
    propagatedBuildInputs = with pkgs.perlPackages; [
      XMLSimple IOSocketSSL CompressZlib NetSSLeay NetIP NetSNMP DigestMD5 LWP FileTemp ProcDaemon ProcPIDFile FileTemp LWPProtocolHttps
      ParseEDID NetNetmask NetPing NmapParser
      # NetCUPS
    ];
  };
in {
  environment.systemPackages = with pkgs; [
    Ocsinventory-Unix-Agent
    nmap
    dmidecode
    read-edid
    smartmontools
    pciutils
    nettools
  ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 */1 * * *     root    ocsinventory-agent"
    ];
  };
}
