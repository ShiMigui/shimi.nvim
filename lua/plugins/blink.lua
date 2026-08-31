return {
	"saghen/blink.cmp",
	dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
	version = "1.*",
	event = "InsertEnter",
	build = "cargo build --release",
	opts = {
		fuzzy = { implementation = "prefer_rust", sorts = { "score", "sort_text", "label" } },
		keymap = {
			preset = "default",
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		completion = { menu = { auto_show = true }, documentation = { auto_show = false } },
		sources = { default = { "lsp", "snippets", "buffer", "path" } },
		snippets = { preset = "luasnip" },
	},
	config = function(_, opts)
		require("blink.cmp").setup(opts)
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
