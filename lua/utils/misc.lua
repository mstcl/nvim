local M = {}

function M.has_any_words_before()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.press(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

M.buffer_opts = {
	get_bufnrs = function()
		local bufs = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			bufs[vim.api.nvim_win_get_buf(win)] = true
		end
		return vim.tbl_keys(bufs)
	end,
}

M.barbecue_theme = {
	["bg"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("WinBar", true).background)),
	["mg"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Whitespace", true).foreground)),
	["fg"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Operator", true).foreground)),
	["hl"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Include", true).foreground)),
	["bl"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Function", true).foreground)),
}

return M
