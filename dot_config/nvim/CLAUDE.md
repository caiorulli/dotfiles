# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration based on LazyVim, tailored for TypeScript/JavaScript development in Nx monorepos. All configuration is written in Lua.

## Development Commands

### Formatting
```bash
# Format Lua code (configuration in stylua.toml)
stylua .
```

### Plugin Management (run from within Neovim)
```
:Lazy update    # Update plugins
:Lazy           # Check plugin status
:Lazy clean     # Remove unused plugins
```

### Validating Configuration
```bash
nvim --headless -c "checkhealth" -c "quit"
```

## Architecture

### LazyExtras
Extras are managed via `lazyvim.json` (use `:LazyExtras` inside Neovim to toggle):
- `lang.typescript`, `lang.json` — LSP, treesitter, DAP for TS/JS and JSON
- `formatting.prettier`, `linting.eslint` — formatting and linting
- `test.core` — neotest + nvim-dap base
- `ai.claudecode` — Claude Code integration

### Configuration Structure
- `init.lua`: Entry point — bootstraps lazy.nvim
- `lua/config/lazy.lua`: LazyVim setup (no manual extra imports — use `lazyvim.json`)
- `lua/config/options.lua`: Vim options (tabstop=2, shiftwidth=2)
- `lua/config/keymaps.lua`: Global key mappings
- `lua/plugins/`: One file per concern:
  - `core.lua`: Colorscheme, Treesitter parsers, Mason tools, Telescope keymaps
  - `testing.lua`: Empty — test stack managed by `test.core` extra
  - `monorepo.lua`: monorepo.nvim project switcher + Telescope scoped search for `packages/{apps,libs,services}/`
  - `nx-keymaps.lua`: Which-key groups and keymaps that shell out to `pnpm` Nx scripts
  - `package-management.lua`: package-info.nvim for inline npm version display

### Key Custom Keymaps
| Key | Action |
|-----|--------|
| `<leader>fu` | LSP references (Find Usages) |
| `<leader>bi` | Buffer picker |
| `<leader>mp` | Switch monorepo project |
| `<leader>fp/sp` | Find/grep in `packages/` |
| `<leader>fa/fl/fs` | Find files in apps/libs/services |
| `<leader>nx*` | Nx build/test/lint commands |
| `<leader>n*` | package-info.nvim actions |

### Mason-managed Tools
Via custom config: `yaml-language-server`, `html-lsp`, `css-lsp`, `emmet-ls`, `docker-compose-language-service`, `dockerfile-language-server`

Via LazyExtras: `vtsls`, `eslint-lsp`, `prettier`, `json-lsp` (managed by their respective extras)

### Code Style
- StyLua: 2-space indent, 80-column width