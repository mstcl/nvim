local function pad_str(in_str, width, align)
	-- right aligns content
	-- https://vimhelp.org/options.txt.html#%27statusline%27
	local ralign_token = "%="

	local num_spaces = width - #in_str
	if num_spaces < 1 then
		num_spaces = 1
	end
	---@diagnostic disable-next-line: param-type-not-match
	local spaces = string.rep(" ", num_spaces)

	if align == "left" then
		return table.concat({ in_str, spaces })
	end

	return table.concat({ spaces, in_str, ralign_token })
end

local function get_fold(lnum)
	local fcs = vim.opt.fillchars:get()
	local foldopen = fcs.foldopen or "▾"
	local foldclose = fcs.foldclose or "▸"
	if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
		return "%#LineNr#%= "
	end
	local str = vim.fn.foldclosed(lnum) == -1 and foldopen or foldclose
	return "%#LineNr#%=" .. str .. " "
end

---Return line number in configured format.
---@return string
local function lnumfunc(args)
	if not args.rnu and not args.nu then
		return ""
	end

	if args.virtnum ~= 0 then
		return pad_str("+", 4, "right") .. " "
	end

	local lnum = args.rnu and (args.relnum > 0 and args.relnum or (args.nu and args.lnum or 0)) or args.lnum

	return pad_str(tostring(lnum), 4, "right") .. " "
end

_G.statuscol = {}

---@diagnostic disable-next-line: duplicate-set-field
_G.statuscol.get = function()
	local win = vim.g.statusline_winid
	local args = {}

	args.lnum = vim.v.lnum
	args.relnum = vim.v.relnum
	args.virtnum = vim.v.virtnum

	args.nu = vim.api.nvim_get_option_value("nu", { win = win })
	args.rnu = vim.api.nvim_get_option_value("rnu", { win = win })

	return "%=%s" .. lnumfunc(args) .. get_fold(vim.v.lnum)
end

---@diagnostic disable-next-line: duplicate-set-field
_G.statuscol.set = function()
	vim.o.statuscolumn = "%!v:lua.statuscol.get()"
end

_G.statuscol.set()
