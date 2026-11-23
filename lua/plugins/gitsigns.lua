local set = require("config.keymaps").set

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		---@param bufnr integer
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local in_buffer = { buffer = bufnr }

			-- Navigate
			set("Next hunk", {
				leader = "hj",
				rhs = function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
						return
					end
					gitsigns.nav_hunk("next")
				end,
				opts = in_buffer,
			})
			set("Prev hunk", {
				leader = "hk",
				rhs = function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
						return
					end
					gitsigns.nav_hunk("prev")
				end,
				opts = in_buffer,
			})

			-- Stage / reset
			set("Stage hunk", { leader = "hs", rhs = gitsigns.stage_hunk, opts = in_buffer })
			set("Reset hunk", { leader = "hr", rhs = gitsigns.reset_hunk, opts = in_buffer })
			set("Stage hunk (visual)", {
				leader = "hs",
				modes = "v",
				rhs = function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				opts = in_buffer,
			})
			set("Reset hunk (visual)", {
				leader = "hr",
				modes = "v",
				rhs = function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				opts = in_buffer,
			})
			set("Undo stage hunk", { leader = "hu", rhs = gitsigns.undo_stage_hunk, opts = in_buffer })
			set("Stage buffer", { leader = "hS", rhs = gitsigns.stage_buffer, opts = in_buffer })
			set("Reset buffer", { leader = "hR", rhs = gitsigns.reset_buffer, opts = in_buffer })

			-- Inspect
			set("Preview hunk", { leader = "hp", rhs = gitsigns.preview_hunk, opts = in_buffer })
			set("Blame line", {
				leader = "hb",
				rhs = function()
					gitsigns.blame_line({ full = true })
				end,
				opts = in_buffer,
			})
			set("Diff file", { leader = "hd", rhs = gitsigns.diffthis, opts = in_buffer })
			set("Diff file (against base)", {
				leader = "hD",
				rhs = function()
					gitsigns.diffthis("~")
				end,
				opts = in_buffer,
			})

			-- Toggles
			set("Toggle line blame", { leader = "htb", rhs = gitsigns.toggle_current_line_blame, opts = in_buffer })
			set("Toggle deleted", { leader = "htd", rhs = gitsigns.toggle_deleted, opts = in_buffer })
		end,
	},
}
