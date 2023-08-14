vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
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
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, remap = false })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, remap = false })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, remap = false })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, remap = false })

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

-- Copy current file name to system clipboard.
-- "f" for "full path", "r" for "relative path", "l" for "link
vim.keymap.set("n", "<leader>mf", ":let @+=expand('%:p')<CR>", { silent = true, remap = false })
vim.keymap.set("n", "<leader>mr", ":let @+=fnamemodify(expand('%'), ':~:.')<CR>", { silent = true, remap = false })
vim.keymap.set(
	"n",
	"<leader>ml",
	":let @+=v:lua.require('maxh.github_link').get_github_url()<CR>",
	{ noremap = true, silent = true }
)
