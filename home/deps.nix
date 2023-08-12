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
      unzip
      tig
      cowsay
      lolcat
      rtorrent
      mpv
      feh
      arp-scan
      gifsicle
      i3lock
      menyoki
      yamllint
      zathura

      # applications
      discord
      tdesktop
      signal-desktop
      spotify
      thunderbird
      firefox
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

      # nix
      nixfmt
      nix-index
      nix-diff
      nixos-option
      nixos-generators
      colmena
]
