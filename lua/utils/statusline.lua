local augroup = require("utils.misc").augroup
local lsp_signs = require("user_configs").lsp_signs

local M = {}

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

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

---Get current mode
---@return string
function M.get_mode()
	local hl = vim.bo.mod and "StatuslineMode" or "StatuslineModified"
	local mode = vim.fn.mode()
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO" or modes[mode]
	return set_hl(string.format(" %s ", mode_str), hl)
end

---Get LSP progress
---@return string
function M.get_lsp_progress()
	return require("lsp-progress").progress()
end

augroup("lspProgress", {
	{ "User" },
	{
		pattern = "LspProgressStatusUpdated",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
})

local diagnostic_sign = {
	[1] = lsp_signs.Error,
	[2] = lsp_signs.Warn,
	[3] = lsp_signs.Info,
	[4] = lsp_signs.Hint,
}

local diagnostic_color = {
	[1] = "StatuslineOrange",
	[2] = "StatuslineYellow",
	[3] = "StatuslineRed",
	[4] = "StatuslineBlue",
}

augroup("diagnosticUpdate", {
	{ "DiagnosticChanged" },
	{
		desc = "Update diagnostics cache for the status line.",
		callback = function(info)
			local b = vim.b[info.buf]
			local diagnostic_cnt_cache = { 0, 0, 0, 0 }
			for _, diagnostic in ipairs(info.data.diagnostics) do
				diagnostic_cnt_cache[diagnostic.severity] = diagnostic_cnt_cache[diagnostic.severity] + 1
			end
			b.diagnostic_str_cache = nil
			b.diagnostic_cnt_cache = diagnostic_cnt_cache
		end,
	},
})

---Get diagnostics for current buffer
---@return string
function M.get_lsp_diagnostic()
	if vim.b.diagnostic_str_cache then
		return vim.b.diagnostic_str_cache
	end
	local str = ""
	local buf_cnt = vim.b.diagnostic_cnt_cache or {}
	for severity_nr, _ in ipairs({ "Error", "Warn", "Info", "Hint" }) do
		local cnt = buf_cnt[severity_nr] or 0
		if cnt > 0 then
			local icon_text = diagnostic_sign[severity_nr]
			local icon_hl = diagnostic_color[severity_nr]
			str = str .. (str == "" and "" or " ") .. set_hl(icon_text, icon_hl) .. set_hl(cnt, icon_hl)
		end
	end
	if str:find("%S") then
		str = str
	end
	vim.b.diagnostic_str_cache = str
	return str
end

---Get cwd
---@return string
function M.get_cwd()
	return vim.fn.pathshorten(vim.fn.getcwd(), 1)
end

---Get current git branch
---@return string
function M.get_git_branch()
	---@diagnostic disable-next-line: undefined-field
	local branch = "nil"
	if vim.b.gitsigns_status_dict ~= nil then
		branch = vim.b.gitsigns_status_dict.head
	end
	return set_hl("#", "StatuslineAlt") .. set_hl(branch, "StatusLineNC")
end

---Get git diffs for current buffer
---@return string
function M.get_diffs()
	---@diagnostic disable-next-line: undefined-field
	local diffs = "nil"
	if vim.b.gitsigns_status_dict ~= nil then
		diffs = vim.b.gitsigns_status_dict
		local added = diffs.added or 0
		local changed = diffs.changed or 0
		local removed = diffs.removed or 0
		if added == 0 and removed == 0 and changed == 0 then
			return "clean"
		end
		return string.format(
			"%s%s%s",
			set_hl("+" .. tostring(added), "StatuslineGreen"),
			set_hl("~" .. tostring(changed), "StatuslineMagenta"),
			set_hl("-" .. tostring(removed), "StatuslineRed")
		)
	end
	return diffs
end

function M.get_filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." or vim.bo.buftype == "terminal" then
		return ""
	end

	return string.format("%%<%s/", fpath)
end

function M.get_filename()
	local fname = vim.fn.expand("%:t")
	if vim.bo.filetype == "toggleterm" then
		return "#" .. vim.b.toggle_number
	end
	if fname == "" or vim.bo.buftype == "terminal" then
		return "nil"
	end
	return fname
end

function M.get_filetype()
	local ft = vim.bo.filetype
	if ft == "" then
		return "nil"
	else
		return (ft:gsub("^%l", string.upper))
	end
end

function M.get_search_counts()
	if vim.v.hlsearch == 1 then
		local sinfo = vim.fn.searchcount({ maxcount = 0 })
		local search_stat = sinfo.incomplete > 0 and "[?/?]"
			or sinfo.total > 0 and ("[%s/%s]"):format(sinfo.current, sinfo.total)
			or nil

		if search_stat ~= nil then
			return search_stat
		end
	end
	return ""
end

function M.get_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "[@" .. recording_register .. "]"
	end
end

function M.get_fformat()
	local ff = vim.bo.fileformat
	if ff == "unix" or ff == "" then
		return ""
	end
	return "[" .. ff .. "]"
end

function M.get_ffenc()
	local fe = vim.bo.fileencoding
	if fe == "utf-8" or fe == "" then
		return ""
	end
	return "[" .. fe .. "]"
end

function M.get_symbol()
	local symbol = require("nvim-navic").get_location()
	if symbol == "" then
		return ""
	end
	return "%#statuslinealt#(" .. symbol .. "%#statuslinealt#)"
end

-- Statusline/winbar components
local statusline_parts = {
	-- LSP symbol
	symbol = [[%{%v:lua.require'utils.statusline'.get_symbol()%}]],
	-- Highlights
	hl_main = [[%#statuslinenc#]],
	hl_strong = [[%#statusline#]],
	hl_alt = [[%#statuslinealt#]],
	hl_orange = [[%#statuslineorange#]],
	hl_restore = [[%*]],
	-- LSP
	diagnostics = [[%{%v:lua.require'utils.statusline'.get_lsp_diagnostic()%}]],
	progress = [[%{%v:lua.require'utils.statusline'.get_lsp_progress()%}]],
	-- Git
	branch = [[%{%v:lua.require'utils.statusline'.get_git_branch()%}]],
	diffs = [[%{%v:lua.require'utils.statusline'.get_diffs()%}]],
	-- Misc
	align = [[%=]],
	truncate = [[%<]],
	open_bracket = [[(]],
	close_bracket = [[)]],
	padding = [[ ]],
	-- General
	filepath = [[%{%v:lua.require'utils.statusline'.get_filepath()%}]],
	filename = [[%{%v:lua.require'utils.statusline'.get_filename()%}]],
	pos = [[%{%&ru?" %#statuslinenc#%l%#statuslinealt#:%#statuslinenc#%2c %2p%#statuslinealt#%%":""%}]],
	mode = [[%{%v:lua.require'utils.statusline'.get_mode()%}]],
	cwd = [[%{%v:lua.require'utils.statusline'.get_cwd()%}]],
	indentation = [[%{%&expandtab?"%#statuslinenc#shift%#statuslinealt#:":"%#statuslinenc#tab%#statuslinealt#:"%}%#statuslinenc#%{&shiftwidth}]],
	ft = [[%{%v:lua.require'utils.statusline'.get_filetype()%}]],
	fformat = [[%{%v:lua.require'utils.statusline'.get_fformat()%}]],
	fenc = [[%{%v:lua.require'utils.statusline'.get_ffenc()%}]],
	search = [[%{%v:lua.require'utils.statusline'.get_search_counts()%}]],
	macro = [[%{%v:lua.require'utils.statusline'.get_macro_recording()%}]],
}

function M.get_default_statusline()
	return table.concat({
		statusline_parts.mode,
		statusline_parts.padding,
		statusline_parts.hl_alt,
		statusline_parts.filepath,
		statusline_parts.hl_main,
		statusline_parts.filename,
		statusline_parts.padding,
		statusline_parts.hl_alt,
		statusline_parts.open_bracket,
		statusline_parts.hl_main,
		statusline_parts.ft,
		statusline_parts.padding,
		statusline_parts.branch,
		statusline_parts.padding,
		statusline_parts.hl_main,
		statusline_parts.diffs,
		statusline_parts.hl_alt,
		statusline_parts.close_bracket,
		statusline_parts.hl_main,
		statusline_parts.padding,
		statusline_parts.diagnostics,
		statusline_parts.truncate,
		-- Messy middle bit
		statusline_parts.align,
		statusline_parts.hl_alt,
		statusline_parts.macro,
		--
		statusline_parts.hl_alt,
		statusline_parts.search,
		--
		statusline_parts.hl_orange,
		statusline_parts.fformat,
		--
		statusline_parts.hl_orange,
		statusline_parts.fenc,
		-- Right most
		statusline_parts.align,
		statusline_parts.hl_alt,
		statusline_parts.progress,
		--
		statusline_parts.symbol,
		--
		statusline_parts.pos,
		--
		statusline_parts.padding,
		statusline_parts.indentation,
		--
		statusline_parts.padding,
		statusline_parts.hl_restore,
	}, "")
end

function M.get_default_winbar()
	return table.concat({
		statusline_parts.padding,
		statusline_parts.symbol,
		statusline_parts.align,
		statusline_parts.hl_alt,
		statusline_parts.progress,
	})
end

return M
