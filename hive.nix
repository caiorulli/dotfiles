{
  meta = {
    nixpkgs = <nixpkgs>;
  };

  bigshell = { config, pkgs, lib, ... }: {
    deployment = {
      targetHost = "192.168.0.35";
    };

    nixpkgs.localSystem = {
      system = "aarch64-linux";
      config = "aarch64-unknown-linux-gnu";
    };

    imports = [
      ./hosts/bigshell.nix
    ];
  };
}
