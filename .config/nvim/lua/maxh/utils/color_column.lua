local M = {}

-- Define a function to set colorcolumn for specific file types
function M.set_colorcolumn()
	local file_type = vim.bo.filetype
	if file_type == "rust" then
		vim.wo.colorcolumn = "100"
	else
		vim.wo.colorcolumn = "80"
	end
end

return M
