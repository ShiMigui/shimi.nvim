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

## 🚀 Installation

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/shimigui/nvim ~/.config/nvim
nvim
```

That's it. Lazy.nvim installs everything automatically on first launch.

All you need is **Neovim 0.10+**, **Git**, and a C compiler. Everything else is optional.

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
