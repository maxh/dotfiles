return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>c",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			javascript = { "prettier" },
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			sql = { "sqlformat" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
		},
		format_on_save = { timeout_ms = 5000, lsp_fallback = true },
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			prettier = {
				cmd = "yarn prettier",
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
