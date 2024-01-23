local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Add readline bindings for command line
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-d>", "<Delete>")
vim.keymap.set("c", "<Esc>b", "<S-Left>")
vim.keymap.set("c", "<Esc>f", "<S-Right>")
vim.keymap.set("c", "<Esc>d", "<S-right><Delete>")
vim.keymap.set("c", "<C-g>", "<C-c>")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Page up and down, centering vertically each time.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { remap = false })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { remap = false })

-- Delete and paste without changing register content.
vim.keymap.set("v", "<leader>p", '"_dP', { remap = false })
vim.keymap.set("v", "<leader>d", '"_d', { remap = false })
vim.keymap.set("n", "<leader>d", '"_d', { remap = false })

-- Yank without changing register content.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { remap = false })
vim.keymap.set("n", "<leader>Y", [["+Y]], { remap = false })

-- Copy [f]ull path.
vim.keymap.set("n", "<leader>mf", ":let @+=expand('%:p')<CR>", opts)
-- Copy [r]elative path.
vim.keymap.set("n", "<leader>mr", ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", opts)
-- Copy wh[o]le-file URL.
vim.keymap.set("n", "<leader>mo", ":let @+=v:lua.require('maxh.utils.github_link').get_github_url()<CR>", opts)
-- Copy [l]ine-specific URL.
vim.keymap.set("n", "<leader>ml", ":let @+=v:lua.require('maxh.utils.github_link').get_github_url_line()<CR>", opts)
-- Open wh[o]le-file URL.
vim.keymap.set("n", "go", require("maxh.utils.github_link").open_github_url, opts)
-- Open [l]ine-specific URL.
vim.keymap.set("n", "gl", require("maxh.utils.github_link").open_github_url_line, opts)

-- Custom [m]ax ex[z]it Close all buffers, leave vim open, show greeter screen.
vim.keymap.set("n", "<leader>mz", ":bufdo bd<CR>:Alpha<CR>", opts)

-- Custom gx to open URLs.
vim.keymap.set("x", "gx", require("maxh.utils.gx").open_url_under_cursor, opts)
vim.keymap.set("n", "gx", require("maxh.utils.gx").open_url_under_cursor, opts)
