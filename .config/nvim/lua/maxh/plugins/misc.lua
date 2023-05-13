return {
	{
		"dmmulroy/tsc.nvim",
		config = true,
	},
	{
		"folke/neodev.nvim",
		dependencies = {
			"nvim-dap-ui",
		},
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
	},
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
	{ "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
	"kkharji/sqlite.lua",
	"RRethy/vim-illuminate",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<Tab>",
					accept_word = false,
					accept_line = false,
					next = "<C-j>",
					prev = "<C-k>",
					dismiss = "<C-e>",
				},
			},
			panel = {
				enabled = false,
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		opts = {
			select = {
				-- Looking for a select that is:
				-- 1. Not Telescope (so it doesn't mess with "resume" history for searches)
				-- 2. Has numbers for quick selection like default select
				-- 3. Appears in the center of the window to minimize eye movement
				-- 4. Comes with no other baggage
				disabled = true,
			},
		},
		config = true,
	},
	"tpope/vim-abolish",
	"tpope/vim-commentary",
	"tpope/vim-fugitive",
	"L3MON4D3/LuaSnip",
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({ current_line_blame = true })
		end,
	},
}
