return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		require("mason").setup({
			automatic_installation = true,
		})
		require("mason-lspconfig").setup()
	end,
}
