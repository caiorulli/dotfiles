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

  # treemacs
  python3Full

  # web
  html-tidy
  nodePackages.stylelint
  nodePackages.js-beautify
]
