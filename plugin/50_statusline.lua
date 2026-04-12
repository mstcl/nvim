-- Custom statusline

_G.statusline = {}
_G.statusline.components = {}

-- Filetypes where only a simple statusline is displayed (showing only the filetype)
local simple_filetypes = {
	"fyler",
	"fzf",
	"oil",
	"aerial",
	"grug-far",
	"NvimTree",
	"gitsigns-blame",
	"NeogitDiffView",
	"NeogitLogView",
	"codediff-explorer",
	"codediff-history",
	"nvim-undotree",
}

---Helper to highlight str with group hl in string representation
---@param str string
---@param hl string
---@return string
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

---Helper to determine whether a filetype is in the simple_filetypes table
---@return boolean is_simple_ft
local function is_simple_ft()
	return vim.tbl_contains(simple_filetypes, vim.bo.filetype)
end

---Helper to determine whether a filetype is a special buffer (in simple filetype or a terminal)
---@return boolean is_special_buf
local function is_special_buf() return is_simple_ft() or vim.bo.buftype == "terminal" end

---A list of modes mapped to a code displayed on the statusline
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

---A number helper or something idk
---@param num string
---@param sep string
---@return string number
local function group_number(num, sep)
	if num < 999 then
		return tostring(num)
	else
		num = tostring(num)
		return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
	end
end

-- State and config for git_branch (inlined from git-statusline.nvim)
local git_state = {
	by_root = {},
	inflight = {},
	timers = {},
	autocmds_setup = false,
}

---Setup autocmd to update git statuses
---@return nil
local function git_setup_autocmds()
	if git_state.autocmds_setup then return end
	git_state.autocmds_setup = true

	local group =
		vim.api.nvim_create_augroup("GitStatuslineBranchV2", { clear = true })
	vim.api.nvim_create_autocmd(
		{ "BufEnter", "BufWritePost", "FocusGained", "DirChanged" },
		{
			group = group,
			callback = function(args)
				_G.statusline.components.git_branch_refresh(args.buf)
			end,
		}
	)
end

