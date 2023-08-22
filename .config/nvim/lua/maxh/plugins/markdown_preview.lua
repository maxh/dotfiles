return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>MarkdownPreview", {})
    vim.api.nvim_set_keymap("n", "<M-s>", "<Plug>MarkdownPreviewStop", {})
    vim.api.nvim_set_keymap("n", "<C-p>", "<Plug>MarkdownPreviewToggle", {})
  end,
}
