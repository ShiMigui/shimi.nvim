local maps = require("core.keymap")

---@class HookOpts
---@field model? string
---@field prefix? string

--- Creates a reusable Parrot hook.
--- @param target string
--- @param template string
--- @param opts? HookOpts
--- @return fun(prt, params)
local function hook(target, template, opts)
	opts = opts or {}

	template = template .. "FT: {{filetype}} Generate only the code"

	return function(prt, params)
		prt.Prompt(params, prt.ui.Target[target], prt.get_model(opts.model or "command"), opts.prefix, template)
	end
end

return {
	"frankroeder/parrot.nvim",
	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	opts = {
		providers = {
			ollama = {
				name = "ollama",
				api_key = "ollama",
				endpoint = "http://localhost:11434/api/chat",
				params = {
					chat = {
						top_p = 0.95,
						num_predict = 4096,
					},
					command = {
						top_p = 0.95,
						num_predict = 2048,
					},
				},
				topic = { model = "dev-ia" },
				model = "dev-ia",
			},
		},
		hooks = {
			Implement = hook("rewrite", '"""{{selection}}""" Complete this implementation.'),
			FixBugs = hook("rewrite", '"""{{selection}}""" Fix bugs and improve reliability.'),
			Optimize = hook("rewrite", '"""{{selection}}""" Optimize this code without changing behavior.'),
			Tests = hook("append", '"""{{selection}}""" Generate tests.'),
			Explain = hook("popup", '"""{{selection}}""" Explain this code briefly and clearly.'),
			Ask = hook("popup", 'QUESTION="""{{command}}""" \n"""{{selection}}""" Answer briefly and clearly.'),
		},
		cmd_prefix = "Prt",
		toggle_target = "vsplit",
		chat_free_cursor = true,
		user_input_ui = "native",
		enable_preview_mode = false,
		enable_spinner = true,
		spinner_type = "dots",
	},

	config = function(_, opts)
		require("parrot").setup(opts)

		maps["New Chat"] = { leader = "an", cmd = "PrtChatNew" }
		maps["Rewrite"] = { leader = "ar", rhs = ":PrtRewrite ", modes = "v" }
		maps["Append"] = { leader = "aa", rhs = ":PrtAppend ", modes = { "n", "v" } }
		maps["Prepend"] = { leader = "ap", rhs = ":PrtPrepend ", modes = { "n", "v" } }
		maps["Implement"] = { leader = "ai", rhs = ":PrtImplement ", modes = { "n", "v" } }
		maps["Ask AI"] = { leader = "aq", rhs = ":PrtAsk ", modes = { "n", "v" } }
		maps["Retry"] = { leader = "at", cmd = "PrtRetry" }
	end,
}
