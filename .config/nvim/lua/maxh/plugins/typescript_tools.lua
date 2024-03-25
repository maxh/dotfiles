-- Adds additional commands beyond the default TypeScript LSP.
return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		on_attach = require("maxh.utils.lsp_on_attach").lsp_on_attach,
		filetypes = { "typescript", "typescriptreact" },
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		settings = {
			expose_as_code_action = "all",
			tsserver_file_preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
		-- init_options = {
		-- 	preferences = {
		-- 		importModuleSpecifierPreference = "non-relative",
		-- 		noUnusedParameters = false,
		-- 		quotePreference = "single",
		-- 		autoImportFileExcludePatterns = {
		-- 			"dist/*",
		-- 			"@aws-sdk/client-textract",
		-- 		},
		-- 	},
		-- },
	},
	config = function(_, opts)
		local typescript_tools = require("typescript-tools")
		typescript_tools.setup(opts)
		local remap_opts = { silent = true, noremap = true }

		-- These are prefixed with "c" to match lsp_on_attach.

		-- [c]ode rename [f]ile
		vim.keymap.set("n", "<leader>cf", "<cmd>TSToolsRenameFile<cr>", remap_opts)
		-- [c]ode add [i]mports
		vim.keymap.set("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", remap_opts)
		-- [c]ode [o]rganize imports
		vim.keymap.set("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", remap_opts)
		-- [c]ode fi[x] all
		vim.keymap.set("n", "<leader>cx", "<cmd>TypescriptFixAll<cr>", remap_opts)
		-- [c]ode [d]elete unused variables
		vim.keymap.set("n", "<leader>cd", "<cmd>TSToolsRemoveUnusedImports<cr>", remap_opts)
	end,
}
