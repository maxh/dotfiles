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
	{ "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
	"kkharji/sqlite.lua",
	"RRethy/vim-illuminate",
	{ "stevearc/dressing.nvim", config = true },
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
	{
		"nvim-lualine/lualine.nvim",
	},
}
