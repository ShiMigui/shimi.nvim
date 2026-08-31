-- Autocommands
local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
	callback = vim.hl.on_yank,
	group = api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})

vim.diagnostic.config({
	float = {
		border = "rounded",
		source = true,
		focusable = true,
		style = "minimal",
	},
})

api.nvim_create_autocmd("CursorHold", { callback = vim.diagnostic.open_float })
