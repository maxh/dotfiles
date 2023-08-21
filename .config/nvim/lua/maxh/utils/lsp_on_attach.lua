local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.lsp_on_attach(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- [g]o to [r]eferences
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  -- [g]o to [d]eclaration
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  -- [g]o to [d]efinition
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  -- [g]o to [i]mplementation
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

  -- show type
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

  -- [c]ode [r]ename
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
  -- [c]ode [a]ction
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

  -- [f]ormat
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)

  -- Maybe delete these?
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workleader_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workleader_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
end

return M
