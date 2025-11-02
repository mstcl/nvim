---Highlight str with group hl in string representation
local function set_hl(str, hl, restore)
	restore = restore == nil or restore
	return restore and table.concat({
		"%#",
		hl,
		"#",
		str or "",
		"%*",
	}) or table.concat({ "%#", hl, "#", str or "" })
end

-- simple filetype for statusline
local simple_filetypes = {
	"",
	"fzf",
	"oil",
	"Fyler",
	"mason",
	"Lazy",
	"aerial",
	"grug-far",
	"NvimTree",
	"OverseerList",
	"OverseerForm",
	"gitsigns-blame",
	"NeogitStatus",
	"NeogitDiffView",
	"NeogitLogView",
	"DiffviewFileHistory",
	"DiffviewFiles",
}

local modes = {
	["n"] = "NOR",
	["no"] = "NOR",
	["v"] = "VIS",
	["V"] = "VIL",
	[""] = "VIB",
	["s"] = "SEL",
	["S"] = "LINE",
	[""] = "BLK",
	["i"] = "INS",
	["ic"] = "INS",
	["R"] = "REPL",
	["Rv"] = "REPL",
	["c"] = "CMD",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "PRM",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERM",
}

local lsp_diagnostic_signs = {
	[1] = _G.config.signs.lsp.Error,
	[2] = _G.config.signs.lsp.Warn,
	[3] = _G.config.signs.lsp.Info,
	[4] = _G.config.signs.lsp.Hint,
}

local lsp_diagnostic_colors = {
	[1] = "ErrorMsg",
	[2] = "WarningMsg",
	[3] = "InfoMsg",
	[4] = "HintMsg",
}

local function group_number(num, sep)
	if num < 999 then
		return tostring(num)
	else
		num = tostring(num)
		return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
	end
end

_G.statusline = {}
_G.statusline.components = {}

