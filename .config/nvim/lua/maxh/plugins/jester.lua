return {
	"David-Kunz/jester",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mxsdev/nvim-dap-vscode-js",
	},
	opts = {
		dap = {
			type = "pwa-node",
			request = "launch",
			name = "Launch test current file (pwa-node with jest)",
			cwd = vim.fn.getcwd(),
			runtimeExecutable = "yarn",
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
	},
	config = function(_, opts)
		local jester = require("jester")
		-- Runs the block with the cursor on it in the current file.
		vim.keymap.set("n", "<leader>jd", function()
			jester.debug({
				dap = {
					runtimeArgs = { "test", "--no-coverage", "-t", "$result", "--", "$file" },
				},
			})
		end)
		-- Runs the current file.
		vim.keymap.set("n", "<leader>jf", function()
			jester.debug_file({
				dap = {
					runtimeArgs = { "test", "--no-coverage", "--", "$file" },
				},
			})
		end)
		vim.keymap.set("n", "<leader>jl", function()
			jester.debug_last()
		end)
		jester.setup(opts)
	end,
}
