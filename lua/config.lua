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
		"lua-language-server",
		"eslint-lsp",
		"typescript-language-server",
		"emmet-language-server",
		"css-lsp",
		"intelephense",
		"phpactor",
		"html-lsp",
		"css-lsp",
		"sqlls",
		"dockerfile-language-server",
		"marksman",
		"jdtls",
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

	ignore_files = { ".git/", "vendor/", "node_modules/" },
}
