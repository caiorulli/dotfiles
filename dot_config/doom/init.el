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

       :lang
       (haskell +lsp)
       elm
       purescript
       idris
       clojure
       (elixir +lsp)
       emacs-lisp
       javascript
       (python +lsp)
       (rust +lsp)
       markdown
       yaml
       org
       web

       :config
       (default +bindings +smartparens))
