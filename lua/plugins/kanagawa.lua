return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		theme = "dragon",
		compile = true,
		undercurl = true,
		transparent = true,
		colors = {
			theme = {
				dragon = {
					ui = {
						bg_p1 = "#100f0f",
						bg_p2 = "#141313",
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			local ui = colors.theme.ui
			local syn = colors.theme.syn
			return {
				-- Common overrides
				["@comment"] = { italic = true, fg = syn.comment },
				["@keyword"] = { italic = true, fg = syn.keyword },
				["@function"] = { bold = true, fg = syn.fun },
				["@type"] = { italic = false, fg = syn.type },

				FloatBorder = { fg = ui.float.fg_border, bg = "none" },
				NormalFloat = { bg = "none" },
				CursorLine = { bg = ui.bg_p1 },

			["@variable"] = { fg = syn.identifier },
				["@string"] = { fg = syn.string },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd("colorscheme kanagawa")
	end,
}
