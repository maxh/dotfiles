local M = {}

-- Define a function to open URLs in the default web browser
local function open_url(url)
	os.execute("open " .. url)
end

-- Define a function to extract the URL or path
local function extract_url(line)
	local url = line:match("<(https?://[^>]+)>")
		or line:match("%'(https?://[^%)]+)%'")
		or line:match("%((https?://[^%)]+)%)")
		or line:match("(https?://[^%s]+)")

	-- If it's not a full URL, try matching a path-like pattern
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
	end

	return url
end

-- Define a function to handle the gx mapping
function M.open_url_under_cursor()
	local line = vim.fn.getline(".")
	local url = extract_url(line)

	if url then
		open_url(url)
	else
		print("No URL or path found under cursor")
	end
end

return M
