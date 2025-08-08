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
				-- importModuleSpecifierPreference is dynamically set in config() based on cwd
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
		-- Dynamically choose import style based on project path
		local cwd = vim.loop.cwd() or vim.fn.getcwd()
		local import_pref = "relative"
		if type(cwd) == "string" then
			if cwd:match("loop/frontend") then
				import_pref = "non-relative"
			elseif cwd:match("loop/backend") then
				import_pref = "relative"
			end
		end

		opts.settings = opts.settings or {}
		opts.settings.tsserver_file_preferences = opts.settings.tsserver_file_preferences or {}
		opts.settings.tsserver_file_preferences.importModuleSpecifierPreference = import_pref

		-- Wrap on_attach to set per-buffer preference based on full file path
		local original_on_attach = opts.on_attach
		opts.on_attach = function(client, bufnr)
			-- Compute preference from the buffer's absolute path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local per_file_pref = import_pref
			if type(bufname) == "string" and bufname ~= "" then
				if bufname:match("loop/frontend") then
					per_file_pref = "non-relative"
				elseif bufname:match("loop/backend") then
					per_file_pref = "relative"
				end
			end

			-- Apply to client settings and notify tsserver
			client.config.settings = client.config.settings or {}
			client.config.settings.tsserver_file_preferences = client.config.settings.tsserver_file_preferences or {}
			client.config.settings.tsserver_file_preferences.importModuleSpecifierPreference = per_file_pref
			pcall(function()
				client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
			end)

			if type(original_on_attach) == "function" then
				original_on_attach(client, bufnr)
			end
		end

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
