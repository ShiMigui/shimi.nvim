return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		theme = "wave",
		compile = true,
		undercurl = true,
		colors = {
			theme = {
				wave = {
					ui = {
						bg = "#181818",
						bg_gutter = "#181818",
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd("colorscheme kanagawa")
	end,
}
