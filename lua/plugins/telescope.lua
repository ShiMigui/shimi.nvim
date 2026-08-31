local keymaps = require("config.keymaps").set

return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		defaults = {
			file_ignore_patterns = require("settings.ignore"),
		},
		extensions = {
			fzf = {
				fuzzy = true,
				case_mode = "smart_case",
				override_file_sorter = true,
				override_generic_sorter = true,
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
		local b = require("telescope.builtin")

		keymaps("Find Help", { leader = "fh", rhs = b.help_tags })
		keymaps("Find Files", { leader = "ff", rhs = b.find_files })
		keymaps("Recent Files", { leader = "fr", rhs = b.oldfiles })
		keymaps("Find Grep", { leader = "fg", rhs = b.live_grep })
		keymaps("Find in Buffer", { leader = "F", rhs = b.current_buffer_fuzzy_find })
		keymaps("Find Buffers", { leader = "fb", rhs = b.buffers })
		keymaps("List Diagnostics", { leader = "dl", rhs = b.diagnostics })
		keymaps("Type Definition", { leader = "gt", rhs = b.lsp_type_definitions })
		keymaps("Document Symbols", { leader = "ds", rhs = b.lsp_document_symbols })
		keymaps("Workspace Symbols", { leader = "ws", rhs = b.lsp_workspace_symbols })

		keymaps("Git Status", { leader = "gs", rhs = b.git_status })
		keymaps("Git Commits", { leader = "gc", rhs = b.git_commits })
		keymaps("Git Buffer Commits", { leader = "gb", rhs = b.git_bcommits })
		keymaps("Git Branches", { leader = "gB", rhs = b.git_branches })

		keymaps("Find Config Files", {
			leader = "fn",
			rhs = function()
				b.find_files({ cwd = vim.fn.stdpath("config"), prompt_title = "Neovim Config" })
			end,
		})
	end,
}