---Get scrollbar
---@return string
_G.statusline.components.scrollbar = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local sbar_chars =
		{ "▔", "🮂", "🬂", "🮃", "▀", "▄", "▃", "🬭", "▂", "▁" }

	local cur = vim.api.nvim_win_get_cursor(0)[1]
	local total = vim.api.nvim_buf_line_count(0)
	---@diagnostic disable-next-line: need-check-nil
	local idx = math.floor((cur - 1) / total * #sbar_chars) + 1

	---@diagnostic disable-next-line: param-type-not-match, need-check-nil
	return set_hl(sbar_chars[idx]:rep(2), "StatusLineScrollbar")
end

---Get modified status
---@return string
_G.statusline.components.modified = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local hl = vim.bo.mod and "StatusLineModifiedInv" or "StatusLine"
	return set_hl(" ● ", hl)
end

---Get current mode
---@return string
_G.statusline.components.mode = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end
	local mode = vim.fn.mode()
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO"
		or modes[mode]
	local hl = vim.bo.mod and "StatusLineModifiedInv" or "StatusLineModeInv"
	return set_hl(string.format("%s", mode_str), hl)
end

---Get diagnostics for current buffer
-- Padding and brackets added
---@return string
_G.statusline.components.lsp_diagnostic = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local cog_icon = set_hl("󰒓 ", "StatusLineAlt")
	local clients = vim.lsp.get_clients()
	local placeholder = set_hl("ok", "StatusLineNC")

	if #clients == 0 then return "" end

	if vim.b.diagnostic_str_cache then
		if vim.b.diagnostic_str_cache ~= "" then
			return _G.statusline.components.open_bracket()
				.. cog_icon
				.. vim.b.diagnostic_str_cache
				.. _G.statusline.components.close_bracket()
				.. _G.statusline.components.padding()
		else
			return _G.statusline.components.open_bracket()
				.. cog_icon
				.. placeholder
				.. _G.statusline.components.close_bracket()
				.. _G.statusline.components.padding()
		end
	end

	local str = ""
	local buf_cnt = vim.b.diagnostic_cnt_cache or {}

	for severity_nr, _ in ipairs({ "Error", "Warn", "Info", "Hint" }) do
		local cnt = buf_cnt[severity_nr] or 0
		if cnt > 0 then
			local icon_text = lsp_diagnostic_signs[severity_nr]
			local icon_hl = lsp_diagnostic_colors[severity_nr]
			str = str
				.. (str == "" and "" or " ")
				.. set_hl(icon_text, icon_hl)
				.. set_hl(cnt, icon_hl)
		end
	end
	if str:find("%S") then str = str end

	vim.b.diagnostic_str_cache = str

	if str ~= "" then
		return _G.statusline.components.open_bracket()
			.. cog_icon
			.. str
			.. _G.statusline.components.close_bracket()
			.. _G.statusline.components.padding()
	else
		return _G.statusline.components.open_bracket()
			.. cog_icon
			.. placeholder
			.. _G.statusline.components.close_bracket()
			.. _G.statusline.components.padding()
	end
end

---Get cwd
---@return string
_G.statusline.components.cwd = function()
	return vim.fn.pathshorten(vim.fn.getcwd(), 1)
end

---Get the directory name of the cwd
---@return string
_G.statusline.components.cwd_name = function()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

---Get current git branch
---@return string
_G.statusline.components.git_branch = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	---@diagnostic disable-next-line: undefined-field
	local branch = vim.b.gitsigns_head or "nil"
	return set_hl("󰘬 ", "StatusLineAlt") .. set_hl(branch, "StatusLineNC")
end

---Get git diffs for current buffer
-- Padding and brackets added
---@return string
_G.statusline.components.diffs = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	---@diagnostic disable-next-line: undefined-field
	local diffs = vim.b.gitsigns_status_dict
	local git_icon = set_hl(" ", "StatusLineAlt")

	if diffs ~= nil then
		local added = diffs.added or 0
		local changed = diffs.changed or 0
		local removed = diffs.removed or 0
		if added == 0 and removed == 0 and changed == 0 then
			return _G.statusline.components.open_bracket()
				.. git_icon
				.. set_hl("clean", "StatusLineNC")
				.. _G.statusline.components.close_bracket()
				.. _G.statusline.components.padding()
		end

		return _G.statusline.components.open_bracket()
			.. git_icon
			.. string.format(
				"%s%s%s",
				set_hl("+" .. tostring(added), "GitSignsAdd"),
				set_hl("~" .. tostring(changed), "GitSignsChange"),
				set_hl("-" .. tostring(removed), "GitSignsDelete")
			)
			.. _G.statusline.components.close_bracket()
			.. _G.statusline.components.padding()
	end

	return ""
end

---Get file root
---@return string
_G.statusline.components.root = function()
	return set_hl(_G.statusline.components.cwd_name(), "StatusLineNC")
end

---Get file path with root
---@return string
_G.statusline.components.filepath = function()
	local ft = vim.bo.filetype
	if vim.tbl_contains(simple_filetypes, ft) and ft ~= "oil" then return "" end

	local root = set_hl(_G.statusline.components.cwd_name(), "StatusLineNC")
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	local prefix = set_hl("@ ", "StatusLineAlt")

	if ft == "oil" then
		return set_hl(string.format(" %s ", string.sub(fpath, 7)), "StatusLineMode")
	end

	if fpath == "" or fpath == "." or vim.bo.buftype == "terminal" then
		return prefix .. root
	end

	local secondary = set_hl(string.format("/%%<%s", fpath), "StatusLineNC")

	return prefix .. root .. secondary
end

---Get filename
---@return string
_G.statusline.components.filename = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local fname = vim.fn.expand("%:t")
	if vim.bo.filetype == "toggleterm" then return "#" .. vim.b.toggle_number end
	if fname == "" or vim.bo.buftype == "terminal" then return "nil" end
	return set_hl(fname, "StatusLineNC")
end

---Get file icon
---@return string
_G.statusline.components.icon = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local fname = vim.fn.expand("%:t")
	local extension = vim.fn.fnamemodify(fname, ":e")
	local icon, highlight =
		require("nvim-web-devicons").get_icon(fname, extension, { default = true })

	return set_hl(icon, highlight)
end

---Get filetype for all files
---@return string
_G.statusline.components.filetype = function()
	local ft = vim.bo.filetype
	if vim.bo.buftype == "terminal" then
		return set_hl("TERMINAL", "StatusLineModeInv")
	elseif ft == "oil" then
		return ""
	elseif ft == "" then
		return "[No Name]"
	elseif vim.tbl_contains(simple_filetypes, ft) then
		return set_hl(string.format("%s", ft:upper()), "StatusLineModeInv")
	else
		return set_hl((ft:gsub("^%l", string.upper)), "StatusLineNC")
	end
end

---Get filetype for only ignored filetypes
---@return string
_G.statusline.components.filetype_2 = function()
	local ft = vim.bo.filetype
	if vim.bo.buftype == "terminal" then
		return set_hl("TERMINAL", "StatusLineModeInv")
	elseif ft == "oil" then
		return ""
	elseif ft == "" then
		return "[No Name]"
	elseif vim.tbl_contains(simple_filetypes, ft) then
		return set_hl(string.format("%s", ft:upper()), "StatusLineModeInv")
	else
		return ""
	end
end

_G.statusline.components.search_counts = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	if vim.v.hlsearch == 1 then
		local sinfo = vim.fn.searchcount({ maxcount = 0 })
		local search_stat = sinfo.incomplete > 0 and "[?/?]"
			or sinfo.total > 0 and ("[%s/%s]"):format(sinfo.current, sinfo.total)
			or -1

		if search_stat ~= -1 then return search_stat end
	end
	return ""
end

_G.statusline.components.macro_recording = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "[@" .. recording_register .. "]"
	end
end

_G.statusline.components.fformat = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local ff = vim.bo.fileformat
	if ff == "unix" or ff == "" then return "" end
	return "[" .. ff .. "]"
end

_G.statusline.components.ffenc = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local fe = vim.bo.fileencoding
	if fe == "utf-8" or fe == "" then return "" end
	return "[" .. fe .. "]"
end

---Get line count
local function get_vlinecount()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local raw_count = vim.fn.line(".") - vim.fn.line("v")
	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

	return group_number(math.abs(raw_count), ",")
end

--- Get wordcount for current buffer or visual selection
--- @return string word count
_G.statusline.components.fileinfo = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end

	local lines = group_number(vim.api.nvim_buf_line_count(0), ",")
	local mode = vim.fn.mode()

	if mode == "v" or mode == "V" then
		return get_vlinecount() .. " lines selected"
	else
		return "≡ " .. lines .. " lines"
	end
end

_G.statusline.components.open_bracket = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end
	return set_hl("(", "StatusLineAlt")
end

_G.statusline.components.close_bracket = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end
	return set_hl(")", "StatusLineAlt")
end

_G.statusline.components.padding = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end
	return " "
end

_G.statusline.components.indentation = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end
	---@diagnostic disable-next-line: undefined-field
	local expandtab_string = vim.opt.expandtab:get() and "shift" or "tab"
	---@diagnostic disable-next-line: undefined-field
	local shiftwidth_string = vim.opt.shiftwidth:get()
	return string.format(
		"%s%s%s",
		set_hl(expandtab_string, "StatusLineNC"),
		set_hl(":", "StatusLineAlt"),
		set_hl(shiftwidth_string, "StatusLineNC")
	)
end

_G.statusline.components.delimiter = function()
	if vim.tbl_contains(simple_filetypes, vim.bo.filetype) then return "" end
	return set_hl("·", "StatusLineAlt")
end

-- All blocks
local blocks = {
	-- LSP symbol
	symbol = [[%{%v:lua.statusline.components.symbol()%}]],
	-- Highlights
	hl_main = [[%#statuslinenc#]],
	hl_strong = [[%#statusline#]],
	hl_modified = [[%#statuslinemodified#]],
	hl_alt = [[%#statuslinealt#]],
	hl_mode = [[%#statuslinemode#]],
	hl_yellow = [[%#statuslineyellow#]],
	hl_restore = [[%*]],
	-- LSP
	lsp_diagnostics = [[%{%v:lua.statusline.components.lsp_diagnostic()%}]],
	lsp_progress = [[%{%v:lua.statusline.components.lsp_progress()%}]],
	-- Git
	git_branch = [[%{%v:lua.statusline.components.git_branch()%}]],
	diffs = [[%{%v:lua.statusline.components.diffs()%}]],
	-- Misc
	align = [[%=]],
	truncate = [[%<]],
	open_bracket = [[%{%v:lua.statusline.components.open_bracket()%}]],
	close_bracket = [[%{%v:lua.statusline.components.close_bracket()%}]],
	padding = [[%{%v:lua.statusline.components.padding()%}]],
	delimiter = [[%{%v:lua.statusline.components.delimiter()%}]],
	-- General
	root = [[%{%v:lua.statusline.components.root()%}]],
	filepath = [[%{%v:lua.statusline.components.filepath()%}]],
	filename = [[%{%v:lua.statusline.components.filename()%}]],
	icon = [[%{%v:lua.statusline.components.icon()%}]],
	pos = [[%{%&ru?" %#statuslinenc#%l%#statuslinealt#:%#statuslinenc#%2c %2p%#statuslinealt#%%":""%}]],
	cmd = [[%S]],
	modified = [[%{%v:lua.statusline.components.modified()%}]],
	scrollbar = [[%{%v:lua.statusline.components.scrollbar()%}]],
	mode = [[%{%v:lua.statusline.components.mode()%}]],
	cwd = [[%{%v:lua.statusline.components.cwd()%}]],
	info = [[%{%v:lua.statusline.components.fileinfo()%}]],
	indentation = [[%{%v:lua.statusline.components.indentation()%}]],
	ft = [[%{%v:lua.statusline.components.filetype()%}]],
	ft2 = [[%{%v:lua.statusline.components.filetype_2()%}]],
	fformat = [[%{%v:lua.statusline.components.fformat()%}]],
	fenc = [[%{%v:lua.statusline.components.ffenc()%}]],
	search = [[%{%v:lua.statusline.components.search_counts()%}]],
	macro = [[%{%v:lua.statusline.components.macro_recording()%}]],
}

---@diagnostic disable-next-line: duplicate-set-field
_G.statusline.get = function()
	return table.concat({
		" ",
		blocks.mode,
		blocks.padding,
		blocks.delimiter,
		blocks.padding,
		blocks.filepath,
		blocks.padding,
		blocks.git_branch,
		blocks.padding,
		blocks.delimiter,
		blocks.padding,
		blocks.icon,
		blocks.padding,
		blocks.filename,
		blocks.padding,
		blocks.ft2,
		blocks.diffs,
		blocks.lsp_diagnostics,
		blocks.truncate,
		-- Messy middle bit
		blocks.align,
		blocks.hl_alt,
		blocks.macro,
		--
		blocks.hl_alt,
		blocks.search,
		--
		blocks.hl_yellow,
		blocks.fformat,
		--
		blocks.hl_yellow,
		blocks.fenc,
		-- Right most
		blocks.align,
		--
		blocks.hl_alt,
		blocks.info,
		blocks.padding,
		--
		blocks.padding,
		blocks.indentation,
		blocks.padding,
		--
		blocks.hl_restore,
	}, "")
end

_G.statusline.set = function() vim.o.statusline = "%!v:lua.statusline.get()" end

_G.statusline.set()
