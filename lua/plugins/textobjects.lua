local keymaps = require("config.keymaps").keymaps

local function select_obj(capture, query)
	return function()
		require("nvim-treesitter-textobjects.select").select_textobject("@" .. capture, query)
	end
end

local function move_obj(fn, capture, query)
	return function()
		fn("@" .. capture, query)
	end
end

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
			move = { set_jumps = true },
		})

		for _, obj in ipairs({
			{ "m", "function" },
			{ "c", "class" },
			{ "p", "parameter" },
			{ "i", "conditional" },
			{ "b", "block" },
			{ "/", "comment" },
		}) do
			local key, name = obj[1], obj[2]
			keymaps["Select " .. name .. " outer"] =
				{ modes = { "x", "o" }, lhs = "a" .. key, rhs = select_obj(name .. ".outer", "textobjects") }
			keymaps["Select " .. name .. " inner"] =
				{ modes = { "x", "o" }, lhs = "i" .. key, rhs = select_obj(name .. ".inner", "textobjects") }
		end
		keymaps["Select scope"] = { modes = { "x", "o" }, lhs = "as", rhs = select_obj("local.scope", "locals") }

		for _, obj in ipairs({
			{ next = "]m", prev = "[m", name = "function", query = "textobjects", dir = "start" },
			{ next = "]]", prev = "[[", name = "class", query = "textobjects", dir = "start" },
			{ next = "]M", prev = "[M", name = "function", query = "textobjects", dir = "end" },
			{ next = "][", prev = "[]", name = "class", query = "textobjects", dir = "end" },
			{ next = "]s", prev = "[s", name = "scope", query = "locals", dir = "start" },
		}) do
			local fn = obj.dir == "start" and require("nvim-treesitter-textobjects.move").goto_next_start
				or require("nvim-treesitter-textobjects.move").goto_next_end
			local fp = obj.dir == "start" and require("nvim-treesitter-textobjects.move").goto_previous_start
				or require("nvim-treesitter-textobjects.move").goto_previous_end
			keymaps["Move next " .. obj.name] =
				{ modes = { "n", "x", "o" }, lhs = obj.next, rhs = move_obj(fn, obj.name .. ".outer", obj.query) }
			keymaps["Move prev " .. obj.name] =
				{ modes = { "n", "x", "o" }, lhs = obj.prev, rhs = move_obj(fp, obj.name .. ".outer", obj.query) }
		end

		keymaps["Swap next parameter"] = {
			leader = "sn",
			rhs = function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
			end,
		}
		keymaps["Swap prev parameter"] = {
			leader = "sp",
			rhs = function()
				require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
			end,
		}

		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
		keymaps["Repeat last move next"] =
			{ modes = { "n", "x", "o" }, lhs = ";", rhs = ts_repeat_move.repeat_last_move_next }
		keymaps["Repeat last move prev"] =
			{ modes = { "n", "x", "o" }, lhs = ",", rhs = ts_repeat_move.repeat_last_move_previous }
	end,
}
