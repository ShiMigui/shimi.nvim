# Shimi's Neovim

Tired of configuring Neovim from scratch? Or dealing with heavy distributions that do everything but what you actually need?

This is my personal config — simple, good-looking, and straight to the point. Made for anyone who wants an editor that works from the first `nvim`, no fluff, no hassle.

## ✨ What you get

- **Smart autocomplete** — blink.cmp suggests as you type, fast and accurate
- **LSP ready out of the box** — open any project and get autocomplete, diagnostics, formatting, and code navigation
- **Clean interface** — Kanagawa Dragon theme, minimal and pleasant
- **Organized keymaps** — everything in one place, no overlaps, no surprises
- **Essential plugins only** — file explorer, fuzzy finder, snippets, git, advanced tree-sitter text objects, and more

No dozens of plugins you'll never use. Just what actually matters in your daily workflow.

## ✅ Requirements

| Dependency | Required | Notes |
|---|---|---|
| Neovim ≥ 0.10 | yes | |
| git | yes | |
| C compiler (gcc/clang) | yes | for treesitter parsers |
| curl, wget, unzip, tar, gzip | yes | for Mason package manager |
| **Language runtimes** | | |
| Node.js + npm | recommended | for JS/TS LSPs, prettierd |
| Java JDK 17+ | recommended | for JDTLS (Java LSP) |
| Go | recommended | for Go LSP |
| Rust + cargo | recommended | for Rust LSP |
| Python 3 | recommended | for Python LSP |
| LuaRocks | recommended | for Lua LSP |
| **Search tools** | | |
| ripgrep (rg) | recommended | for Telescope live grep |
| fd | recommended | for Telescope file search |

### Install dependencies

<details>
<summary>Arch Linux</summary>

```bash
sudo pacman -S --needed base-devel git curl wget unzip tar gzip ripgrep fd
# Optional language runtimes
sudo pacman -S --needed nodejs npm jdk21-openjdk go rust python python-pip luarocks
```
</details>

<details>
<summary>Ubuntu / Debian</summary>

```bash
sudo apt update
sudo apt install build-essential git curl wget unzip tar gzip ripgrep fd-find
# Optional language runtimes
sudo apt install nodejs npm default-jdk golang-go rustc cargo python3 python3-pip luarocks
```
</details>

<details>
<summary>macOS (Homebrew)</summary>

```bash
brew install git curl wget unzip ripgrep fd
# Optional language runtimes
brew install node jdk go rust python luarocks
```
</details>

## 🚀 Installation

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/shimigui/nvim ~/.config/nvim
nvim
```

Lazy.nvim installs all plugins automatically on first launch.

## 🎯 Who is this for?

For anyone who:

- Has used LazyVim or AstroVim and wants something leaner
- Is new to Neovim and wants a solid starting point
- Knows what LSP is but doesn't want to configure each one manually

## ⚡ Main keymaps

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Search text in files |
| `<C-e>` | File explorer |
| `jk` | Exit insert mode |
| `gd` | Go to definition |
| `K` | Symbol documentation |
| `<leader>ca` | LSP code actions |

Leader key is `\`. Give it a try — you'll get used to it fast.

---

Built to be simple, beautiful, and productive. By [Shimi](https://github.com/shimigui).
