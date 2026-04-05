-- Custom statuscolumn
-- NOTE: Wrapped symbols adapted from https://www.reddit.com/r/neovim/comments/1ggwaho/multiline_showbreaklike_wrapping_symbols_in/

_G.statuscol = {}

---Get the number of wrapped lines
---@return number
local function get_num_wraps()
	-- Calculate the actual buffer width, accounting for splits, number columns, and other padding
	local wrapped_lines = vim.api.nvim_win_call(0, function()
		local winid = vim.api.nvim_get_current_win()

		-- get the width of the buffer
		local winwidth = vim.api.nvim_win_get_width(winid)
		local numberwidth = vim.wo.number and vim.wo.numberwidth or 0
		local signwidth = vim.fn.exists("*sign_define") == 1
				and vim.fn.sign_getdefined()
				and 2
			or 0
		local foldwidth = vim.wo.foldcolumn or 0

		-- subtract the number of empty spaces in your statuscol. I have
		-- four extra spaces in mine, to enhance readability for me
		local bufferwidth = winwidth - numberwidth - signwidth - foldwidth - 4

		-- fetch the line and calculate its display width
		local line = vim.fn.getline(vim.v.lnum)
		local line_length = vim.fn.strdisplaywidth(line)

		return math.floor(line_length / bufferwidth)
	end)

	return wrapped_lines
end

---Pad a string with given width and alignment
---@param input string
---@param width number
---@param align string
---@return string output
local function pad_str(input, width, align)
	-- right aligns content
	-- https://vimhelp.org/options.txt.html#%27statusline%27
	local ralign_token = "%="

	local num_spaces = width - #input
	if num_spaces < 1 then num_spaces = 1 end
	---@diagnostic disable-next-line: param-type-not-match
	local spaces = string.rep(" ", num_spaces)

	if align == "left" then return table.concat({ input, spaces }) end

	return table.concat({ spaces, input, ralign_token })
end

---Return fold char (if available) for current linenumber
---@param virtnum integer
---@param lnum integer
---@return string fold
local function get_fold(virtnum, lnum)
	local fcs = vim.opt.fillchars:get()
	local foldopen = fcs.foldopen or "▾"
	local foldclose = fcs.foldclose or "▸"
	if virtnum > 0 then return " " end
	if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return " " end
	local str = vim.fn.foldclosed(lnum) == -1 and foldopen or foldclose
	return "%#LineNr#%=" .. str .. " %*"
end

---Return line number in configured format.
---@param args table
---@return string line_number
local function get_line_number(args)
	if not args.rnu and not args.nu then return "" end

	-- virtual line
	if args.virtnum < 0 then return "%#NonText#%=" .. " ·%*" end

	-- wrapped line
	if args.virtnum > 0 and (vim.wo.number or vim.wo.relativenumber) then
		local num_wraps = get_num_wraps()

		if vim.v.virtnum == num_wraps then
			return "%#NonText#%=" .. "└%*  "
		else
			return "%#NonText#%=" .. "├%*  "
		end
	end

	local lnum = args.rnu
			and (args.relnum > 0 and args.relnum or (args.nu and args.lnum or 0))
		or args.lnum

	return pad_str(tostring(lnum), 4, "right") .. " "
end

---Build the statuscol
---@return string statuscol
_G.statuscol.get = function()
	local win = vim.g.statusline_winid
	local args = {}

	args.lnum = vim.v.lnum
	args.relnum = vim.v.relnum
	args.virtnum = vim.v.virtnum

	args.nu = vim.api.nvim_get_option_value("nu", { win = win })
	args.rnu = vim.api.nvim_get_option_value("rnu", { win = win })

	return "%=%s" .. get_line_number(args) .. get_fold(args.virtnum, vim.v.lnum)
end

---Set the statuscol
---@return nil
_G.statuscol.set = function() vim.o.statuscolumn = "%!v:lua.statuscol.get()" end

_G.statuscol.set()
