---@alias MODE "n"|"i"|"t"|"r"|"v"
---@alias MODES MODE[]|MODE
---
---@class Mapping
---@field lhs? string
---@field leader? string
---@field cmd? string
---@field modes? MODES
---@field rhs? function|string
---@field opts? vim.keymap.set.Opts
---@field esc? boolean

local lsp = vim.lsp
local api = vim.api
local cmd = vim.cmd
local buf = lsp.buf
local inlay_hint = lsp.inlay_hint
local diagnostic = vim.diagnostic

local function toggle_inlay_hints()
	inlay_hint.enable(not inlay_hint.is_enabled())
end

local function jump_diagnostic(count)
	return function()
		diagnostic.jump({ count = count })
	end
end

---@type table<string, Mapping>
return {
	["exit insert mode"] = { lhs = "jk", modes = "i", esc = true },
	["buffer quit"] = { leader = "bd", cmd = "bd!" },
	["quit all others buffers"] = {
		leader = "bD",
		rhs = function()
			local current = api.nvim_get_current_buf()
			for _, b in ipairs(api.nvim_list_bufs()) do
				if b ~= current and api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then
					cmd("bd " .. b)
				end
			end
		end,
	},
	["format file"] = { leader = "gf", rhs = buf.format },

	["go to definition"] = { lhs = "gd", rhs = buf.definition },
	["go to declaration"] = { lhs = "gD", rhs = buf.declaration },
	["go to implementation"] = { lhs = "gi", rhs = buf.implementation },
	["go to references"] = { lhs = "gr", rhs = buf.references },

	["hover"] = { lhs = "K", rhs = buf.hover },
	["signature help"] = { lhs = "<C-k>", modes = { "i", "n" }, rhs = buf.signature_help },

	["rename symbol"] = { lhs = "rn", rhs = buf.rename },
	["code action"] = { leader = "ca", modes = { "n", "v" }, rhs = buf.code_action },

	["open diagnostics float"] = { lhs = "gl", rhs = diagnostic.open_float },
	["next diagnostic"] = { lhs = "]d", rhs = jump_diagnostic(1) },
	["prev diagnostic"] = { lhs = "[d", rhs = jump_diagnostic(-1) },
	["list diagnostics"] = { leader = "dl", rhs = diagnostic.setloclist },

	["add workspace folder"] = { leader = "wa", rhs = buf.add_workspace_folder },
	["remove workspace folder"] = { leader = "wr", rhs = buf.remove_workspace_folder },

	["toggle inlay hints"] = { leader = "th", rhs = toggle_inlay_hints },
}
