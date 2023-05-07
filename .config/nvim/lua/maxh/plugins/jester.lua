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
			runtimeArgs = { "$path_to_jest", "--no-coverage", "-t", "$result", "--", "$file" },
			runtimeExecutable = "node",
			args = { "${file}", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
	},
	config = function(_, opts)
		local jester = require("jester")
		vim.keymap.set("n", "<Leader>jd", function()
			jester.debug()
		end, { desc = "Open parent directory" })
		vim.keymap.set("n", "<Leader>jf", function()
			jester.debug_file()
		end, { desc = "Open parent directory" })
		vim.keymap.set("n", "<Leader>jl", function()
			jester.debug_last()
		end, { desc = "Open parent directory" })
		jester.setup(opts)
	end,
}
