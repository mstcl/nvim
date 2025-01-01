local augroup = require("core.utils").augroup
local lsp_signs = require("core.variables").lsp_signs

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
	["n"] = "",
	["no"] = "",
	["v"] = "--VISUAL--",
	["V"] = "--LINE--",
	[""] = "--BLOCK--",
	["s"] = "--SELECT--",
	["S"] = "--LINE--",
	[""] = "--BLOCK--",
	["i"] = "--INSERT--",
	["ic"] = "--INSERT--",
	["R"] = "--REPLACE--",
	["Rv"] = "--REPLACE--",
	["c"] = "--COMMAND--",
	["cv"] = "--VIM EX--",
	["ce"] = "--EX--",
	["r"] = "--PROMPT--",
	["rm"] = "--MOAR--",
	["r?"] = "--CONFIRM--",
	["!"] = "--SHELL--",
	["t"] = "--TERMINAL--",
}

local function group_number(num, sep)
	if num < 999 then
		return tostring(num)
	else
		num = tostring(num)
		return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
	end
end

---Get scrollbar
---@return string
function M.get_scrollbar()
	local sbar_chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }

	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
	local sbar = string.rep(sbar_chars[i], 2)

	return set_hl(sbar, "StatuslineScrollbar")
end

---Get modified status
---@return string
function M.get_modified()
	local hl = vim.bo.mod and "StatuslineModifiedInv" or "Statusline"
	return set_hl(" ● ", hl)
end

---Get current mode
---@return string
function M.get_mode()
	local hl = "Statusline"
	local mode = vim.fn.mode()
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO" or modes[mode]
	return set_hl(string.format("%s", mode_str), hl)
end

---Get LSP progress
---@return string
function M.get_lsp_progress()
	if not require("core.variables").lsp_enabled then
		return ""
	end
	return require("lsp-progress").progress()
end

if require("core.variables").lsp_enabled then
	augroup("lspProgress", {
		{ "User" },
		{
			pattern = "LspProgressStatusUpdated",
			callback = vim.schedule_wrap(function()
				vim.cmd("redrawstatus")
			end),
		},
	})
end

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

if require("core.variables").lsp_enabled then
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
end

---Get diagnostics for current buffer
---@return string
function M.get_lsp_diagnostic()
	if not require("core.variables").lsp_enabled then
		return ""
	end
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

---Get the directory name of the cwd
---@return string
function M.get_cwd_name()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function is_valid_git_repo(buf_id)
	-- Check if it's a valid buffer
	local path = vim.api.nvim_buf_get_name(buf_id)
	if path == "" or vim.fn.filereadable(path) ~= 1 then
		return false
	end

	-- Check if the current directory is a Git repository
	if vim.fn.isdirectory(".git") == 0 then
		return false
	end

	return true
end

local branch_cache = {}

-- Function to clear the Git branch cache
local function clear_git_branch_cache()
	-- Clear by doing an empty table :)
	branch_cache = {}
end

-- Autocommand to clear the Git branch cache when the directory changes
vim.api.nvim_create_autocmd("DirChanged", {
	callback = clear_git_branch_cache,
})

local function update_git_branch(data)
	if not is_valid_git_repo(data.buf) then
		return
	end

	-- Check if branch is already cached
	local cached_branch = branch_cache[data.buf]
	if cached_branch then
		vim.b.git_branch = cached_branch
		return
	end

	---@diagnostic disable-next-line: undefined-field
	local stdout = vim.uv.new_pipe(false)
	---@diagnostic disable-next-line: undefined-field
	local _, _ = vim.uv.spawn(
		"git",
		{
			args = { "-C", vim.fn.expand("%:p:h"), "branch", "--show-current" },
			stdio = { nil, stdout, nil },
		},
		vim.schedule_wrap(function(code, _)
			if code == 0 then
				stdout:read_start(function(_, content)
					if content then
						vim.b.git_branch = content:gsub("\n", "") -- Remove newline character
						branch_cache[data.buf] = vim.b.git_branch -- Cache the branch name
						stdout:close()
					end
				end)
			else
				stdout:close()
			end
		end)
	)
end

