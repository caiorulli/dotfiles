# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration based on LazyVim, a modern Neovim configuration framework. The setup uses Lua for configuration and includes debugging capabilities specifically configured for Go development.

## Development Commands

### Formatting
```bash
# Format Lua code using stylua (configuration in stylua.toml)
stylua .
```

### Plugin Management
```bash
# Update plugins (run from within Neovim)
:Lazy update

# Check plugin status
:Lazy

# Clean unused plugins
:Lazy clean
```

### Testing Configuration
```bash
# Test Neovim configuration by starting Neovim
nvim

# Check for configuration errors
nvim --headless -c "checkhealth" -c "quit"
```

## Architecture

### Configuration Structure
- `init.lua`: Main entry point that bootstraps the lazy.nvim plugin manager
- `lua/config/`: Core configuration modules
  - `lazy.lua`: LazyVim setup and plugin specification
  - `options.lua`: Vim options (tabstop=2, shiftwidth=2)
  - `keymaps.lua`: Custom key mappings
  - `autocmds.lua`: Auto commands
- `lua/plugins/`: Plugin configurations
  - `core.lua`: Core plugin overrides and custom configurations

### Key Plugins and Configuration
- **LazyVim**: Base configuration framework with sensible defaults
- **Telescope**: Custom keymaps for finding usages (`<leader>fu`) and buffer picking (`<leader>bi`)
- **Treesitter**: Configured for JavaScript, Lua, Bash, HTML, JSON, Markdown, Vim, YAML
- **Mason**: Ensures `gopls` LSP is installed for Go development
- **DAP (Debug Adapter Protocol)**: 
  - Configured for Go debugging with Delve adapter
  - Remote debugging on port 2345
  - Custom path substitutions for Bazel/Go workspace setup
  - Auto-opens DAP UI on debug sessions

### Debugging Setup
The DAP configuration includes specific path mappings for a Bazel-based Go development environment:
- Maps `${env:GOPATH}/src` to `src`
- Maps Bazel external dependencies and build outputs
- Connects to remote Delve debugger on port 2345

### Code Style
- Uses StyLua for Lua formatting with 2-space indentation
- Column width set to 80 characters
- LazyVim defaults apply for most styling conventions