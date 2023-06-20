return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.prettier,

				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.sql_formatter,
			},
			-- Run formatter on save.
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ timeout_ms = 5000 })
						end,
					})
				end
			end,
		})
	end,
}
