return {
	"sainnhe/sonokai",
	config = function()
		if vim.fn.has("termguicolors") == 1 then
			vim.o.termguicolors = true
		end
		vim.g.sonokai_style = "andromeda"
		vim.g.sonokai_better_performance = 1
		vim.cmd("colorscheme sonokai")
		require("lualine").setup({
			options = {
				theme = "sonokai",
			},
		})
	end,
}
