return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mxsdev/nvim-dap-vscode-js",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })

		vim.api.nvim_set_keymap(
			"n",
			"<leader>dj",
			':lua require("dap").run_last()<CR>',
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>db",
			':lua require("dap").toggle_breakpoint()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>di",
			':lua require("dap").step_into()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>do",
			':lua require("dap").step_over()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>du",
			':lua require("dap").step_out()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>dc",
			':lua require("dap").continue()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>dr",
			':lua require("dap").restart()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>dx",
			':lua require("dap").disconnect()<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>dt",
			':lua require("dapui").toggle()<CR>',
			{ noremap = true, silent = true }
		)

		require("dap-vscode-js").setup({
			node_path = "node",
			debugger_path = os.getenv("HOME") .. "/tools/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})
		local dap = require("dap")
		dap.adapters.lldb = {
			type = "executable",
			command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
			name = "lldb",
		}
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

		local dap = require("dap")
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},

				-- 💀
				-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
				--
				--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
				--
				-- Otherwise you might get the following error:
				--
				--    Error on launch: Failed to attach to the target process
				--
				-- But you should be aware of the implications:
				-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
				-- runInTerminal = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp

		require("dapui").setup({
			layouts = {
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 20,
				},
			},
		})
		local dapui = require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
	end,
}
