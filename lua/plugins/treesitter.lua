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

		ts.setup()

		-- Install default parsers
		ts.install({
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
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

				-- Auto-install missing parsers
				if not ts.is_installed(lang) then
					ts.install(lang)
				end

				pcall(vim.treesitter.start, buf, lang)

				local wo = vim.wo[0][0]
				wo.foldmethod = "expr"
				wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
