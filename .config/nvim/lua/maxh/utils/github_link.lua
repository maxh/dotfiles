local M = {}

local function escape_lua_pattern(str)
	return str:gsub("[-.*+?^$()%[%]%%]", "%%%0")
end

-- TODO: Auto strip out the oil prefex from eg:
-- https://github.com/loop-payments/backend/blob/main/oil:///Users/max/loop/backend/src/domain/platform/artifact-ingress/edi-ingress/

local function get_relative_path_to_git_root()
	local current_file = vim.fn.expand("%:p")
	local git_root = vim.fn.system("git rev-parse --show-toplevel")
	git_root = vim.fn.trim(git_root)
	local git_root_pattern = escape_lua_pattern(git_root)
	local relative_path = current_file:gsub("^" .. git_root_pattern .. "/", "")
	relative_path = string.gsub(relative_path, "^/", "")
	return relative_path
end

local function open_link_in_browser(link)
	local cmd = string.format("open %s", link)
	local job_id = vim.fn.jobstart(cmd, {
		on_exit = function(job_id, exit_code, _)
			if exit_code ~= 0 then
				print(string.format("Error opening link: %s", link))
			end
		end,
	})
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

function M.open_github_url()
	local github_url = M.get_github_url()
	open_link_in_browser(github_url)
end

function M.open_github_url_line()
	local github_url_line = M.get_github_url_line()
	open_link_in_browser(github_url_line)
end

return M
