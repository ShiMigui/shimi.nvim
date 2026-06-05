return {
	"nvim-telescope/telescope.nvim",
	version = "*",
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
		local map = vim.keymap.set

		map("n", "<leader>fh", b.help_tags, { desc = "Find Help" })
		map("n", "<leader>ff", b.find_files, { desc = "Find Files" })
		map("n", "<leader>fr", b.oldfiles, { desc = "Recent Files" })
		map("n", "<leader>fg", b.live_grep, { desc = "Find Grep" })
		map("n", "<leader>fs", b.current_buffer_fuzzy_find, { desc = "Find in Buffer" })
		map("n", "<leader>fn", function()
			b.find_files({ cwd = vim.fn.stdpath("config"), prompt_title = "Neovim Config" })
		end, { desc = "Find Config Files" })

		map("n", "gd", b.lsp_definitions, { desc = "Go to Definition" })
		map("n", "gr", b.lsp_references, { desc = "Go to References" })
		map("n", "gi", b.lsp_implementations, { desc = "Go to Implementation" })
		map("n", "<leader>dl", b.diagnostics, { desc = "List Diagnostics" })
		map("n", "<leader>gt", b.lsp_type_definitions, { desc = "Type Definition" })
		map("n", "<leader>ds", b.lsp_document_symbols, { desc = "Document Symbols" })
		map("n", "<leader>ws", b.lsp_workspace_symbols, { desc = "Workspace Symbols" })

		map("n", "<leader>gs", b.git_status, { desc = "Git Status" })
		map("n", "<leader>gc", b.git_commits, { desc = "Git Commits" })
		map("n", "<leader>gb", b.git_bcommits, { desc = "Git Buffer Commits" })
		map("n", "<leader>gB", b.git_branches, { desc = "Git Branches" })
	end,
}
