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
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

		-- Done with typescript-tools.lua instead.
		-- require("lspconfig").tsserver.setup({})

		local on_attach = require("maxh.utils.lsp_on_attach").lsp_on_attach

		local clangd_capabilities = require("cmp_nvim_lsp").default_capabilities()
		clangd_capabilities.offsetEncoding = "utf-8"
		vim.lsp.config("clangd", {
			on_attach = on_attach,
			capabilities = clangd_capabilities,
		})
		vim.lsp.enable("clangd")

		vim.lsp.config("graphql", {
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact" },
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
		vim.lsp.enable("graphql")

		vim.lsp.config("rust_analyzer", {
			on_attach = on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
		vim.lsp.enable("rust_analyzer")

		vim.lsp.config("sqlls", {
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
		vim.lsp.enable("sqlls")

		vim.lsp.config("lua_ls", {
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
		vim.lsp.enable("lua_ls")
	end,
}
