local maps = require("core.keymap")
local config = require("config")

return {
	"mfussenegger/nvim-jdtls",
	{
		"stevearc/conform.nvim",
		opts = {
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = { timeout_ms = 500 },
			formatters_by_ft = config.formatters,
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
		version = "1.*",
		build = "cargo build --release",
		config = function(_, opts)
			require("blink.cmp").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
			local ls = require("luasnip")

			maps["snippet expand/jump"] = {
				mode = { "i", "s" },
				lhs = "<C-l>",
				rhs = function()
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					end
				end,
			}

			maps["snippet backward"] = {
				mode = { "i", "s" },
				lhs = "<C-h>",
				rhs = function()
					if ls.jumpable(-1) then
						ls.jump(-1)
					end
				end,
			}
		end,
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
	},
	{
		"ShiMigui/catalog.nvim",
		dependencies = { { "williamboman/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
		opts = {
			conform = true,
			lsp = config.lsps,
		},
		config = function(_, opts)
			opts.capability_provider = "blink.cmp"
			local r = require("mason-registry")
			local function run()
				require("catalog").setup(opts)
			end

			return #r.get_all_packages() > 0 and run() or r.refresh(run)
		end,
	},
}
