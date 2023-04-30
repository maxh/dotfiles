return {
	{
		"dmmulroy/tsc.nvim",
		config = true,
	},
	{ "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
	"kkharji/sqlite.lua",
	"RRethy/vim-illuminate",
	{ "stevearc/dressing.nvim", config = true },
	"tpope/vim-abolish",
	"tpope/vim-commentary",
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
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	},
}
