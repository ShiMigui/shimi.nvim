return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	dependencies = {
		"jwalton512/vim-blade",
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})

		local api = vim.api
		api.nvim_create_autocmd("FileType", {
			group = api.nvim_create_augroup("TreesitterSetup", { clear = true }),
			callback = function(args)
				local buf = args.buf
				if not api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
					return
				end

				if api.nvim_buf_get_name(buf) == "" then
					return
				end

				local lang = vim.treesitter.language.get_lang(args.match) or args.match
				if not lang then
					return
				end

				local ts = require("nvim-treesitter.parsers")
				if not ts.has_parser(lang) then
					return
				end

				pcall(vim.treesitter.start, buf, lang)

				vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local", win = 0 })
				vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { scope = "local", win = 0 })
			end,
		})
	end,
}
