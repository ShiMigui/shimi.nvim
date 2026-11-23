return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		local set = require("config.keymaps").set

		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.basics").setup()
		require("mini.comment").setup()
		local MiniFiles = require("mini.files")

		local ignore = {}
		for _, v in ipairs(require("settings.ignore")) do
			ignore[v] = true
		end

		require("mini.files").setup({
			windows = { preview = true, width_preview = 40 },
			content = {
				filter = function(e)
					local name = e.name
					return ignore[e.fs_type == "directory" and name .. "/" or name] == nil
				end,
			},
		})

		--- Toggle file explorer for a given path.
		--- - If the explorer is open, closes it.
		--- - If it is closed, opens it anchored at `path`.
		--- When `path` is a file, its parent directory is used as anchor and the explorer focuses on that file.
		--- @param path? string Target path. Defaults to current working directory.
		--- @param use_latest? boolean Whether to restore the last used state for the path. Defaults to `true`.
		local function toggle(path, use_latest)
			if MiniFiles.close() == nil then
				MiniFiles.open(path, use_latest)
			end
		end

		set("Toggle Mini Files", { lhs = "<C-e>", modes = { "n", "i" }, rhs = toggle })

		set("Toggle Mini Files (focus file)", {
			lhs = "<C-S-e>",
			modes = { "n", "i" },
			rhs = function()
				toggle(vim.api.nvim_buf_get_name(0))
			end,
		})
	end,
}
