return {
	"lua-language-server",
	"eslint-lsp",
	"typescript-language-server",
	"emmet-language-server",
	"css-lsp",
	"intelephense",
	"phpactor",
	"html-lsp",
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
}
