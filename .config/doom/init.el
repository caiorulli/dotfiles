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
       treemacs
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       multiple-cursors
       parinfer
       rotate-text
       snippets

       :emacs
       (dired +ranger)
       electric
       ibuffer
       vc

       :app
       (rss +org)

       :tools
       direnv
       (eval +overlay)
       (lookup +docsets)
       magit
       lsp
       (debugger +lsp)

       :lang
       clojure
       (rust +lsp)
       (haskell +lsp)
       (java +lsp)
       emacs-lisp
       sh
       data
       markdown
       org
       yaml

       :config
       (default +bindings +smartparens))
