local uv = vim.uv or vim.loop
return {
  "mfussenegger/nvim-lint",
  ft = {
    "javascript",
    "javascriptreact",
    "lua",
    "prisma",
    "sh",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  opts = {
    linters_by_ft = {
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      lua = { "luacheck" },
      prisma = { "prisma_lint" },
      sh = { "shellcheck" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      yaml = { "yamllint" },
    },
    linters = {},
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters.prisma_lint = {
      cmd = "node",
      stdin = false,
      args = {
        "/Users/max/loop/prisma-lint/dist/cli.js",
        "-c",
        "/Users/max/loop/prisma-lint/example/.prismalintrc.json",
        "--output-format",
        "json" },
      append_fname = true,
      stream = 'both',
      ignore_exitcode = true,
      parser = function(output)
        local decoded = vim.json.decode(output)
        local diagnostics = {}
        if decoded == nil then
          return diagnostics
        end
        for _, violation in pairs(decoded["violations"]) do
          local location = violation.location
          table.insert(diagnostics, {
            lnum = location.startLine - 1,
            end_lnum = location.endLine - 1,
            col = location.startColumn - 1,
            end_col = location.endColumn,
            message = violation.message,
          })
        end
        return diagnostics
      end,
    }
    lint.linters_by_ft = opts.linters_by_ft
    for k, v in pairs(opts.linters) do
      lint.linters[k] = v
    end
    local timer = assert(uv.new_timer())
    local DEBOUNCE_MS = 500
    local aug = vim.api.nvim_create_augroup("Lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = aug,
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        timer:stop()
        timer:start(
          DEBOUNCE_MS,
          0,
          vim.schedule_wrap(function()
            if vim.api.nvim_buf_is_valid(bufnr) then
              vim.api.nvim_buf_call(bufnr, function()
                lint.try_lint(nil, { ignore_errors = true })
              end)
            end
          end)
        )
      end,
    })
    lint.try_lint(nil, { ignore_errors = true })
  end,
}
