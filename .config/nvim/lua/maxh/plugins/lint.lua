local uv = vim.uv or vim.loop
return {
  "mfussenegger/nvim-lint",
  ft = {
    "javascript",
    "javascriptreact",
    "lua",
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
      sh = { "shellcheck" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      yaml = { "yamllint" },
    },
    linters = {},
  },
  config = function(_, opts)
    local lint = require("lint")
    require('lint').linters.your_linter_name = {
      cmd = 'node /Users/max/loop/prisma-lint/dist/cli.js',
      stdin = false,
      args = { "--output-format", "json" },
      append_fname = true,
      stream = 'stdout',
      ignore_exitcode = false,
      parser = function(output, bufnr)
        local decoded = vim.json.decode(output)
        local diagnostics = {}
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
        local content = table.concat(lines, '\n')
        for _, match in pairs(decoded.matches or {}) do
          local byteidx = vim.fn.byteidx(content, match.offset)
          local line = vim.fn.byte2line(byteidx)
          local col = byteidx - vim.fn.line2byte(line)
          table.insert(diagnostics, {
            lnum = line - 1,
            end_lnum = line - 1,
            col = col + 1,
            end_col = col + 1,
            message = match.message,
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
