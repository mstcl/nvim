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
	"vscode-diff-explorer",
}

local function is_simple_ft()
	return vim.tbl_contains(simple_filetypes, vim.bo.filetype)
end

local function is_special_bufs()
	return is_simple_ft() or vim.bo.buftype == "terminal"
end

---@type table<string, string>
local modes = {
	["n"] = "NOR",
	["no"] = "NOR",
	["v"] = "VIS",
	["V"] = "VIL",
	["^V"] = "VIB",
	["s"] = "SEL",
	["S"] = "LINE",
	["^S"] = "BLK",
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

---Get current mode
---@return string
_G.statusline.components.mode = function()
	if is_simple_ft() then return "" end

	local mode = vim.api.nvim_get_mode().mode
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO"
		or modes[mode]
	local hl = vim.bo.mod and "StatusLineModifiedInv" or "StatusLineModeInv"
	return set_hl(string.format("%s", mode_str), hl)
end

---Get diagnostics for current buffer
-- Padding and brackets added
---@return string
_G.statusline.components.lsp_diagnostic = function()
	if is_special_bufs() then return "" end

	local cog_icon = set_hl(_G.config.signs.diagnostics, "StatusLineAlt")
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

---Get current git branch
---@return string
_G.statusline.components.git_branch = function()
	if is_special_bufs() then return "" end

	---@diagnostic disable-next-line: undefined-field
	local branch = vim.b.gitsigns_head or "nil"
	if branch == "nil" or branch == "master" or branch == "main" then
		branch = set_hl(branch, "StatusLineNC")
	else
		branch = set_hl(branch, "ErrorMsg")
	end
	return set_hl(_G.config.signs.branch, "StatusLineAlt") .. branch
end

---Get git diffs for current buffer
-- Padding and brackets added
---@return string
_G.statusline.components.git_diffs = function()
	if is_special_bufs() then return "" end

	---@diagnostic disable-next-line: undefined-field
	local diffs = vim.b.gitsigns_status_dict
	local git_icon = set_hl(_G.config.signs.diff, "StatusLineAlt")

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

---Get file path with root
---@return string
_G.statusline.components.filepath = function()
	if is_special_bufs() then return "" end

	local ft = vim.bo.filetype
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	local root = set_hl(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), "StatusLineBold")
	local prefix = set_hl(_G.config.signs.file .. " ", "StatusLineAlt")
	local secondary = ""

	if fpath ~= "." then secondary = string.format("/%s", fpath) end
	secondary = set_hl(secondary, "StatusLineAlt")

	if ft == "oil" then
		return " "
			.. prefix
			.. set_hl(string.format("%s ", string.sub(fpath, 7)), "StatusLineNC")
	end

	return prefix .. root .. secondary
end

---Get filename
---@return string
_G.statusline.components.filename = function()
	if is_special_bufs() then return "" end

	local fname = vim.fn.expand("%:t")
	return set_hl(fname, "StatusLineBold")
end

---Get filetype
---@return string
_G.statusline.components.filetype = function()
	local ft = vim.bo.filetype

	local s = ""

	-- priority important here
	if vim.tbl_contains(simple_filetypes, ft) then s = ft end
	if _G.big(vim.fn.expand("%")) then s = "BIG " end

	return set_hl(s:gsub("^%l", string.upper), "StatusLineModeInv")
end

---Get file icon
---@return string
_G.statusline.components.icon = function()
	if is_special_bufs() then return "" end

	local fname = vim.fn.expand("%:t")
	local extension = vim.fn.fnamemodify(fname, ":e")
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return ""
	else
		local icon, highlight =
			devicons.get_icon(fname, extension, { default = true })
		return set_hl(icon, highlight)
	end
end

_G.statusline.components.search = function()
	if is_special_bufs() then return "" end

	if vim.v.hlsearch == 1 then
		local sinfo = vim.fn.searchcount({ maxcount = 0 })
		local search_stat = sinfo.incomplete > 0 and "[?/?]"
			or sinfo.total > 0 and set_hl(sinfo.current, "StatusLineAccent") .. set_hl(
				" out of ",
				"StatusLineAlt"
			) .. set_hl(sinfo.total, "StatusLineAccent")
			or ""

		if search_stat ~= "" then return search_stat end
	end
	return ""
