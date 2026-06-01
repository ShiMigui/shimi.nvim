return {
	formatters = {
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

	lsps = {
		lua = "lua-language-server",
		{ "js", "ts", "jsx", "tsx", lsp = { "eslint-lsp", "typescript-language-server" } },
		{ "html", "css", "scss", "js", "ts", "jsx", "tsx", lsp = "emmet-language-server" },
		{ "scss", "css", lsp = "css-lsp" },
		{ "php", "html", lsp = { "intelephense", "phpactor" } }, -- , "html-lsp"
		css = "css-lsp",
		md = "marksman",
		yaml = {
			["yaml-language-server"] = {
				settings = {
					yaml = {
						schemas = {
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
								"docker-compose.yml",
								"docker-compose.yaml",
								"compose.yml",
								"compose.yaml",
							},
						},
					},
				},
			},
		},
		sql = "sqlls",
		Dockerfile = "dockerfile-language-server",
	},

	ignore_files = { ".git/", "vendor/", "node_modules/" },
}
