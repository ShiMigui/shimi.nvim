local formatter_store = require("settings.formatter_store")

return {
	"ShiMigui/catalog.nvim",
	event = "VeryLazy",
	dependencies = { { "williamboman/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
	---@type catalog.opts
	opts = {
		silent = true,
		auto_install = {
			lsp = true,
			formatter = true,
			linter = true,
			callback = function(ft, _, formatters, _)
				if not formatters or #formatters == 0 then
					return
				end
				local names = {}
				for _, pkg in ipairs(formatters) do
					names[pkg.name] = true
				end
				formatter_store.add(ft, vim.tbl_keys(names))
			end,
		},
		lsp = {
			default = { capabilities = require("blink.cmp").get_lsp_capabilities({}, true) },
		},
	},
	config = function(_, opts)
		local set = require("config.keymaps").set

		require("catalog.provider.mason") -- Registers the mason provider
		local registry = require("mason-registry")

		local function run()
			require("catalog").setup(opts)
		end

		if #registry.get_all_packages() > 0 then
			run()
		else
			registry.refresh(run)
		end

		set("Format file", { lhs = "gf", rhs = vim.lsp.buf.format })
		set("Go to definition", { lhs = "gd", rhs = vim.lsp.buf.definition })
		set("Go to declaration", { lhs = "gD", rhs = vim.lsp.buf.declaration })
		set("Go to implementation", { lhs = "gi", rhs = vim.lsp.buf.implementation })
		set("Go to references", { lhs = "gr", rhs = vim.lsp.buf.references })
		set("Hover", { lhs = "K", rhs = vim.lsp.buf.hover })
		set("Signature help", { lhs = "<C-k>", modes = { "i", "n" }, rhs = vim.lsp.buf.signature_help })
		set("Rename symbol", { lhs = "rn", rhs = vim.lsp.buf.rename })
		set("Code action", { leader = "ca", modes = { "n", "v" }, rhs = vim.lsp.buf.code_action })
		set("Open diagnostics float", { lhs = "gl", rhs = vim.diagnostic.open_float })
		set("List diagnostics", { leader = "dl", rhs = vim.diagnostic.setloclist })
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
		set("Toggle inlay hints", {
			leader = "th",
			rhs = function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
		})
	end,
}
