{ pkgs, ... }:

with pkgs; [
  # general
  clang
  fd
  ripgrep

  # lookup
  sqlite

  # nix
  nixfmt

  # markdown
  pandoc

  # web
  html-tidy
  nodePackages.stylelint
  nodePackages.js-beautify
]
