# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed by [chezmoi](https://chezmoi.io). Files prefixed with `dot_` map to dotfiles in `$HOME` (e.g., `dot_config/nvim/` → `~/.config/nvim/`). Private or machine-specific files use the `private_` prefix.

## Chezmoi Workflow

```bash
# Apply all managed dotfiles to the home directory
chezmoi apply

# Apply a specific file
chezmoi apply ~/.config/nvim/lua/plugins/core.lua

# Preview what would change before applying
chezmoi diff

# Edit a managed file (opens source, applies on save)
chezmoi edit ~/.config/nvim/lua/plugins/core.lua

# Add a new file from $HOME into chezmoi management
chezmoi add ~/.config/some/new/file

# Check current status (unmanaged changes in $HOME vs source)
chezmoi status
```

Changes to files in this repo only take effect in `$HOME` after running `chezmoi apply`.

## Managed Tools

| Directory | Config For | Notes |
|-----------|-----------|-------|
| `dot_config/nvim/` | Neovim (LazyVim) | See `dot_config/nvim/CLAUDE.md` |
| `dot_config/alacritty/` | Alacritty terminal | `private_alacritty.toml` holds machine-specific secrets |
| `dot_config/starship.toml` | Starship prompt | Catppuccin Mocha palette |
| `dot_config/git/` | Git global config | Template (`config.tmpl`) — differs by OS |
| `dot_config/zellij/` | Zellij multiplexer | KDL format |
| `dot_vscode/` | VS Code | Minimal (ESLint + Nx Console) |

## Machine-specific Config

`dot_config/git/config.tmpl` uses `{{ .chezmoi.os }}` to output different configs per machine:
- `darwin` (work Mac) — `caio@8arm.io`, SSH signing key, GPG commit/tag signing, `autoSetupRemote`, SSH URL rewrite for GitHub
- other (personal PC) — `caiorulli@gmail.com`, no signing

To test the rendered output before applying: `chezmoi execute-template < dot_config/git/config.tmpl`

## Sub-CLAUDE.md Files

Detailed guidance for individual tool configurations lives alongside their source:

- **`dot_config/nvim/CLAUDE.md`** — LazyVim architecture, plugin structure, keymaps, Mason tools, code style (StyLua)
