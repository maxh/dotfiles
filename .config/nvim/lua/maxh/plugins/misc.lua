return {
  {
    "dmmulroy/tsc.nvim",
    config = true,
  },
  {
    "folke/neodev.nvim",
    dependencies = {
      "nvim-dap-ui",
    },
    opts = {
      library = { plugins = { "nvim-dap-ui" }, types = true },
    },
  },
  { "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
  "kkharji/sqlite.lua",
  "RRethy/vim-illuminate",
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        -- Looking for a select that is:
        -- 1. Not Telescope (so it doesn't mess with "resume" history for searches)
        -- 2. Has numbers for quick selection like default select
        -- 3. Appears in the center of the window to minimize eye movement
        -- 4. Comes with no other baggage
        disabled = true,
      },
    },
  },
  "tpope/vim-abolish",
  "tpope/vim-commentary",
  "tpope/vim-fugitive",
  "L3MON4D3/LuaSnip",
  {
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = { current_line_blame = true },
    config = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
