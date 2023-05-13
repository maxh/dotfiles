return {
	{
		"junegunn/goyo.vim",
		config = function()
			vim.keymap.set("n", "<Leader>zg", "<Cmd>:Goyo<CR>", { desc = "Goyo 'zen' mode" })
		end,
	},
	{
		"junegunn/limelight.vim",
		dependencies = { "junegunn/goyo.vim" },
		config = function()
			vim.g.limelight_paragraph_span = 0
			vim.api.nvim_create_autocmd("User", { pattern = "GoyoEnter", command = "Limelight" })
			vim.api.nvim_create_autocmd("User", { pattern = "GoyoLeave", command = "Limelight!" })
		end,
	},
}
