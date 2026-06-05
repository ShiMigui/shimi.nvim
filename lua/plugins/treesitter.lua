---@class TSConfig
---@field install_dir string?
---@field parsers string[]

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	dependencies = {
		"jwalton512/vim-blade",
	},
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		---@type TSConfig
		local config = {
			install_dir = vim.fn.stdpath("data") .. "/site",
			parsers = {
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
		}

		ts.setup({
			install_dir = config.install_dir,
		})

		ts.install(config.parsers)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
			callback = function(args)
				local buf = args.buf

				if not vim.api.nvim_buf_is_valid(buf) then
					return
				end

				if vim.bo[buf].buftype ~= "" then
					return
				end

				local buf_name = vim.api.nvim_buf_get_name(buf)
				if buf_name == "" then
					return
				end

				local lang = vim.treesitter.language.get_lang(args.match) or args.match
				if not lang then
					return
				end

				pcall(vim.treesitter.start, buf, lang)

				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
