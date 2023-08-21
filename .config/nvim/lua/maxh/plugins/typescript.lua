-- Adds additional commands beyond the default TypeScript LSP.
return {
	"jose-elias-alvarez/typescript.nvim",
	opts = {
		disable_commands = false, -- prevent the plugin from creating Vim commands
		debug = false, -- enable debug logging for commands
		go_to_source_definition = {
			fallback = true, -- fall back to standard LSP definition on failure
		},
		server = { -- pass options to lspconfig's setup method
			on_attach = require("maxh.utils.lsp_on_attach").lsp_on_attach,
			filetypes = { "typescript", "typescriptreact" },
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			init_options = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					noUnusedParameters = false,
				},
			},
		},
	},
	config = function(_, opts)
		local typescript = require("typescript")
		typescript.setup(opts)
		local remap_opts = { silent = true, noremap = true }
		-- [c]ode [r]ename
		vim.keymap.set("n", "<leader>cr", "<cmd>TypescriptRenameFile<cr>", remap_opts)
		-- [c]ode add [i]mports
		vim.keymap.set("n", "<leader>ci", "<cmd>TypescriptAddMissingImports<cr>", remap_opts)
		-- [c]ode [o]rganize imports
		vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<cr>", remap_opts)
		-- [c]ode [f]ix all
		vim.keymap.set("n", "<leader>cf", "<cmd>TypescriptFixAll<cr>", remap_opts)
		-- [c]ode [d]elete unused variables
		vim.keymap.set("n", "<leader>cd", "<cmd>TypescriptRemoveUnused<cr>", remap_opts)
	end,
}
