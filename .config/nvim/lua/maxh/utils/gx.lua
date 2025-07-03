local M = {}

-- Only handle URLs in gx
local function open_url(url)
	os.execute("open " .. url)
end

local function extract_url(line)
	local url = line:match("<(https?://[^>]+)>")
		or line:match("%'(https?://[^%)]+)%'")
		or line:match("%((https?://[^%)]+)%)")
		or line:match("(https?://[^%s]+)")
	return url
end

function M.open_url_under_cursor()
	local line = vim.fn.getline(".")
	local url = extract_url(line)
	if url then
		open_url(url)
	else
		print("No URL found under cursor")
	end
end

return M
