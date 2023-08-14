local M = {}

function escape_lua_pattern(str)
	return str:gsub("[-.*+?^$()%[%]%%]", "%%%0")
end

function get_relative_path_to_git_root()
	local current_file = vim.fn.expand("%:p")
	local git_root = vim.fn.system("git rev-parse --show-toplevel")
	git_root = vim.fn.trim(git_root)
	local git_root_pattern = escape_lua_pattern(git_root)
	local relative_path = current_file:gsub("^" .. git_root_pattern .. "/", "")
	relative_path = string.gsub(relative_path, "^/", "")
	return relative_path
end

function M.get_github_url()
	local remote_url = vim.fn.system("git remote -v | grep origin | head -1 | awk '{print $2}'")
	remote_url = string.gsub(remote_url, "^git@github.com:", "https://github.com/")
	remote_url = string.gsub(remote_url, "\n", "")
	remote_url = string.gsub(remote_url, ".git$", "")

	local main_branch = "main"
	local current_file = get_relative_path_to_git_root()
	return remote_url .. "/blob/" .. main_branch .. "/" .. current_file
end

function M.get_github_url_line()
	local github_url = M.get_github_url()
	local line_number = vim.fn.line(".")
	return github_url .. "#L" .. line_number
end

return M
