return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		theme = "dragon",
		compile = true,
		undercurl = true,
		transparent = true,
		overrides = function(colors)
			local ui = colors.theme.ui
			local syn = colors.theme.syn
			return {
				["@comment"] = { italic = true, fg = syn.comment },
				["@keyword"] = { bold = true, italic = true, fg = syn.keyword },
				["@function"] = { bold = true, fg = syn.fun },
				["@function.builtin"] = { bold = true, fg = syn.fun },
				["@type"] = { bold = true, fg = syn.type },
				["@type.builtin"] = { bold = true, fg = syn.type },
				["@constant"] = { bold = true, fg = syn.constant },
				["@boolean"] = { bold = true, fg = syn.boolean },
				["@include"] = { bold = true, fg = syn.keyword },
				["@conditional"] = { bold = true, fg = syn.keyword },
				["@repeat"] = { bold = true, fg = syn.keyword },
				["@exception"] = { bold = true, fg = syn.keyword },
				["@variable"] = { bold = true, fg = syn.identifier },
				["@variable.builtin"] = { bold = true, fg = syn.identifier },
				["@parameter"] = { italic = true, fg = syn.parameter },

				FloatBorder = { fg = ui.float.fg_border, bg = "none" },
				NormalFloat = { bg = "none" },
				CursorLine = { bg = ui.bg_p1 },
				Visual = { bg = ui.bg_p2 },
				LineNr = { fg = ui.bg_p2 },
				Search = { bg = ui.bg_p2, fg = syn.keyword },
				IncSearch = { bg = ui.bg_p2, fg = syn.fun },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd("colorscheme kanagawa")
	end,
}
