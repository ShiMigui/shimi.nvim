---@class TSConfig
---@field ensure_installed string[]
---@field auto_install boolean
---@field sync_install boolean
---@field highlight {enable: boolean, additional_vim_regex_highlighting: boolean}
---@field indent {enable: boolean}
---@field incremental_selection {enable: boolean, keymaps: table<string, string|boolean>}

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"jwalton512/vim-blade",
	},
	build = ":TSUpdate",
	---@type TSConfig
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"java",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"scss",
			"json",
			"yaml",
			"php",
			"sql",
			"dockerfile",
		},
		auto_install = true,
		sync_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
	---@param _ any
	---@param opts TSConfig
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
