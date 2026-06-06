# Shimi Neovim Configuration

A modern, modular, and highly optimized Neovim configuration built for performance, type-safety, and developer experience.

## 🚀 Getting Started

### Prerequisites

- **Neovim 0.10+** (some features require nightly or 0.12+)
- **Git**
- **A C Compiler** (for Tree-sitter parsers)
- **Ollama** (optional, for local AI features)
- **Nerd Font** (optional, for icons)

### Installation

1. Backup your existing configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
   ```

3. Open Neovim:
   ```bash
   nvim
   ```
   `lazy.nvim` will automatically install all plugins on the first run.

## 🏛️ Core Concepts

### Modular Structure
This configuration is organized into logical modules to ensure maintainability:
- `lua/config/`: Orchestration and core logic (Options, Keymaps, Autocmds).
- `lua/settings/`: Data-driven configurations for LSPs, formatters, and ignore patterns.
- `lua/plugins/`: Atomic plugin definitions. Each plugin has its own file for easier management.

### Centralized & Typed Keymapping
We use a custom, typed keymapping system defined in `lua/config/keymaps.lua`. All keybindings (global, plugin-specific, and LSP-local) are registered in a central registry using the `shimi.Keymap` class. This provides:
- **Type Safety**: EmmyLua annotations ensure keymaps are correctly defined.
- **Discoverability**: One single source of truth for all shortcuts.
- **Consistency**: Unified logic for leader-based and raw mappings.

### Modern Tree-sitter Integration
Utilizing the `main` branch of `nvim-treesitter` for the most advanced features:
- **Auto-Installation**: Parsers are automatically installed on-the-fly when opening a new file type.
- **Core Integration**: Leverages Neovim's native Tree-sitter APIs for highlighting, folding, and indentation.
- **Robustness**: Advanced buffer validation prevents Treesitter from interfering with non-file buffers.

## ✨ Key Features

- **AI Integration**: [parrot.nvim](https://github.com/frankroeder/parrot.nvim) pre-configured with local Ollama support for code implementation, refactoring, and chatting.
- **Superior LSP Experience**: Automated LSP and tool management via [catalog.nvim](https://github.com/ShiMigui/catalog.nvim).
- **Ultra-fast Completion**: [blink.cmp](https://github.com/Saghen/blink.cmp) provides a high-performance completion engine.
- **Minimalist & Elegant UI**: Built on [Kanagawa](https://github.com/rebelot/kanagawa.nvim) (Dragon theme) with custom highlights for markdown and floating windows.
- **Productivity Utils**: Full suite of [mini.nvim](https://github.com/echasnovski/mini.nvim) modules (Files, Move, Pairs, etc.) for a cohesive experience.

## ⌨️ Principal Keymaps

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find Files (Telescope) |
| `<leader>fg` | Live Grep (Telescope) |
| `<C-e>` | File Explorer (mini.files) |
| `jk` | Exit Insert Mode |
| `gd` | Go to Definition |
| `K` | LSP Hover Information |
| `<leader>ca` | LSP Code Actions |
| `<leader>an` | AI: New Chat (Parrot) |
| `<leader>ai` | AI: Implement Selection (Parrot) |

---
*Maintained with ❤️ by Shimi.*
