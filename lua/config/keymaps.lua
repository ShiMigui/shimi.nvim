local map = vim.keymap.set

-- General
map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("n", "<leader>bd", "<cmd>bd!<cr>", { desc = "Buffer quit" })
map("n", "<leader>bD", function()
	local api = vim.api
	local current = api.nvim_get_current_buf()
	for _, b in ipairs(api.nvim_list_bufs()) do
		if b ~= current and api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then
			vim.cmd("bd " .. b)
		end
	end
end, { desc = "Quit all other buffers" })

-- LSP (these are typically set on LspAttach, but can be global if we use a helper)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { buffer = bufnr }

		map("n", "gf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format file" })
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, opts)
		map("n", "rn", vim.lsp.buf.rename, opts)
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		map("n", "gl", vim.diagnostic.open_float, opts)
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)
		map("n", "<leader>dl", vim.diagnostic.setloclist, opts)
		map("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { buffer = bufnr, desc = "Toggle inlay hints" })
	end,
})
