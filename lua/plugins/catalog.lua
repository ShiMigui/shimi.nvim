local ensure_installed = {}
for _, formatters in pairs(require("settings.formatters")) do
	for _, name in ipairs(formatters) do
		ensure_installed[name] = true
	end
end
ensure_installed = vim.tbl_keys(ensure_installed)

return {
	"ShiMigui/catalog.nvim",
	dependencies = { { "williamboman/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
	---@type catalog.opts
	opts = {
		silent = true,
		auto_install = true,
		ensure_installed = ensure_installed,
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
