return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		local set = require("config.keymaps").set
		local explorer = require("config.explorer")

		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.basics").setup()
		require("mini.comment").setup()

		local ignore = {}
		for _, v in ipairs(require("settings.ignore")) do
			ignore[v] = true
		end

		require("mini.files").setup({
			windows = { preview = true, width_preview = 40 },
			content = {
				filter = function(e)
					local name = e.name
					if e.fs_type == "directory" then
						name = name .. "/"
					end
					return ignore[name] == nil
				end,
			},
		})

		set("Toggle Mini Files", {
			lhs = "<C-e>",
			modes = { "n", "i" },
			rhs = explorer.toggle,
		})

		set("Toggle Mini Files (focus file)", {
			lhs = "<C-S-e>",
			modes = { "n", "i" },
			rhs = function()
				explorer.toggle(vim.api.nvim_buf_get_name(0))
			end,
		})
	end,
}
