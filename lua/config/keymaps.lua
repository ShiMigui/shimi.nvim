--- @alias shimi.VimMode "n" | "v" | "x" | "s" | "o" | "!" | "i" | "l" | "c" | "t"

--- @class shimi.Keymap
--- @field modes? shimi.VimMode | shimi.VimMode[] The modes for which the keymap will be active. Defaults to "n".
--- @field lhs? string The key sequence that triggers the keymap.
--- @field leader? string If provided, the keymap will be prefixed with <leader>.
--- @field rhs? string | function The command or function to be executed.
--- @field cmd? string If provided, will be wrapped in <cmd> and <cr>.
--- @field esc? boolean If true, prepends <esc> to the RHS.
--- @field opts? vim.keymap.set.Opts Additional options for vim.keymap.set.

--- Resolve and set a single keymap.
--- @param desc string The description of the keymap (used for the 'desc' option).
--- @param map shimi.Keymap The keymap definition.
local function set(desc, map)
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

	local opts = map.opts or {}
	opts.desc = desc
	vim.keymap.set(map.modes or "n", lhs, rhs, opts)
end

-- Core Mappings
set("Exit insert mode", { lhs = "jk", rhs = "<esc>", modes = "i" })
set("Buffer quit", { leader = "bd", cmd = "bd!" })
set("Quit all other buffers", {
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
})

return { set = set }
