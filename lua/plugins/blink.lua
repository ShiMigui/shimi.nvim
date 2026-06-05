return {
	"saghen/blink.cmp",
	dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
	version = "1.*",
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

		local ls = require("luasnip")
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { desc = "Snippet expand/jump" })

		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { desc = "Snippet backward" })
	end,
}
