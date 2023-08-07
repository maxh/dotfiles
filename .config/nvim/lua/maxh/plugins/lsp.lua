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
		vim.keymap.set("n", "<space>go", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
		vim.keymap.set("n", "<space>ge", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<space>gr", vim.diagnostic.goto_prev, opts)

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(_, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			-- Mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, bufopts)
		end

		require("lspconfig").tsserver.setup({
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact" },
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			init_options = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					noUnusedParameters = false,
				},
			},
		})

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
