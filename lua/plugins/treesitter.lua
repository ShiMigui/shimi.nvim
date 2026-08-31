local keymaps = require("config.keymaps").set

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	event = "VeryLazy",
	config = function()
		local ts = require("nvim-treesitter")

		local installed = {}

		for _, parser in ipairs(ts.get_installed()) do
			installed[parser] = true
		end

		local available = {}

		for _, parser in ipairs(ts.get_available()) do
			available[parser] = true
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterAutoInstall", { clear = true }),

			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)

				-- Filetype não possui linguagem Tree-sitter
				if not lang then
					return
				end

				-- Não existe parser disponível para essa linguagem
				if not available[lang] then
					return
				end

				-- Já instalado
				if installed[lang] then
					pcall(vim.treesitter.start, args.buf, lang)
					return
				end

				-- Instala e registra como instalado
				local ok = pcall(ts.install, lang)

				if ok then
					installed[lang] = true
				end

				pcall(vim.treesitter.start, args.buf, lang)
			end,
		})

		keymaps("Treesitter node", {
			leader = "tn",
			rhs = function()
				local node = vim.treesitter.get_node()

				if not node then
					return
				end

				print(node:type())
			end,
		})
		keymaps("Treesitter inspect tree", {
			leader = "ti",
			rhs = function()
				local parser = vim.treesitter.get_parser()
				local tree = parser:parse()[1]

				print(tree:root():sexpr())
			end,
		})
	end,
}
