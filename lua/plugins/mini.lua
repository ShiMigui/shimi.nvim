return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.basics").setup()
		require("mini.comment").setup()

		local ignore_list = require("settings.ignore")
		local ignore = {}
		for _, v in ipairs(ignore_list) do
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
					return not ignore[name]
				end,
			},
		})
	end,
}
