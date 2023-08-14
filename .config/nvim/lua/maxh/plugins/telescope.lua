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

		-- Grep
		vim.keymap.set("n", "<leader>fg", require("maxh.custom_actions").live_grep_args, {})
		vim.keymap.set("n", "<leader>fv", require("maxh.custom_actions").live_grep_args_in_search_dir, {})

		-- Grep word under cursor
		vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, {})

		-- Find files
		vim.keymap.set("n", "<leader>ff", require("maxh.custom_actions").find_files, {})
		vim.keymap.set("n", "<leader>fc", require("maxh.custom_actions").find_files_in_search_dir, {})

		-- Resume previous
		vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, {})

		-- Find buffers
		vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})

		-- Find help
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})

		-- Find recent
		vim.keymap.set(
			"n",
			"<Leader><Leader>",
			[[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
			{ noremap = true, silent = true }
		)
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
