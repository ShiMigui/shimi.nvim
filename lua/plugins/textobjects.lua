local keymaps = require("config.keymaps").keymaps

return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "V",
				},
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		-- Select text objects
		keymaps["Select function outer"] = { modes = { "x", "o" }, lhs = "am", rhs = function()
			select.select_textobject("@function.outer", "textobjects")
		end }
		keymaps["Select function inner"] = { modes = { "x", "o" }, lhs = "im", rhs = function()
			select.select_textobject("@function.inner", "textobjects")
		end }
		keymaps["Select class outer"] = { modes = { "x", "o" }, lhs = "ac", rhs = function()
			select.select_textobject("@class.outer", "textobjects")
		end }
		keymaps["Select class inner"] = { modes = { "x", "o" }, lhs = "ic", rhs = function()
			select.select_textobject("@class.inner", "textobjects")
		end }
		keymaps["Select parameter outer"] = { modes = { "x", "o" }, lhs = "ap", rhs = function()
			select.select_textobject("@parameter.outer", "textobjects")
		end }
		keymaps["Select parameter inner"] = { modes = { "x", "o" }, lhs = "ip", rhs = function()
			select.select_textobject("@parameter.inner", "textobjects")
		end }
		keymaps["Select conditional outer"] = { modes = { "x", "o" }, lhs = "ai", rhs = function()
			select.select_textobject("@conditional.outer", "textobjects")
		end }
		keymaps["Select conditional inner"] = { modes = { "x", "o" }, lhs = "ii", rhs = function()
			select.select_textobject("@conditional.inner", "textobjects")
		end }
		keymaps["Select block outer"] = { modes = { "x", "o" }, lhs = "ab", rhs = function()
			select.select_textobject("@block.outer", "textobjects")
		end }
		keymaps["Select block inner"] = { modes = { "x", "o" }, lhs = "ib", rhs = function()
			select.select_textobject("@block.inner", "textobjects")
		end }
		keymaps["Select comment outer"] = { modes = { "x", "o" }, lhs = "a/", rhs = function()
			select.select_textobject("@comment.outer", "textobjects")
		end }
		keymaps["Select comment inner"] = { modes = { "x", "o" }, lhs = "i/", rhs = function()
			select.select_textobject("@comment.inner", "textobjects")
		end }
		keymaps["Select scope"] = { modes = { "x", "o" }, lhs = "as", rhs = function()
			select.select_textobject("@local.scope", "locals")
		end }

		-- Swap
		keymaps["Swap next parameter"] = { leader = "sn", rhs = function()
			swap.swap_next("@parameter.inner")
		end }
		keymaps["Swap prev parameter"] = { leader = "sp", rhs = function()
			swap.swap_previous("@parameter.outer")
		end }

		-- Move: next
		keymaps["Next function start"] = { modes = { "n", "x", "o" }, lhs = "]m", rhs = function()
			move.goto_next_start("@function.outer", "textobjects")
		end }
		keymaps["Next class start"] = { modes = { "n", "x", "o" }, lhs = "]]", rhs = function()
			move.goto_next_start("@class.outer", "textobjects")
		end }
		keymaps["Next function end"] = { modes = { "n", "x", "o" }, lhs = "]M", rhs = function()
			move.goto_next_end("@function.outer", "textobjects")
		end }
		keymaps["Next class end"] = { modes = { "n", "x", "o" }, lhs = "][", rhs = function()
			move.goto_next_end("@class.outer", "textobjects")
		end }
		keymaps["Next scope"] = { modes = { "n", "x", "o" }, lhs = "]s", rhs = function()
			move.goto_next_start("@local.scope", "locals")
		end }

		-- Move: previous
		keymaps["Prev function start"] = { modes = { "n", "x", "o" }, lhs = "[m", rhs = function()
			move.goto_previous_start("@function.outer", "textobjects")
		end }
		keymaps["Prev class start"] = { modes = { "n", "x", "o" }, lhs = "[[", rhs = function()
			move.goto_previous_start("@class.outer", "textobjects")
		end }
		keymaps["Prev function end"] = { modes = { "n", "x", "o" }, lhs = "[M", rhs = function()
			move.goto_previous_end("@function.outer", "textobjects")
		end }
		keymaps["Prev class end"] = { modes = { "n", "x", "o" }, lhs = "[]", rhs = function()
			move.goto_previous_end("@class.outer", "textobjects")
		end }
		keymaps["Prev scope"] = { modes = { "n", "x", "o" }, lhs = "[s", rhs = function()
			move.goto_previous_start("@local.scope", "locals")
		end }

		-- Repeatable movements
		keymaps["Repeat last move next"] = { modes = { "n", "x", "o" }, lhs = ";", rhs = ts_repeat_move.repeat_last_move_next }
		keymaps["Repeat last move prev"] = { modes = { "n", "x", "o" }, lhs = ",", rhs = ts_repeat_move.repeat_last_move_previous }
	end,
}
