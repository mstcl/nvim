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

local function pad_str(in_str, width, align)
	-- right aligns content
	-- https://vimhelp.org/options.txt.html#%27statusline%27
	local ralign_token = "%="

	local num_spaces = width - #in_str
	if num_spaces < 1 then
		num_spaces = 1
	end
	local spaces = string.rep(" ", num_spaces)

	if align == "left" then
		return table.concat({ in_str, spaces })
	end

	return table.concat({ spaces, in_str, ralign_token })
end

function M.get_fold(lnum)
	local fold = vim.g.foldcolumn
	if not fold then
		return ""
	end
	local fcs = vim.opt.fillchars:get()
	local foldopen = fcs.foldopen or "▾"
	local foldclose = fcs.foldclose or "▸"
	if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
		return "%#NonText#%= "
	end
	local str = vim.fn.foldclosed(lnum) == -1 and foldopen or foldclose
	return "%#NonText#%=" .. str .. " "
end

---Return line number in configured format.
---@return string
function M.lnumfunc(args)
	if not args.rnu and not args.nu then
		return ""
	end

	if args.virtnum ~= 0 then
		return pad_str("+", 4, "right") .. " "
	end

	local lnum = args.rnu and (args.relnum > 0 and args.relnum or (args.nu and args.lnum or 0)) or args.lnum

	return pad_str(tostring(lnum), 4, "right") .. " "
end

---Send a notification with info level for a timeout (ms)
---@param message string
---@return nil
function M.send_info_notification(message)
	vim.notify(message, vim.log.levels.INFO, {})
end

return M
