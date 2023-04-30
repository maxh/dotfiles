local set = vim.opt
set.background = "dark"
set.colorcolumn = "80"
set.expandtab = true -- Use spaces instead of tabs
set.number = true    -- Line numbers
set.relativenumber = true
set.shiftwidth = 2   -- Size of an indent
set.softtabstop = 2
set.tabstop = 2      -- Number of spaces tabs count for

require("maxh.isolated_history")
require("maxh.remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("maxh/plugins", {})

-- TO CONFIG
-- https://github.com/tpope/vim-dadbod
-- https://github.com/ruifm/gitlinker.nvim
-- https://github.com/kylechui/nvim-surround
-- https://github.com/joe-re/sql-language-server
-- Autocomplete class name based on file name
-- ESLint running in the background
-- Fix asterisk indentation on ESLint docs
-- tpope unimpaired plugin for buffer management
-- eslint.codeActionsOnSave -- only run import order eslint on save
-- debugging

-- FOR A NEW COMPUTER
-- mkdir ~/.local/share/nvim/databases/
-- install LSPs
-- install tsserver
-- install graphql-language-service-cli

-- TO REMEMBER
-- "*y to copy selection to system clipboard
-- yae - yank entire buffer, vae - select enter buffer
-- live grep args: "foo bar" baz -> search for foo bar in dir baz

-- FOR A NEW CODEBASE
-- Include Relay directives to get autocompletion:
--   https://github.com/graphql/graphiql/issues/2181#issuecomment-1088713441
