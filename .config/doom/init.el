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
       pdf
       docker

       :lang
       emacs-lisp
       common-lisp
       (haskell +dante)
       cc
       (rust +lsp)
       python
       sh
       data
       markdown
       yaml

       :config
       (default +bindings +smartparens))
