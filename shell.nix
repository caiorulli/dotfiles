{ pkgs ? import <nixpkgs> {} }:

let
  ghc = pkgs.haskellPackages.ghcWithPackages (ps: with ps; [
    xmonad
    xmonad-contrib
    xmonad-extras
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    ghc
    haskell-language-server
  ];
}