end

_G.statusline.components.macro = function()
	if is_special_bufs() then return "" end

	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return set_hl("[@" .. recording_register .. "]", "StatusLineAlt")
	end
end

_G.statusline.components.fformat = function()
	if is_special_bufs() then return "" end

	local ff = vim.bo.fileformat
	if ff == "unix" or ff == "" then return "" end
	return set_hl("[" .. ff .. "]", "StatusLineYellow")
end

_G.statusline.components.ffenc = function()
	if is_special_bufs() then return "" end

	local fe = vim.bo.fileencoding
	if fe == "utf-8" or fe == "" then return "" end
	return set_hl("[" .. fe .. "]", "StatusLineYellow")
end

---Get line count
local function get_vlinecount()
	if is_special_bufs() then return "" end

	local raw_count = vim.fn.line(".") - vim.fn.line("v")
	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

	return group_number(math.abs(raw_count), ",")
end

--- Get wordcount for current buffer or visual selection
--- @return string word count
_G.statusline.components.fileinfo = function()
	if is_special_bufs() then return "" end

	local lines = group_number(vim.api.nvim_buf_line_count(0), ",")
	local mode = vim.api.nvim_get_mode().mode

	if mode == "v" or mode == "V" then
		return get_vlinecount() .. " lines selected"
	else
		return set_hl(lines .. " lines", "StatusLineAlt")
	end
end

_G.statusline.components.open_bracket = function()
	if is_special_bufs() then return "" end

	return set_hl("(", "StatusLineAlt")
end

_G.statusline.components.close_bracket = function()
	if is_special_bufs() then return "" end

	return set_hl(")", "StatusLineAlt")
end

_G.statusline.components.padding = function()
	if is_special_bufs() then return "" end

	return " "
end

_G.statusline.components.indentation = function()
	if is_special_bufs() then return "" end

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
	if is_special_bufs() then return "" end

	return set_hl(_G.config.signs.delimiter, "StatusLineAlt")
end

local blocks = {
	-- LSP
	lsp_diagnostics = [[%{%v:lua.statusline.components.lsp_diagnostic()%}]],
	-- Git
	git_branch = [[%{%v:lua.statusline.components.git_branch()%}]],
	git_diffs = [[%{%v:lua.statusline.components.git_diffs()%}]],
	-- Misc
	align = [[%=]],
	truncate = [[%<]],
	padding = [[%{%v:lua.statusline.components.padding()%}]],
	delimiter = [[%{%v:lua.statusline.components.delimiter()%}]],
	-- General
	filepath = [[%{%v:lua.statusline.components.filepath()%}]],
	filename = [[%{%v:lua.statusline.components.filename()%}]],
	icon = [[%{%v:lua.statusline.components.icon()%}]],
	mode = [[%{%v:lua.statusline.components.mode()%}]],
	fileinfo = [[%{%v:lua.statusline.components.fileinfo()%}]],
	indentation = [[%{%v:lua.statusline.components.indentation()%}]],
	filetype = [[%{%v:lua.statusline.components.filetype()%}]],
	fformat = [[%{%v:lua.statusline.components.fformat()%}]],
	fenc = [[%{%v:lua.statusline.components.ffenc()%}]],
	search = [[%{%v:lua.statusline.components.search()%}]],
	macro = [[%{%v:lua.statusline.components.macro()%}]],
}

---@diagnostic disable-next-line: duplicate-set-field
_G.statusline.get = function()
	return table.concat({
		" ",
		blocks.filetype,
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
		blocks.git_diffs,
		blocks.lsp_diagnostics,
		blocks.truncate,
		-- Messy middle bit
		blocks.align,
		blocks.macro,
		--
		blocks.search,
		--
		blocks.fformat,
		--
		blocks.fenc,
		-- Right most
		blocks.align,
		--
		blocks.fileinfo,
		blocks.padding,
		--
		blocks.padding,
		blocks.indentation,
		blocks.padding,
	}, "")
end

_G.statusline.set = function() vim.o.statusline = "%!v:lua.statusline.get()" end

_G.statusline.set()
