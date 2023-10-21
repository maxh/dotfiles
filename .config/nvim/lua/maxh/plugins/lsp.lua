return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true,
		})

		-- Recommended key bindings from
		-- https://github.com/neovim/nvim-lspconfig
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>go", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
		vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>gr", vim.diagnostic.goto_prev, opts)

		-- Done in typescript.lua instead.
		-- require("lspconfig").tsserver.setup({})

		local on_attach = require("maxh.utils.lsp_on_attach").lsp_on_attach

		local clangd_capabilities = require("cmp_nvim_lsp").default_capabilities()
		clangd_capabilities.offsetEncoding = "utf-8"
		require("lspconfig").clangd.setup({
			on_attach = on_attach,
			capabilities = clangd_capabilities,
		})

		require("lspconfig").graphql.setup({
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact" },
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("lspconfig").rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("lspconfig").sqlls.setup({
			on_attach = on_attach,
			filetypes = { "sql" },
			cmd = {
				"/Users/maxheinritz/personal/sql-language-server/packages/server/npm_bin/cli.js",
				"up",
				"--method",
				"stdio",
			},
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
			filetypes = { "lua" },
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
	end,
}