---Get git root for current buffer
---@param buf integer
---@return string git_root
local function git_root_for_buf(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then return vim.fs.root(vim.fn.getcwd(0), { ".git" }) end
	return vim.fs.root(name, { ".git" })
end

---Parse git status into pretty string for statusline
---@param output string
---@return string parsed_git_status
local function parse_git_status(output)
	if not output or output == "" then return "" end

	local lines = vim.split(output, "\n", { trimempty = true })
	if #lines == 0 then return "" end

	local head = lines[1]
	if not vim.startswith(head, "## ") then return "" end

	local branch_info = head:sub(4)
	local branch = branch_info
	local ahead = tonumber(branch_info:match("ahead (%d+)") or "")
	local behind = tonumber(branch_info:match("behind (%d+)") or "")

	local local_branch = branch_info:match("^([^%.]+)%.%.")
		or branch_info:match("^([^%s]+)")
	if local_branch and local_branch ~= "" then branch = local_branch end

	if branch:match("^HEAD") then branch = "detached" end

	local dirty = (#lines > 1)

	local parts = { branch .. (dirty and "*" or "") }
	if ahead and ahead > 0 then parts[#parts + 1] = "↑" .. ahead end
	if behind and behind > 0 then parts[#parts + 1] = "↓" .. behind end

	return table.concat(parts, " ")
end

---Update git status
---@param root string
---@return nil
local function refresh_git_status(root)
	if git_state.inflight[root] then return end
	git_state.inflight[root] = true

	vim.system(
		{ "git", "status", "--porcelain=v1", "-b" },
		{ cwd = root },
		function(result)
			git_state.inflight[root] = nil
			if result.code ~= 0 then
				git_state.by_root[root] = ""
				return
			end
			git_state.by_root[root] = parse_git_status(result.stdout or "")
			vim.schedule(function() vim.cmd("redrawstatus") end)
		end
	)
end

---Schedule git status refresh
---@param root string
---@return nil
local function schedule_git_refresh(root)
	if git_state.timers[root] then return end
	local timer = vim.uv.new_timer()
	git_state.timers[root] = timer
	-- debounce for 200ms
	timer:start(200, 0, function()
		timer:stop()
		timer:close()
		git_state.timers[root] = nil
		refresh_git_status(root)
	end)
end

---Ensure git status is not empty
---@param root string
---@return nil
local function ensure_git_status(root)
	if git_state.by_root[root] == nil then
		git_state.by_root[root] = ""
		refresh_git_status(root)
		return
	end
	schedule_git_refresh(root)
end

---Refresh git status for git_branch
---@param buf number
_G.statusline.components.git_branch_refresh = function(buf)
	local root = git_root_for_buf(buf)
	if not root then return end
	schedule_git_refresh(root)
end

---[COMPONENT]
---Get git branch with ahead/behind counts (inlined from git-statusline.nvim)
---NOTE: https://github.com/mattmorgis/git-statusline.nvim/blob/main/lua/git_statusline/init.lua
---@return string git_branch
_G.statusline.components.git_branch = function()
	if is_special_buf() then return "" end

	git_setup_autocmds()
	local buf = vim.api.nvim_get_current_buf()
	local root = git_root_for_buf(buf)
	if not root then return "" end

	ensure_git_status(root)
	local status = git_state.by_root[root] or ""
	if status == "" then return "" end

	-- Extract branch name (first word, removing trailing *)
	local branch_name = status:match("^([^%s]+)") or ""
	branch_name = branch_name:gsub("%*$", "")

	-- Apply highlighting: main/master/nil are normal, feature branches are ErrorMsg
	local branch_hl = "StatusLineNC"
	if
		branch_name ~= "nil"
		and branch_name ~= "master"
		and branch_name ~= "main"
	then
		branch_hl = "ErrorMsg"
	end

	-- Parse status into parts: branch, ahead/behind
	-- Format: "branch*" or "branch* ↑2" or "branch* ↓3" or "branch* ↑2 ↓3"
	local branch_part = status:match("^([^%s]+)") or ""
	local ahead_behind = status:match("%s+(.+)$") or ""

	-- Apply highlighting to branch part only
	local highlighted_branch = set_hl(branch_part, branch_hl, false)

	-- Wrap ahead/behind in brackets with StatusLineAlt if present
	local result = highlighted_branch
	if ahead_behind ~= "" then
		local bracket_open = set_hl("[", "StatusLineAlt", false)
		local bracket_close = set_hl("]", "StatusLineAlt", false)
		local highlighted_ab = set_hl(ahead_behind, "StatusLineAlt", false)
		result = highlighted_branch
			.. " "
			.. bracket_open
			.. highlighted_ab
			.. bracket_close
	end

	local git_icon = set_hl(_G.config.signs.branch, "StatusLineAlt")
	return git_icon .. result
end

---[COMPONENT]
---Get current mode
---@return string mode
_G.statusline.components.mode = function()
	if is_simple_ft() then return "" end

	local mode = vim.api.nvim_get_mode().mode
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO"
		or modes[mode]
	local hl = vim.bo.mod and "StatusLineModifiedInv" or "StatusLineModeInv"
	return set_hl(string.format("%s", mode_str), hl)
end

---[COMPONENT]
---Get diagnostics for current buffer with padding and brackets added
---@return string lsp_diagnostic
_G.statusline.components.lsp_diagnostic = function()
	if is_special_buf() then return "" end

	local icon = set_hl(_G.config.signs.diagnostics, "StatusLineAlt")
	local status = vim.diagnostic.status() == "" and set_hl("ok", "StatusLineNC")
		or vim.diagnostic.status()
	return _G.statusline.components.open_bracket()
		.. icon
		.. status
		.. _G.statusline.components.close_bracket()
		.. _G.statusline.components.padding()
end

---[COMPONENT]
---Get cwd of current buffer nicely formatted
---@return string cwd
_G.statusline.components.cwd = function()
	return vim.fn.pathshorten(vim.fn.getcwd(), 1)
end

---[COMPONENT]
---Get git diffs for current buffer with adding and brackets added
---@return string git_diffs
_G.statusline.components.git_diffs = function()
	if is_special_buf() then return "" end

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

---[COMPONENT]
---Get file path with root
---@return string filepath
_G.statusline.components.filepath = function()
	if is_special_buf() then return "" end

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

---[COMPONENT]
---Get filename
---@return string filename
_G.statusline.components.filename = function()
	if is_special_buf() then return "" end

	local fname = vim.fn.expand("%:t")
	return set_hl(fname, "StatusLineBold")
end

---[COMPONENT]
---Get filetype
---@return string filetype
_G.statusline.components.filetype = function()
	local ft = vim.bo.filetype

	local s = ""

	-- priority important here
	if vim.tbl_contains(simple_filetypes, ft) then s = ft end
	if _G.big(vim.fn.expand("%")) then s = "BIG " end

	return set_hl(s:gsub("^%l", string.upper), "StatusLineModeInv")
end

---[COMPONENT]
---Get file icon
---@return string fileicon
_G.statusline.components.fileicon = function()
	if is_special_buf() then return "" end

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

---[COMPONENT]
---Get search information
---@return string search
_G.statusline.components.search = function()
	if is_special_buf() then return "" end

	if vim.v.hlsearch == 1 then
		local ok, sinfo = pcall(vim.fn.searchcount, { maxcount = 0 })
		if not ok or not sinfo or sinfo.total == nil then return "" end
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

---[COMPONENT]
---Get macro status
---@return string macro
_G.statusline.components.macro = function()
	if is_special_buf() then return "" end

	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return set_hl(" ● REC [" .. recording_register .. "] ", "DiagnosticError")
	end
end

---[COMPONENT]
---Get file format
---@return string fformat
_G.statusline.components.fformat = function()
	if is_special_buf() then return "" end

	local ff = vim.bo.fileformat
	if ff == "unix" or ff == "" then return "" end
	return set_hl("[" .. ff .. "]", "StatusLineYellow")
end

---[COMPONENT]
---Get file encoding
---@return string ffenc
_G.statusline.components.ffenc = function()
	if is_special_buf() then return "" end

	local fe = vim.bo.fileencoding
	if fe == "utf-8" or fe == "" then return "" end
	return set_hl("[" .. fe .. "]", "StatusLineYellow")
end

---[COMPONENT]
---Get line count
---@return string linecount
local function get_vlinecount()
	if is_special_buf() then return "" end

	local raw_count = vim.fn.line(".") - vim.fn.line("v")
	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

	return group_number(math.abs(raw_count), ",")
end

---[COMPONENT]
---Get wordcount for current buffer or visual selection
---@return string wordcount
_G.statusline.components.fileinfo = function()
	if is_special_buf() then return "" end

	local lines = group_number(vim.api.nvim_buf_line_count(0), ",")
	local mode = vim.api.nvim_get_mode().mode

	if mode == "v" or mode == "V" then
		return get_vlinecount() .. " lines selected"
	else
		return set_hl(lines .. " lines", "StatusLineAlt")
	end
end

---[COMPONENT]
---Get an open bracket char
---@return string open_bracket
_G.statusline.components.open_bracket = function()
	if is_special_buf() then return "" end

	return set_hl("(", "StatusLineAlt")
end

---[COMPONENT]
---Get a close bracket char
---@return string close_bracket
_G.statusline.components.close_bracket = function()
	if is_special_buf() then return "" end

	return set_hl(")", "StatusLineAlt")
end

---[COMPONENT]
---Get a whitespace padding char
---@return string padding
_G.statusline.components.padding = function()
	if is_special_buf() then return "" end

	return " "
end

---[COMPONENT]
---Get current file indentation info
---@return string indentation
_G.statusline.components.indentation = function()
	if is_special_buf() then return "" end

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

---[COMPONENT]
---Get a delimiter char
---@return string indentation
_G.statusline.components.delimiter = function()
	if is_special_buf() then return "" end

	return set_hl(_G.config.signs.delimiter, "StatusLineAlt")
end

---All components properly formatted and rendered
local rendered_components = {
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
	fileicon = [[%{%v:lua.statusline.components.fileicon()%}]],
	mode = [[%{%v:lua.statusline.components.mode()%}]],
	fileinfo = [[%{%v:lua.statusline.components.fileinfo()%}]],
	indentation = [[%{%v:lua.statusline.components.indentation()%}]],
	filetype = [[%{%v:lua.statusline.components.filetype()%}]],
	fformat = [[%{%v:lua.statusline.components.fformat()%}]],
	fenc = [[%{%v:lua.statusline.components.ffenc()%}]],
	search = [[%{%v:lua.statusline.components.search()%}]],
	macro = [[%{%v:lua.statusline.components.macro()%}]],
}

---Build the statusline from rendered_components
---@return string statusline
_G.statusline.get = function()
	return table.concat({
		" ",
		rendered_components.filetype,
		rendered_components.mode,
		rendered_components.padding,
		rendered_components.delimiter,
		rendered_components.padding,
		rendered_components.filepath,
		rendered_components.padding,
		rendered_components.git_branch,
		rendered_components.padding,
		rendered_components.delimiter,
		rendered_components.padding,
		rendered_components.fileicon,
		rendered_components.padding,
		rendered_components.filename,
		rendered_components.padding,
		rendered_components.git_diffs,
		rendered_components.lsp_diagnostics,
		rendered_components.truncate,
		-- Messy middle bit
		rendered_components.align,
		rendered_components.macro,
		--
		rendered_components.search,
		--
		rendered_components.fformat,
		--
		rendered_components.fenc,
		-- Right most
		rendered_components.align,
		--
		rendered_components.fileinfo,
		rendered_components.padding,
		--
		rendered_components.padding,
		rendered_components.indentation,
		rendered_components.padding,
	}, "")
end

---Set the statusline
---@return nil
_G.statusline.set = function() vim.o.statusline = "%!v:lua.statusline.get()" end

_G.statusline.set()
