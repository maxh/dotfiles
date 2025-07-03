local M = {}

-- Define a function to open URLs in the default web browser or file paths in Neovim
local function open_url_or_path(target)
	if target:match("^https?://") then
		os.execute("open " .. target)
	else
		vim.cmd("edit " .. target)
	end
end

-- Define a function to extract the URL or path
local function extract_url(line)
	-- Try to match import/require paths first
	local url = line:match("from%s+['\"]([^'\"]+)['\"]")
		or line:match("require%s*%(%s*['\"]([^'\"]+)['\"]%s*%)")
		or line:match("<(https?://[^>]+)>")
		or line:match("%'(https?://[^%)]+)%'")
		or line:match("%((https?://[^%)]+)%)")
		or line:match("(https?://[^%s]+)")

	-- If it's not a full URL or import path, try matching a path-like pattern
	if not url then
		url = line:match("([%w_/%.%-]+)")
	end

	if url then
		url = url:gsub("}$", "") -- strip trailing }

		-- If path starts with src/domain, src/app, etc., prepend apps/backend/
		if
			url:match("^src/domain")
			or url:match("^src/app")
			or url:match("^src/system")
			or url:match("^src/config")
		then
			url = "apps/backend/" .. url
		end

		-- Append .ts if not already .ts or .js
		if not url:match("%.ts$") and not url:match("%.js$") then
			url = url .. ".ts"
		end
	end

	return url
end

-- Define a function to handle the gx mapping
function M.open_url_under_cursor()
	local line = vim.fn.getline(".")
	local url = extract_url(line)

	if url then
		open_url_or_path(url)
	else
		print("No URL or path found under cursor")
	end
end

return M
