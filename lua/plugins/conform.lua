return {
	"stevearc/conform.nvim",
	opts = {
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = { timeout_ms = 500 },
		formatters_by_ft = {
			lua = { "stylua" },
			java = { "google-java-format" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			markdown = { "markdownlint" },
			html = { "prettierd" },
			scss = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			css = { "prettierd" },
			php = { "php-cs-fixer" },
		},
	},
}
