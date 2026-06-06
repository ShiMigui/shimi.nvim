---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	config = function()
		local ts = require("nvim-treesitter")
		local installed = {}
		for _, parser in ipairs(ts.get_installed()) do
			installed[parser] = true
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterAutoInstall", { clear = true }),
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match) or args.match

				if vim.api.nvim_buf_get_name(args.buf) ~= "" or not lang then
					return
				end

				if not installed[lang] then
					local ok = pcall(ts.install, lang)
					installed[lang] = ok
				end
				pcall(vim.treesitter.start, args.buf, lang)
			end,
		})
	end,
}
