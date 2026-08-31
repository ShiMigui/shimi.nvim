return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
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
	end,
}
