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
			javascript = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			yml = { "prettier" },
			yaml = { "prettier" },
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			sql = { "sqlformat" },
			toml = { "taplo" },
		},
		format_on_save = { timeout_ms = 5000, lsp_fallback = true },
        formatters = {
      prettier = {
        command = "yarn",
        args = { "prettier", "--stdin-filepath", "$FILENAME" },
        stdin = true,
        cwd = function()
          return vim.fn.getcwd()
        end,
      },
    },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
