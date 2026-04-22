# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Repository

This is a Doom Emacs configuration directory (`~/.config/doom`). It is not a software project with a build system — it's Emacs Lisp configuration for the [Doom Emacs](https://github.com/doomemacs/doomemacs) framework.

## CLI Commands

```bash
# Sync after changing init.el or packages.el
# Installs/removes packages, removes orphans, rebuilds autoloads
doom sync

# Update Doom itself and all packages to latest versions
doom upgrade
# Update packages only (skip Doom core)
doom upgrade --packages

# Diagnose system/config issues (missing deps, duplicate modules, etc.)
doom doctor

# Regenerate environment variable snapshot (required for GUI Emacs on macOS)
doom env

# Remove orphaned packages and compact repos (run periodically)
doom purge

# Fix issues caused by stale bytecode
doom clean

# Recompile all packages and fix broken symlinks
doom build

# Reload config without restarting (run inside Emacs)
# SPC h r r   (or M-x doom/reload)
```

**When to run what:**
- Changed `init.el` (doom! block) or `packages.el` → `doom sync` then restart Emacs
- Changed `config.el` only → `SPC h r r` (doom/reload) is enough
- GUI Emacs can't find executables on macOS → `doom env`

## File Architecture

| File | Role |
|------|------|
| `init.el` | Declares which Doom modules are enabled via `(doom! ...)`. Controls load order and optional feature flags. |
| `config.el` | Personal customizations that run after modules load. Use `after!`, `use-package!`, and `map!` here. |
| `packages.el` | Extra package declarations not provided by Doom modules. Any change requires `doom sync`. |

## Configuration Patterns

**Enabling a module with flags** — in `init.el`:
```elisp
:lang
(python +lsp +tree-sitter)  ; +flags enable optional features within a module
(org +brain +jupyter)
```

**`after!` vs `use-package!`:**
- `after!` — lightweight, runs code once a package is loaded. Prefer this for simple settings.
- `use-package!` — full package lifecycle management with `:defer`, `:hook`, `:commands`, `:after`. Using it without deferral keywords forces immediate loading and defeats Doom's startup optimizations.

```elisp
;; Preferred for most cases
(after! evil
  (setq evil-want-fine-undo t))

;; Use when you need deferred loading control
(use-package! some-package
  :defer t
  :config
  (setq some-package-option t))
```

**Adding a keybinding** — in `config.el`:
```elisp
(map! :leader
      :desc "My action" "o m" #'my-function)

;; Or for a mode-specific binding
(map! :map python-mode-map
      :n "gz" #'my-jump-function)
```

**Installing an extra package** — in `packages.el`:
```elisp
(package! some-package)                                      ; from MELPA
(package! from-git :recipe (:host github :repo "user/repo")) ; from git
(package! built-in-pkg :disable t)                          ; disable a Doom-provided package
(package! pinned-pkg :pin "commit-sha")                     ; pin to a specific commit
```

**Checking if a module flag is active** — in any config:
```elisp
(when (featurep! :lang python +lsp)
  ;; only runs if python module has +lsp flag
  )
```

## Doom Naming Conventions

When writing custom functions, follow Doom's conventions:
- `doom/name` or `+module/name` — interactive commands (callable via `M-x`)
- `doom:name` — Evil operators/motions
- `doom-name-h` — hook functions
- `doom-name-a` — advice functions
- `doom--name` — private (internal) symbols

## Current Setup

- **Completion**: Vertico (minibuffer) + Company (in-buffer)
- **Editing**: Evil everywhere, parinfer (Lisp), snippets
- **UI**: doom-one theme, treemacs, workspaces, zen mode, vc-gutter
- **Tools**: Magit, LSP, tree-sitter, DAP debugger, direnv, vterm
- **Languages**: JavaScript (+tree-sitter), Markdown, Emacs Lisp, Org, Web, YAML, Shell, Data
- **OS**: macOS module enabled (`:os macos`)

## Troubleshooting

- **Config not applying** — check whether you changed `init.el`/`packages.el` (needs `doom sync`) vs `config.el` (needs reload only).
- **Broken after update** — run `doom clean` then `doom sync` to rule out stale bytecode.
- **Full reset** — delete `~/.config/emacs/.local/straight/` and run `doom sync`.
- **LSP server not found** — run `doom env` to regenerate PATH snapshot for GUI Emacs.
- **`s`/`S` keys don't substitute** — by design; evil-snipe maps them to 2-char motions. Disable with `(remove-hook 'doom-first-input-hook #'evil-snipe-mode)`.
