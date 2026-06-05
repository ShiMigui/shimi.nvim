# Neovim Modular Configuration

A clean, modular Neovim configuration refactored for better maintainability and ease of use.

## Structure

- `init.lua`: Main entry point.
- `lua/config/`: Core configuration logic.
    - `options.lua`: Vim options.
    - `keymaps.lua`: Global and LSP keybindings.
    - `autocmds.lua`: Global autocommands.
    - `plugins.lua`: Lazy.nvim setup.
- `lua/settings/`: Data-only configuration files for plugins.
    - `lsps.lua`: List of LSPs to be installed and configured.
    - `formatters.lua`: Formatter configurations.
    - `ignore.lua`: Common file/directory ignore patterns.
- `lua/plugins/`: Individual plugin definitions. Each plugin is in its own file.

## Features

- **Package Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP & Tool Management**: [catalog.nvim](https://github.com/ShiMigui/catalog.nvim) (automates LSP and formatter setup)
- **Completion**: [blink.cmp](https://github.com/Saghen/blink.cmp)
- **Tree-sitter**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Fuzzy Finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **UI**: [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) (Dragon theme), [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- **AI**: [parrot.nvim](https://github.com/frankroeder/parrot.nvim) with Ollama support.
- **Utils**: [mini.nvim](https://github.com/echasnovski/mini.nvim) (Files, Move, Pairs, etc.)

## Configuration

To add a new LSP, simply add it to `lua/settings/lsps.lua`.
To add a new formatter, add it to `lua/settings/formatters.lua`.
To add a new plugin, create a new file in `lua/plugins/plugin_name.lua` returning a lazy.nvim spec.

## Keymaps

- `<leader>` is set to ` ` (Space).
- `<C-e>`: Open file explorer (mini.files).
- `<leader>ff`: Find files.
- `<leader>fg`: Live grep.
- `gd`: Go to definition.
- `K`: LSP hover.
- `<leader>ca`: Code action.
