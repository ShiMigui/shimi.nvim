return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	opts = {
		theme = "dragon",
		compile = true,
		undercurl = true,
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			local ui = colors.theme.ui
			local syn = colors.theme.syn
			return {
				-- Make text stand out
				["@comment"] = { italic = true, fg = syn.comment },
				["@keyword"] = { bold = true, italic = true, fg = syn.keyword },
				["@keyword.function"] = { bold = true, italic = true, fg = syn.keyword },
				["@keyword.return"] = { bold = true, fg = syn.keyword },
				["@function"] = { bold = true, fg = syn.fun },
				["@function.builtin"] = { bold = true, fg = syn.fun },
				["@type"] = { bold = true, fg = syn.type },
				["@type.builtin"] = { bold = true, fg = syn.type },
				["@variable"] = { bold = true, fg = syn.identifier },
				["@variable.builtin"] = { bold = true, fg = syn.identifier },
				["@constant"] = { bold = true, fg = syn.constant },
				["@number"] = { bold = true, fg = syn.number },
				["@boolean"] = { bold = true, fg = syn.boolean },
				["@string"] = { bold = true, fg = syn.string },
				["@string.special"] = { bold = true, fg = syn.string },
				["@operator"] = { bold = true, fg = syn.operator },
				["@property"] = { bold = true, fg = syn.identifier },
				["@parameter"] = { italic = true, fg = syn.parameter },
				["@include"] = { bold = true, fg = syn.keyword },
				["@conditional"] = { bold = true, fg = syn.keyword },
				["@repeat"] = { bold = true, fg = syn.keyword },
				["@exception"] = { bold = true, fg = syn.keyword },
				["@punctuation"] = { fg = syn.operator },
				["@namespace"] = { bold = true, fg = syn.namespace },

				-- Clean UI
				FloatBorder = { fg = ui.float.fg_border, bg = "none" },
				NormalFloat = { bg = "none" },
				CursorLine = { bg = ui.bg_p1 },
				Visual = { bg = ui.bg_p2 },
				LineNr = { fg = ui.bg_p2 },
				CursorLineNr = { bold = true, fg = syn.fun },
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
