return {
	"Vigemus/iron.nvim",
	config = function()
		local iron = require("iron.core")

		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					haskell = {
						command = { "ghci" },
					},
				},
				-- How the repl window will be displayed
				-- See below for more information
				repl_open_cmd = require("iron.view").split.vertical.botright(40),
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				send_motion = "<leader>sc",
				visual_send = "<leader>s",
				-- send_file = "<leader>sf",
				send_line = "<leader>sl",
				send_paragraph = "<leader>sp",
				send_until_cursor = "<leader>su",
				send_mark = "<leader>sm",
				mark_motion = "<leader>mc",
				mark_visual = "<leader>mc",
				remove_mark = "<leader>md",
				cr = "<leader>s<cr>",
				interrupt = "<leader>s<leader>",
				exit = "<leader>sq",
				clear = "<leader>cl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		})

		-- iron also has a list of commands, see :h iron-commands for all available commands
		vim.keymap.set("n", "<leader>rs", "<cmd>IronRepl<cr>")
		vim.keymap.set("n", "<leader>rr", "<cmd>IronRestart<cr>")
		vim.keymap.set("n", "<leader>rf", "<cmd>IronFocus<cr>")
		vim.keymap.set("n", "<leader>rh", "<cmd>IronHide<cr>")
		
		vim.keymap.set("n", "<leader>sf", function()
			local ft = vim.bo.filetype
			local file = vim.api.nvim_buf_get_name(0)
			-- Ensure we are sending to the correct REPL (haskell)
			if ft == "haskell" then
				require("iron.core").send(ft, string.format(":load %q", file))
				vim.cmd("IronFocus")
			else
				print("Please run this from a Haskell file.")
			end
		end)
	end,
}
