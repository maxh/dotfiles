local ts_utils = require("nvim-treesitter.ts_utils")
local api = vim.api
local parsers = require("nvim-treesitter.parsers")

local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

function get_node_at_cursor_or_above(winnr)
	winnr = winnr or 0
	local cursor = api.nvim_win_get_cursor(winnr)
	local cursor_range = { cursor[1] - 1, cursor[2] }

	local buf = vim.api.nvim_win_get_buf(winnr)
	local root_lang_tree = parsers.get_parser(buf)
	if not root_lang_tree then
		return
	end
	local root = ts_utils.get_root_for_position(cursor_range[1], cursor_range[2], root_lang_tree)

	if not root then
		return
	end

	-- Fix because comments won't yield the correct root
	local cur_cursor_line = cursor_range[1]
	while cur_cursor_line > 0 and root:type() ~= "program" do
		cur_cursor_line = cur_cursor_line - 1
		root = ts_utils.get_root_for_position(cur_cursor_line, 0, root_lang_tree)
	end

	local found = root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
	return found
end

local function find_nearest_node_obj(identifiers, prepend, expressions)
	local node = get_node_at_cursor_or_above()
	while node do
		local node_type = node:type()
		if has_value(expressions, node_type) then
			local node_text = vim.treesitter.get_node_text(node, 0)
			local identifier = string.match(node_text, "^[a-zA-Z0-9]*")
			if has_value(identifiers, identifier) then
				return { node = node, from_identifier = true }
			elseif has_value(prepend, identifier) then
				return { node = node, from_identifier = false }
			end
		end
		node = node:parent()
	end
end

local function prepend_node(current_node, prepend, expressions)
	local node = current_node:parent()
	if not node then
		return
	end
	while node do
		local node_type = node:type()
		if has_value(expressions, node_type) then
			local node_text = vim.treesitter.get_node_text(node, 0)
			local identifier = string.match(node_text, "^[a-zA-Z0-9]*")
			if has_value(prepend, identifier) then
				return node
			end
		end
		node = node:parent()
	end
end

local function remove_quotations(stringCharacters, str)
	local result = str
	for index, value in ipairs(stringCharacters) do
		result = result:gsub("^" .. value, ""):gsub(value .. "$", "")
	end
	return result
end

local function get_identifier(node, stringCharacters)
	local child = node:child(1)
	local arguments = child:child(1)
	return remove_quotations(stringCharacters, vim.treesitter.get_node_text(arguments, 0))
end

local function regexEscape(str)
	return vim.fn.escape(str, '!"().+-*?^[]$')
end

local function get_result(o)
	local result
	local nearest_node_obj = find_nearest_node_obj(o.identifiers, o.prepend, o.expressions)
	if not nearest_node_obj or not nearest_node_obj.node then
		print(
			"Could not find any of the following: "
				.. table.concat(o.identifiers, ", ")
				.. ", "
				.. table.concat(o.prepend, ", ")
		)
		return
	end
	local nearest_node = nearest_node_obj.node
	result = get_identifier(nearest_node, o.stringCharacters)
	if o.prepend then
		local node = prepend_node(nearest_node, o.prepend, o.expressions)
		while node do
			local parent_identifier = get_identifier(node, o.stringCharacters)
			result = parent_identifier .. " " .. result
			node = prepend_node(node, o.prepend, o.expressions)
		end
	end
	if o.escapeRegex then
		result = regexEscape(result)
	end
	if o.regexStartEnd then
		result = "^" .. result
		if nearest_node_obj.from_identifier then
			result = result .. "$"
		end
	end
	return result
end

vim.api.nvim_set_keymap("n", "<Leader>dt", ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
