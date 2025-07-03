local M = {}

local function extract_path(line)
	-- Try to match import/require paths first
	local path = line:match("from%s+['\"]([^'\"]+)['\"]")
		or line:match("require%s*%(%s*['\"]([^'\"]+)['\"]%s*%)")
	if not path then
		path = line:match("([%w_/%.%-]+)")
	end
	if not path then return nil end
	path = path:gsub("}$", "")

	local current_file = vim.fn.expand('%:p')
	local current_dir = vim.fn.fnamemodify(current_file, ':h')

	if path:match("^%.%./") or path:match("^%./") then
		path = vim.fn.fnamemodify(current_dir .. '/' .. path, ':p')
		path = vim.fn.fnamemodify(path, ':~:.' )
	elseif path:match("^src/") then
		local app_dir = current_file:match("(apps/[^/]+)")
		if app_dir then
			local src_root = app_dir .. "/src/"
			if current_file:find(src_root, 1, true) then
				path = src_root .. path:sub(5)
			else
				path = app_dir .. "/" .. path
			end
		else
			path = "apps/backend/" .. path -- fallback
		end
	else
		local app_or_lib, name = current_file:match("/(apps|lib)/([^/]+)/")
		if app_or_lib and name then
			if path:match("^" .. name .. "/") then
				path = app_or_lib .. "/" .. path
			elseif path:match("^common/") and app_or_lib == "lib" and name == "common" then
				path = "lib/common/" .. path:sub(#("common/") + 1)
			end
		end
	end

	if not path:match("%.ts$") and not path:match("%.js$") then
		path = path .. ".ts"
	end

	return path
end

function M.open_file_under_cursor()
	local line = vim.fn.getline(".")
	local path = extract_path(line)
	if path then
		vim.cmd("edit " .. path)
	else
		print("No file path found under cursor")
	end
end

return M 