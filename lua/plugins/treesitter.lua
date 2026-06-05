return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"jwalton512/vim-blade",
	},
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
		},
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
