return {
	"j-morano/buffer_manager.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("buffer_manager").setup({
			select_menu_item_commands = {
				v = {
					key = "<C-v>",
					command = "vsplit",
				},
				h = {
					key = "<C-h>",
					command = "split",
				},
			},
			short_file_names = true,
			short_term_names = true,
		})
		local bmui = require("buffer_manager.ui")
		local opts = { noremap = true }
		local map = vim.keymap.set

		-- Navigate buffers bypassing the menu
		-- local keys = "1234567890"
		-- for i = 1, #keys do
		-- 	local key = keys:sub(i, i)
		-- 	map("n", string.format("<leader>%s", key), function()
		-- 		bmui.nav_file(i)
		-- 	end, opts)
		-- end

		-- Just the menu
		map({ "t", "n" }, "<M-Space>", bmui.toggle_quick_menu, opts)

		-- Open menu and search
		-- map({ "t", "n" }, "<M-m>", function()
		-- 	bmui.toggle_quick_menu()
		-- 	-- wait for the menu to open
		-- 	vim.defer_fn(function()
		-- 		vim.fn.feedkeys("/")
		-- 	end, 50)
		-- end, opts)

		-- Next/Prev
		map("n", "<M-j>", bmui.nav_next, opts)
		map("n", "<M-k>", bmui.nav_prev, opts)

		-- Just the menu
		map({ "t", "n" }, "<Leader>b", bmui.toggle_quick_menu, opts)

		-- Next/Prev
		map("n", "<M-j>", bmui.nav_next, opts)
		map("n", "<M-k>", bmui.nav_prev, opts)
	end,
}
