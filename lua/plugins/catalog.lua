local set = require("config.keymaps").set

return {
	"ShiMigui/catalog.nvim",
	event = "VeryLazy",
	lazy = false,
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre", "BufReadPre" },
			opts = { default_format_opts = { lsp_format = "fallback" } },
		},
	},
	---@type catalog.opts.init
	opts = {
		lsp = { default = { capabilities = require("blink.cmp").get_lsp_capabilities({}, true) } },
		handle_ft_event = function(ft, lsps, formatters, _)
			for _, lsp in pairs(lsps or {}) do
				lsp:install()
				lsp:enable()
			end

			for _, f in pairs(formatters or {}) do
				f:install()
				f:add_to_conform(ft)
			end
		end,
	},
	config = function(_, opts)
		require("catalog.providers"):sub(require("catalog.providers.mason_provider"))
		require("catalog").setup(opts)

		set("Hover", { lhs = "K", rhs = vim.lsp.buf.hover })
		set("Rename symbol", { lhs = "rn", rhs = vim.lsp.buf.rename })
		set("Format file", { lhs = "gf", rhs = require("conform").format })
		set("Go to references", { lhs = "gr", rhs = vim.lsp.buf.references })
		set("Go to definition", { lhs = "gd", rhs = vim.lsp.buf.definition })
		set("Go to declaration", { lhs = "gD", rhs = vim.lsp.buf.declaration })
		set("List diagnostics", { leader = "dl", rhs = vim.diagnostic.setloclist })
		set("Go to implementation", { lhs = "gi", rhs = vim.lsp.buf.implementation })
		set("Open diagnostics float", { lhs = "gl", rhs = vim.diagnostic.open_float })
		set("Code action", { leader = "ca", modes = { "n", "v" }, rhs = vim.lsp.buf.code_action })
		set("Next diagnostic", {
			lhs = "]d",
			rhs = function()
				vim.diagnostic.jump({ count = 1 })
			end,
		})
		set("Prev diagnostic", {
			lhs = "[d",
			rhs = function()
				vim.diagnostic.jump({ count = -1 })
			end,
		})
		set("Signature help", { lhs = "<C-k>", modes = { "i", "n" }, rhs = vim.lsp.buf.signature_help })
		set("Toggle inlay hints", {
			leader = "th",
			rhs = function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
		})
	end,
}
