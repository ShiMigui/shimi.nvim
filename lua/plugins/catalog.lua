return {
	"ShiMigui/catalog.nvim",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	opts = {
		conform = true,
		lsp = require("settings.lsps"),
		lsp_config = require("settings.lsp_config"),
		ensure_installed = require("settings.ensure_installed"),
	},
	config = function(_, opts)
		local r = require("mason-registry")
		local function run()
			require("catalog").setup(opts)
		end

		if #r.get_all_packages() > 0 then
			run()
		else
			r.refresh(run)
		end
	end,
}
