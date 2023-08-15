-- <leader>m* mappings
-- "m" for "maxh"

local opts = { noremap = true, silent = true }

-- Copy current file name to system clipboard.

-- [f]ull path
vim.keymap.set("n", "<leader>mf", ":let @+=expand('%:p')<CR>", opts)
-- [r]elative path
vim.keymap.set("n", "<leader>mr", ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", opts)
-- [u]rl
vim.keymap.set("n", "<leader>mu", ":let @+=v:lua.require('maxh.github_link').get_github_url()<CR>", opts)
-- [l]ine-specific url
vim.keymap.set("n", "<leader>ml", ":let @+=v:lua.require('maxh.github_link').get_github_url_line()<CR>", opts)

-- Open current file in GitHub in browser.

-- [o]pen [u]rl
vim.keymap.set("n", "<leader>mou", require("maxh.github_link").open_github_url, opts)
-- [o]pen [l]ine
vim.keymap.set("n", "<leader>mol", require("maxh.github_link").open_github_url_line, opts)
