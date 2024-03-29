return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-smart-history.nvim",
		"smartpde/telescope-recent-files",
	},
	config = function()
		local telescope = require("telescope")

		telescope.load_extension("recent_files")
		telescope.load_extension("smart_history")

		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")

		local custom_actions = require("maxh.utils.telescope_actions")

		-- Grep
		vim.keymap.set("n", "<leader>fg", custom_actions.live_grep_args, {})
		vim.keymap.set("n", "<leader>fv", custom_actions.live_grep_args_in_search_dir, {})

		-- Grep word under cursor
		vim.keymap.set("n", "<leader>fw", custom_actions.grep_string, {})

		-- Find files
		vim.keymap.set("n", "<leader>ff", custom_actions.find_files, {})
		vim.keymap.set("n", "<leader>fc", custom_actions.find_files_in_search_dir, {})

		-- Resume previous
		vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, {})

		-- Find buffers
		vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})

		-- Find help
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})

		-- Find recent
		vim.keymap.set("n", "<leader><leader>", custom_actions.find_recent_files, { noremap = true, silent = true })
		telescope.setup({
			defaults = {
				history = {
					path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
					limit = 100,
				},
				mappings = {
					i = {
						["<C-j>"] = actions.cycle_history_next,
						["<C-k>"] = actions.cycle_history_prev,
					},
				},
				-- Use a .ignore file in the project root instead.
				-- file_ignore_patterns = {},
			},
			extensions = {
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-s>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
				},
			},
		})
	end,
}
