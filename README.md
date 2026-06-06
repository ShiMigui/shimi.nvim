# Shimi's Neovim

Cansado de configurar Neovim do zero? Ou de lidar com distribuições pesadas que fazem tudo menos o que você precisa?

Essa é minha config pessoal — simples, bonita e direta ao ponto. Feita pra quem quer um editor que funciona desde o primeiro `nvim`, sem firulas, sem enrolação.

## ✨ O que você ganha

- **Auto-complete inteligente** — blink.cmp te sugere enquanto digita, sem延迟
- **LSP pronto pra usar** — abre qualquer projeto e já vem com autocomplete, diagnóstico, formatação e navegação de código
- **IA local** — integração com Ollama pra implementar, refatorar e responder perguntas sem sair do editor
- **Interface limpa** — tema Kanagawa Dragon, minimalista e agradável
- **Atalhos organizados** — tudo num lugar só, sem overlap, sem surpresa
- **Plugins essenciais** — explorador de arquivos, fuzzy finder, snippets, git, movimento avançado por árvore sintática, e mais

Nada de dezenas de plugins que você nunca usou. Só o que realmente faz diferença no dia a dia.

## 🚀 Instalação

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/shimigui/nvim ~/.config/nvim
nvim
```

Pronto. O Lazy.nvim instala tudo automaticamente na primeira inicialização.

Só precisa de **Neovim 0.10+**, **Git** e um compilador C. O resto é opcional.

## 🎯 Pra quem é?

Pra quem:
- Já usou LazyVim ou AstroVim e quer algo mais enxuto
- Nunca usou Neovim mas quer começar com uma base sólida
- Sabe o que é LSP mas não quer perder tempo configurando cada um
- Quer IA no editor sem depender de serviços externos

## ⚡ Atalhos principais

| Tecla | O que faz |
|---|---|
| `<leader>ff` | Buscar arquivos |
| `<leader>fg` | Buscar texto nos arquivos |
| `<C-e>` | Explorador de arquivos |
| `jk` | Sair do modo inserção |
| `gd` | Ir para definição |
| `K` | Documentação do símbolo |
| `<leader>ca` | Ações de código (LSP) |
| `<leader>an` | Nova conversa com IA |
| `<leader>ai` | Implementar seleção com IA |

O leader é `\`. Testa que você se acostuma rápido.

---

Feito com o objetivo de ser simples, bonito e produtivo. Por [Shimi](https://github.com/shimigui).
