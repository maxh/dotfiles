local M = {}

local find_command_files = { "rg", "--files", "--hidden", "-g", "!.git" }

local function get_dir(str, sep)
  return str:match("(.*/)")
end

local function get_dir_label(dir)
  return dir:match(".*/(.+)$") or dir
end

local function get_search_dir()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  if string.sub(buffer_name, 1, 6) == "oil://" then
    return string.sub(buffer_name, 7)
  elseif string.find(buffer_name, "/") then
    return get_dir(buffer_name)
  else
    return ""
  end
end

function M.find_files()
  require("telescope.builtin").find_files({
    find_command = find_command_files,
  })
end

function M.find_files_in_search_dir()
  local search_dir = get_search_dir()
  require("telescope.builtin").find_files({
    cwd = search_dir,
    prompt_title = string.format("Find Files in '%s'", get_dir_label(search_dir)),
    find_command = find_command_files,
  })
end

function M.live_grep_args()
  require("telescope").extensions.live_grep_args.live_grep_args()
end

function M.live_grep_args_in_search_dir()
  local search_dir = get_search_dir()
  require("telescope").extensions.live_grep_args.live_grep_args({
    search_dirs = { search_dir },
    prompt_title = string.format("Live Grep (Args) in '%s'", get_dir_label(search_dir)),
  })
end

return M
