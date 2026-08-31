# Shimi's Neovim

A personal, dependency-light Neovim config that stays out of your way. Tools,
LSP servers, formatters and linters install themselves — the config keeps
learning as you open different filetypes.

## Features

- **Self-managing tooling** — [catalog.nvim](https://github.com/ShiMigui/catalog.nvim)
  auto-installs LSP servers, formatters and linters per filetype via Mason. No
  manual setup for new languages.
- **Smart completion** — blink.cmp with LuaSnip + friendly-snippets.
- **Formatting on save** — conform.nvim writes every formatter it auto-installs
  back to `lua/settings/formatters.lua`, so your repo doubles as the config.
- **File explorer** — [mini.files](https://github.com/nvim-mini/mini.nvim) (`<C-e>`).
- **Fuzzy finding** — Telescope with fzf-native (files, grep, git, symbols).
- **Clean theme** — Kanagawa (wave) with a dark background.
- **Treesitter** — parser auto-install + text-objects on first open.

## What's included

| Plugin | Purpose |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager (bootstrapped) |
| [catalog.nvim](https://github.com/ShiMigui/catalog.nvim) | Auto-install LSP + formatters + linters |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocomplete |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) / friendly-snippets | Snippets |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Parsers, folding, text objects |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Find / grep / git / symbols |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim) | File explorer + editing utils |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tabline |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Colorscheme |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua LSP for your config |

## Install

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/shimigui/nvim ~/.config/nvim
nvim   # lazy.nvim installs everything on first launch
```

## Requirements

| Dependency | Required | Notes |
| --- | --- | --- |
| Neovim ≥ 0.10 | yes | |
| git | yes | plugin manager |
| C compiler (gcc/clang) | yes | treesitter parsers + fzf-native |
| curl, wget, unzip, tar | yes | Mason installs |
| ripgrep (rg) | recommended | Telescope live grep |
| fd | recommended | Telescope file search |
| Node / JDK / Go / Rust / Python | optional | only for those languages |

## Main keymaps

Leader is `\`.

| Key | Action |
| --- | --- |
| `jk` | Exit insert mode |
| `<C-e>` | File explorer (mini.files) |
| `gf` | Format |
| `gd` | Go to definition |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>gs` | Git status |
