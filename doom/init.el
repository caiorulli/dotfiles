;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       ivy

       :checkers
       syntax

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       modeline
       nav-flash
       ophints
       (popup +all +defaults)
       (treemacs +lsp)
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       multiple-cursors
       rotate-text
       snippets
       format

       :emacs
       (dired +ranger)
       electric
       ibuffer
       vc

       :tools
       direnv
       (eval +overlay)
       (lookup +docsets)
       magit
       lsp
       (debugger +lsp)
       pdf
       docker
       terraform

       :lang
       (haskell +lsp)
       clojure
       (rust +lsp)
       javascript
       (java +lsp)
       emacs-lisp
       nix
       org
       markdown
       web
       yaml
       data

       :config
       (default +bindings +smartparens))
