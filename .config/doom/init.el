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
       vc-gutter
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
       emacs-lisp
       common-lisp
       (rust +lsp)
       markdown

       :config
       (default +bindings +smartparens))
