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
      mpv
      feh
      wkhtmltopdf
      arp-scan
      gifsicle
      i3lock
      menyoki
      yamllint
      zathura

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
