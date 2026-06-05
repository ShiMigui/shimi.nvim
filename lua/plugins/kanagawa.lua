return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		theme = "dragon",
		compile = true,
		undercurl = true,
		transparent = true,
		colors = { theme = { all = { ui = { bg_gutter = "none", bg = "none" } } } },
		overrides = function(colors)
			local ui, syn = colors.theme.ui, colors.theme.syn
			return {
				["@comment"] = { italic = true, fg = syn.comment },
				["@keyword"] = { italic = true, fg = syn.keyword },
				["@function"] = { bold = true, fg = syn.fun },
				["@type"] = { italic = false, fg = syn.type },
				FloatBorder = { fg = ui.float.fg_border, bg = "none" },
				CursorLine = { bg = ui.bg_p1 },
				NormalFloat = { bg = "none" },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd("colorscheme kanagawa")
	end,
}
