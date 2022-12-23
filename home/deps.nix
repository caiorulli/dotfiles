{ pkgs, ... }:

with pkgs; [
      # cli
      maim
      xh
      wget
      ripgrep
      fd
      du-dust
      neofetch
      cmatrix
      rsync
      unzip
      tig
      cowsay
      lolcat
      rtorrent
      wkhtmltopdf
      arp-scan
      gifsicle
      menyoki
      yamllint

      # applications
      slack
      discord
      tdesktop
      signal-desktop
      spotify
      thunderbird
      brave
      firefox
      libreoffice
      xterm

      # clojure
      clj-kondo
      clojure
      babashka

      # haskell
      ghc
      cabal-install
      haskell-language-server
      cabal2nix
      haskellPackages.hoogle

      # rust
      (fenix.stable.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer

      # nix
      nixfmt
      nix-index
      nix-diff
      nixos-option
      nixos-generators
      colmena
]
