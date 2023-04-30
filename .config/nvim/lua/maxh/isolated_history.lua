local function get_dir_name()
  local cwd = vim.fn.getcwd()
  if cwd == "" then
    return ".vim-state/global"
  else
    return vim.fn.fnamemodify(cwd, ":t") .. "/.vim-state"
  end
end

local function get_file_path(file_name)
  local dir_name = get_dir_name()
  return vim.fn.stdpath("data") .. "/" .. dir_name .. "/" .. file_name
end

-- Set Vim options and create directories on module load
vim.o.undodir = get_file_path("undo")
vim.o.backupdir = get_file_path("backup")
vim.o.directory = get_file_path("swap")
vim.cmd("set viminfo+=n" .. get_file_path("viminfo"))
vim.fn.mkdir(vim.fn.stdpath("data") .. "/" .. get_dir_name(), "p")

