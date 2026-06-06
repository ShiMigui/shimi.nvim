-- Autocommands
local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	callback = vim.highlight.on_yank,
	group = api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})

-- Diagnostic hover
api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float({
			border = "rounded",
			source = true,
			focusable = true,
			style = "minimal",
		})
	end,
})
