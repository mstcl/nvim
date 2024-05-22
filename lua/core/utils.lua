local autocmd = vim.api.nvim_create_autocmd
local groupid = vim.api.nvim_create_augroup

local M = {}

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

---Shortcut syntax to create autocmd with augroup
---@param group string
---@vararg { [1]: string|string[], [2]: vim.api.keyset.create_autocmd }
---@return nil
function M.augroup(group, ...)
	local id = groupid(group, { clear = true })
	for _, a in ipairs({ ... }) do
		a[2].group = id
		autocmd(unpack(a))
	end
end

---Detecting big file size (> 400 KB)
---Normally we want to pass `vim.fn.expand("%")`
---@ param filepath string
---@return boolean
function M.big(filepath)
	if vim.fn.getfsize(filepath) > 400 * 1024 then
		return true
	end
	return false
end

return M
