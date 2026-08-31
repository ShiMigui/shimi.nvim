local formatter_store = require("settings.formatter_store")

return {
	"ShiMigui/catalog.nvim",
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
	end,
}
