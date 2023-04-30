return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mxsdev/nvim-dap-vscode-js",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")

    vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})

		vim.api.nvim_set_keymap(
			"n",
			"<Leader>dj",
			':lua require("dap").run_last()<CR>',
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<Leader>db",
			':lua require("dap").toggle_breakpoint()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>di",
			':lua require("dap").step_into()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>do",
			':lua require("dap").step_over()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>du",
			':lua require("dap").step_out()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>dc",
			':lua require("dap").continue()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>dr",
			':lua require("dap").restart()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>dx",
			':lua require("dap").disconnect()<CR>',
			{ noremap = true, silent = true }
		)

		require("dap-vscode-js").setup({
			node_path = "node",
			debugger_path = os.getenv("HOME") .. "/tools/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		for _, language in ipairs({ "typescript", "javascript" }) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch test current file (pwa-node with jest)",
					cwd = vim.fn.getcwd(),
					runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
					runtimeExecutable = "node",
					args = { "${file}", "--coverage", "false" },
					rootPath = "${workspaceFolder}",
					sourceMaps = true,
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					skipFiles = { "<node_internals>/**", "node_modules/**" },
				},
			}
		end

		require("dapui").setup()
		local dapui = require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
