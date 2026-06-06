--- @alias shimi.VimMode "n" | "v" | "x" | "s" | "o" | "!" | "i" | "l" | "c" | "t"

--- @class shimi.Keymap
--- @field modes? shimi.VimMode | shimi.VimMode[] The modes for which the keymap will be active. Defaults to "n".
--- @field lhs? string The key sequence that triggers the keymap.
--- @field leader? string If provided, the keymap will be prefixed with <leader>.
--- @field rhs? string | function The command or function to be executed.
--- @field cmd? string If provided, will be wrapped in <cmd> and <cr>.
--- @field esc? boolean If true, prepends <esc> to the RHS.
--- @field opts? vim.keymap.set.Opts Additional options for vim.keymap.set.

--- @class shimi.VimKeymap
--- @field modes shimi.VimMode | shimi.VimMode[]
--- @field lhs string
--- @field rhs string | function
--- @field opts vim.keymap.set.Opts

--- @alias shimi.KeymapList table<string, shimi.Keymap>

--- @type shimi.KeymapList
local keymaps = {}

--- Resolve and set a single keymap.
--- @param desc string The description of the keymap (used for the 'desc' option).
--- @param map shimi.Keymap The keymap definition.
local function resolve(desc, map)
	local lhs = map.lhs

	if not lhs then
		assert(map.leader, "Missing lhs/leader for: " .. desc)
		lhs = "<leader>" .. map.leader
	end

	local rhs = map.rhs

	if not rhs then
		assert(map.cmd, "Missing rhs/cmd for: " .. desc)
		local esc_prefix = map.esc and "<esc>" or ""
		rhs = esc_prefix .. "<cmd>" .. map.cmd .. "<cr>"
	end

	local opts = vim.tbl_deep_extend("force", { desc = desc }, map.opts or {})

	vim.keymap.set(map.modes or "n", lhs, rhs, opts)
end

-- Core Mappings
keymaps["Exit insert mode"] = { lhs = "jk", rhs = "<esc>", modes = "i" }
keymaps["Buffer quit"] = { leader = "bd", cmd = "bd!" }
keymaps["Quit all other buffers"] = {
	leader = "bD",
	rhs = function()
		local api = vim.api
		local current = api.nvim_get_current_buf()
		for _, b in ipairs(api.nvim_list_bufs()) do
			if b ~= current and api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then
				vim.cmd("bd " .. b)
			end
		end
	end,
}

-- Mini Mappings
keymaps["Open Mini Files"] = {
	lhs = "<C-e>",
	modes = { "n", "i" },
	rhs = function()
		require("mini.files").open()
	end,
}

-- LSP Mappings
keymaps["Format file"] = { lhs = "gf", rhs = vim.lsp.buf.format }
keymaps["Go to definition"] = { lhs = "gd", rhs = vim.lsp.buf.definition }
keymaps["Go to declaration"] = { lhs = "gD", rhs = vim.lsp.buf.declaration }
keymaps["Go to implementation"] = { lhs = "gi", rhs = vim.lsp.buf.implementation }
keymaps["Go to references"] = { lhs = "gr", rhs = vim.lsp.buf.references }
keymaps["Hover"] = { lhs = "K", rhs = vim.lsp.buf.hover }
keymaps["Signature help"] = { lhs = "<C-k>", modes = { "i", "n" }, rhs = vim.lsp.buf.signature_help }
keymaps["Rename symbol"] = { lhs = "rn", rhs = vim.lsp.buf.rename }
keymaps["Code action"] = { leader = "ca", modes = { "n", "v" }, rhs = vim.lsp.buf.code_action }
keymaps["Open diagnostics float"] = { lhs = "gl", rhs = vim.diagnostic.open_float }
keymaps["List diagnostics"] = { leader = "dl", rhs = vim.diagnostic.setloclist }
keymaps["Next diagnostic"] = {
	lhs = "]d",
	rhs = function()
		vim.diagnostic.jump({ count = 1 })
	end,
}
keymaps["Prev diagnostic"] = {
	lhs = "[d",
	rhs = function()
		vim.diagnostic.jump({ count = -1 })
	end,
}
keymaps["Toggle inlay hints"] = {
	leader = "th",
	rhs = function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end,
}

return {
	keymaps = keymaps,
	--- Resolve all registered global keymaps.
	resolve_all = function()
		for dsc, kmp in pairs(keymaps) do
			resolve(dsc, kmp)
		end
	end,
}
