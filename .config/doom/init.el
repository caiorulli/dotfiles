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
       pass

       :lang
       (haskell +lsp)
       idris
       clojure
       (rust +lsp)
       javascript
       (java +lsp)
       (python +lsp)
       emacs-lisp
       nix
       org
       markdown
       web
       yaml
       data

       :term
       vterm

       :email
       (mu4e +gmail)

       :app
       rss

       :config
       (default +bindings +smartparens))
