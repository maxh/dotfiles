return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name)
				return name == ".DS_Store"
			end,
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			-- ["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			-- ["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["g."] = "actions.toggle_hidden",
		},
		use_default_keymaps = false,
	},
	config = function(_, opts)
		local oil = require("oil")
		vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
		oil.setup(opts)

		-- Map a keybinding to trigger the function
		vim.keymap.set("n", "<C-->", function()
			vim.cmd("vsplit")
			vim.cmd("wincmd l")
			vim.cmd(':lua require("oil").open()')
		end, { noremap = true, silent = true })
	end,
}
