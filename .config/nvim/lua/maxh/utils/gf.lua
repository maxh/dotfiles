local M = {}

local function extract_path(line)
	-- Try to match import/require paths first
	local path = line:match("from%s+['\"]([^'\"]+)['\"]") or line:match("require%s*%(%s*['\"]([^'\"]+)['\"]%s*%)")
	if not path then
		path = line:match("([%w_/%.%-]+)")
	end
	if not path then
		return nil
	end
	path = path:gsub("}$", "")

	local current_file = vim.fn.expand("%:p")
	local current_dir = vim.fn.fnamemodify(current_file, ":h")

	-- Handle @loop-payments/ imports
	local loop_pkg, loop_subpath = path:match("^@loop%-payments/([^/]+)/(.+)")
	if loop_pkg and loop_subpath then
		path = "lib/" .. loop_pkg .. "/src/" .. loop_subpath

	-- Relative imports
	elseif path:match("^%.%./") or path:match("^%./") then
		path = vim.fn.fnamemodify(current_dir .. "/" .. path, ":p")
		path = vim.fn.fnamemodify(path, ":~:.")
		-- Remove leading slash if present and normalize ./ patterns
		path = path:gsub("^/", "")
		path = path:gsub("/%.%/", "/")  -- Remove /./ 
		path = path:gsub("/%.%.$", "")  -- Remove trailing /.
		path = path:gsub("^%.%/", "")  -- Remove leading ./

	-- Imports starting with "src/" should be treated as root-relative
	elseif path:match("^src/") then
		-- If we're anywhere in apps/backend, prepend apps/backend/ to src/ imports
		if current_file:match("apps/backend") then
			path = "apps/backend/" .. path
		end
		-- Otherwise keep the path as-is

	-- Bare-style import: "corp/components/xyz"
	else
		local app_or_lib, name = current_file:match("^/(apps)/([^/]+)/")
		if not app_or_lib then
			app_or_lib, name = current_file:match("^/(lib)/([^/]+)/")
		end

		if app_or_lib and name then
			if path:match("^" .. name .. "/") then
				path = app_or_lib .. "/" .. path

			elseif path:match("^common/") and app_or_lib == "lib" and name == "common" then
				path = "lib/common/" .. path:sub(#"common/" + 1)
			end
		end
	end

	-- Add .ts or .tsx extension if no real file extension is present
	-- Heuristic:
	-- - 'shared' is always treated as a TSX component (shared.tsx)
	-- - When in a .ts or .tsx file:
	--     - UpperCamelCase last segment (base name before any dot) => assume .tsx
	--     - otherwise => assume .ts
	-- - Paths ending with TypeScript naming suffixes like .util, .types, etc. are NOT treated as real extensions
	-- - In all other cases, default to .ts
	local hasRealExtension = (
		path:match("%.tsx$") or path:match("%.ts$") or path:match("%.jsx$") or path:match("%.js$") or
		path:match("%.json$") or path:match("%.css$") or path:match("%.scss$") or path:match("%.sass$") or path:match("%.less$") or
		path:match("%.html$") or path:match("%.xml$") or path:match("%.svg$") or path:match("%.png$") or path:match("%.jpg$") or
		path:match("%.jpeg$") or path:match("%.gif$") or path:match("%.md$") or path:match("%.txt$")
	) ~= nil
	if not hasRealExtension then
		local lastSegment = path:match("([^/]+)$") or ""
		local baseName = lastSegment:match("([^%.]+)") or lastSegment
		if baseName == "shared" then
			path = path .. ".tsx"
		else
			local current_ext = vim.fn.expand("%:e")
			if current_ext == "ts" or current_ext == "tsx" then
				local isUpperCamel = baseName:match("^[A-Z][A-Za-z0-9]*$") ~= nil
				if isUpperCamel then
					path = path .. ".tsx"
				else
					path = path .. ".ts"
				end
			else
				path = path .. ".ts"
			end
		end
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