-- Call this function when the buffer is opened in a window
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = update_git_branch,
})

---Get current git branch
---@return string
function M.get_git_branch()
	---@diagnostic disable-next-line: undefined-field
	local branch = vim.b.git_branch or "nil"
	return set_hl("#", "StatuslineAlt") .. set_hl(branch, "StatusLineNC")
end

---Get git diffs for current buffer
---@return string
function M.get_diffs()
	---@diagnostic disable-next-line: undefined-field
	local diffs = vim.b.minidiff_summary
	if diffs ~= nil then
		local added = diffs.add or 0
		local changed = diffs.change or 0
		local removed = diffs.delete or 0
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
	return "nil"
end

function M.get_filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." or vim.bo.buftype == "terminal" then
		return ""
	end

	local secondary = set_hl(string.format("/%%<%s/", fpath), "StatuslineAlt")
	local root = set_hl(M.get_cwd_name(), "StatuslineNC")

	return root .. secondary
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
	if not require("core.variables").lsp_enabled then
		return ""
	end
	local symbol = require("nvim-navic").get_location()
	if symbol == "" then
		return ""
	end
	return "%#statuslinealt#(" .. symbol .. "%#statuslinealt#)"
end

---Get line count
local function get_vlinecount()
	local raw_count = vim.fn.line(".") - vim.fn.line("v")
	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

	return group_number(math.abs(raw_count), ",")
end

--- Get wordcount for current buffer or visual selection
--- @return string word count
function M.get_fileinfo()
	local lines = group_number(vim.api.nvim_buf_line_count(0), ",")
	local mode = vim.fn.mode()

	if mode == "v" or mode == "V" then
		return get_vlinecount() .. " lines selected"
	else
		return lines .. " lines"
	end
end

-- Components
M.components = {
	-- LSP symbol
	symbol = [[%{%v:lua.require'core.components'.get_symbol()%}]],
	-- Highlights
	hl_main = [[%#statuslinenc#]],
	hl_strong = [[%#statusline#]],
	hl_alt = [[%#statuslinealt#]],
	hl_orange = [[%#statuslineorange#]],
	hl_restore = [[%*]],
	-- LSP
	diagnostics = [[%{%v:lua.require'core.components'.get_lsp_diagnostic()%}]],
	progress = [[%{%v:lua.require'core.components'.get_lsp_progress()%}]],
	-- Git
	branch = [[%{%v:lua.require'core.components'.get_git_branch()%}]],
	diffs = [[%{%v:lua.require'core.components'.get_diffs()%}]],
	-- Misc
	align = [[%=]],
	truncate = [[%<]],
	open_bracket = [[(]],
	close_bracket = [[)]],
	padding = [[ ]],
	-- General
	filepath = [[%{%v:lua.require'core.components'.get_filepath()%}]],
	filename = [[%{%v:lua.require'core.components'.get_filename()%}]],
	pos = [[%{%&ru?" %#statuslinenc#%l%#statuslinealt#:%#statuslinenc#%2c %2p%#statuslinealt#%%":""%}]],
	cmd = [[%S]],
	modified = [[%{%v:lua.require'core.components'.get_modified()%}]],
	scrollbar = [[%{%v:lua.require'core.components'.get_scrollbar()%}]],
	mode = [[%{%v:lua.require'core.components'.get_mode()%}]],
	cwd = [[%{%v:lua.require'core.components'.get_cwd()%}]],
	info = [[%{%v:lua.require'core.components'.get_fileinfo()%}]],
	indentation = [[%{%&expandtab?"%#statuslinenc#shift%#statuslinealt#:":"%#statuslinenc#tab%#statuslinealt#:"%}%#statuslinenc#%{&shiftwidth}]],
	ft = [[%{%v:lua.require'core.components'.get_filetype()%}]],
	fformat = [[%{%v:lua.require'core.components'.get_fformat()%}]],
	fenc = [[%{%v:lua.require'core.components'.get_ffenc()%}]],
	search = [[%{%v:lua.require'core.components'.get_search_counts()%}]],
	macro = [[%{%v:lua.require'core.components'.get_macro_recording()%}]],
}

return M
