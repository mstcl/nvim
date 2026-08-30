-- Custom statusline
local config = _G.config
local set_hl = _G.helpers.set_hl

---@type table
_G.statusline = {}

---@type table
_G.statusline.components = {}

---Get an open bracket char
---@return string open_bracket
local open_bracket = function() return set_hl("[", "MoreMsg") end

---Get a close bracket char
---@return string close_bracket
local close_bracket = function() return set_hl("]", "MoreMsg") end

-- Filetypes where only a simple statusline is displayed (showing only the filetype)
local simple_filetypes = {
	"",
	"fyler_finder",
	"fzf",
	"oil",
	"grip_schema",
	"grip-welcome",
	"aerial",
	"grug-far",
	"NvimTree",
	"gitsigns-blame",
	"NeogitDiffView",
	"NeogitLogView",
	"codediff-explorer",
	"codediff-history",
	"nvim-undotree",
	"help",
}

local simple_buftypes = {
	"terminal",
	"nofile",
	"help",
	"quickfix",
}

---Helper to determine whether a buftype is in the simple_buftypes table
---@return boolean is_simple_ft
local is_simple_bt = function()
	return vim.tbl_contains(simple_buftypes, vim.bo.buftype)
end

---Helper to determine whether a filetype is in the simple_filetypes table
---@return boolean is_simple_ft
local is_simple_ft = function()
	return vim.tbl_contains(simple_filetypes, vim.bo.filetype)
end

---Helper to determine whether a filetype is a special buffer (in simple filetype or a terminal)
---@return boolean is_special_buf
local is_special_buf = function() return is_simple_ft() or is_simple_bt() end

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

-- State and config for git (inlined from git-statusline.nvim)
local git_state = {
	by_root = {},
	inflight = {},
	timers = {},
	autocmds_setup = false,
}

---Get git root for current buffer
---@param buf integer
---@return string git_root
local git_root_for_buf = function(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then return vim.fs.root(vim.fn.getcwd(0), { ".git" }) end
	return vim.fs.root(name, { ".git" })
end

---Schedule git status refresh
---@param root string
---@return nil
local schedule_git_refresh = function(root)
	if git_state.timers[root] then return end
	local timer = vim.uv.new_timer()
	git_state.timers[root] = timer
	-- debounce for 200ms
	timer:start(200, 0, function()
		timer:stop()
		timer:close()
		git_state.timers[root] = nil

		-- refresh git status
		if git_state.inflight[root] then return end
		git_state.inflight[root] = true
		vim.system(
			{ "git", "status", "--porcelain=v1", "-b" },
			{ cwd = root },
			function(result)
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
					if local_branch and local_branch ~= "" then
						branch = local_branch
					end

					if branch:match("^HEAD") then branch = "detached" end

					local dirty = (#lines > 1)

					local parts = { branch .. (dirty and "*" or "") }
					if ahead and ahead > 0 then
						parts[#parts + 1] = "↑" .. ahead
					end
					if behind and behind > 0 then
						parts[#parts + 1] = "↓" .. behind
					end

					return table.concat(parts, " ")
				end

				git_state.inflight[root] = nil
				local new_status = ""
				if result.code == 0 then
					new_status = parse_git_status(result.stdout or "")
				end
				if git_state.by_root[root] == new_status then return end
				git_state.by_root[root] = new_status
				vim.schedule(function() vim.cmd("redrawstatus") end)
			end
		)
	end)
end

---Setup autocmd to update git statuses
---@return nil
local git_setup_autocmds = function()
	if git_state.autocmds_setup then return end
	git_state.autocmds_setup = true

	---Refresh git status for git
	---@param buf number
	local git_branch_refresh = function(buf)
		local root = git_root_for_buf(buf)
		if not root then return end
		schedule_git_refresh(root)
	end

	local group =
		vim.api.nvim_create_augroup("GitStatuslineBranchV2", { clear = true })
	vim.api.nvim_create_autocmd(
		{ "BufEnter", "BufWritePost", "FocusGained", "DirChanged" },
		{
			group = group,
			callback = function(args) git_branch_refresh(args.buf) end,
		}
	)
end

---Get git diffs for current buffer with adding and brackets added
---@return string git_diffs
local git_diffs = function()
	if is_special_buf() then return "" end

	---@diagnostic disable-next-line: undefined-field
	local diffs = vim.b.gitsigns_status_dict

	if diffs ~= nil then
		if diffs.added == 0 and diffs.removed == 0 and diffs.changed == 0 then
			return ""
		end

		local items = {}
		if diffs.added ~= 0 then
			table.insert(items, set_hl("+" .. tostring(diffs.added), "MoreMsg"))
		end

		if diffs.changed ~= 0 then
			table.insert(items, set_hl("~" .. tostring(diffs.changed), "MoreMsg"))
		end

		if diffs.changed ~= 0 then
			table.insert(items, set_hl("-" .. tostring(diffs.removed), "MoreMsg"))
		end

		return table.concat(items, " ")
	end

	return ""
end

---[COMPONENT]
---Get git branch with ahead/behind counts (inlined from git-statusline.nvim)
---NOTE: https://github.com/mattmorgis/git-statusline.nvim/blob/main/lua/git_statusline/init.lua
---@return string git
_G.statusline.components.git = function()
	---Ensure git status is not empty has been computed at least once for a root.
	---Purely for the initial population; does NOT reschedule on every call so
	---that the render path stays side-effect free (avoids a redraw<->refresh loop).
	---@param root string
	---@return nil
	local ensure_git_status = function(root)
		if git_state.by_root[root] == nil then
			git_state.by_root[root] = ""
			schedule_git_refresh(root)
		end
	end

	if is_special_buf() then return "" end

	git_setup_autocmds()
	local buf = vim.api.nvim_get_current_buf()
	local root = git_root_for_buf(buf)
	if not root then return "" end

	-- Populate once on first sight of a root; afterwards the value is only
	-- updated by the autocmds. The render path must not reschedule refreshes
	-- on every draw, otherwise redrawstatus <-> refresh forms a loop
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

	-- Wrap ahead/behind in brackets with MoreMsg if present
	local result = highlighted_branch
	if ahead_behind ~= "" or git_diffs ~= "" then
		local highlighted_ab = set_hl(ahead_behind, "StatusLineNC", false)
		local padding = ahead_behind ~= "" and " " or ""
		result = highlighted_branch
			.. " "
			.. open_bracket()
			.. highlighted_ab
			.. padding
			.. git_diffs()
			.. close_bracket()
	end

	local git_icon = set_hl(config.signs.branch, "MoreMsg")
	return git_icon .. result
end

---[COMPONENT]
---Get current mode
---@return string mode
_G.statusline.components.mode = function()
	local bt = vim.bo.buftype
	if is_special_buf() and bt ~= "acwrite" then return "" end
	local mode = vim.api.nvim_get_mode().mode
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO"
		or modes[mode]
	local hl = vim.bo.mod and "Exception" or "Function"
	return set_hl(string.format("%s", mode_str), hl)
end

---[COMPONENT]
---Get diagnostics for current buffer with padding and brackets added
---@return string lsp_diagnostic
_G.statusline.components.lsp_diagnostic = function()
	if is_special_buf() then return "" end

	local status = vim.diagnostic.status()
	if status == "" then return "" end

	return open_bracket() .. status .. close_bracket()
end

---[COMPONENT]
---Get cwd of current buffer nicely formatted
---@return string cwd
_G.statusline.components.cwd = function()
	return vim.fn.pathshorten(vim.fn.getcwd(), 1)
end

---[COMPONENT]
---Get file path with root
---@return string filepath
_G.statusline.components.filepath = function()
	local ft = vim.bo.filetype
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	local prefix = set_hl(config.signs.file .. " ", "MoreMsg")

	-- show filepath for oil first
	if vim.tbl_contains({ "oil", "fyler_finder" }, ft) then
		return prefix
			.. set_hl(string.format("%s ", string.sub(fpath, 7)), "StatusLineNC")
	end

	if is_special_buf() then return "" end

	local root = set_hl(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), "SpecialComment")
	local secondary = ""

	if fpath ~= "." then secondary = string.format("/%s", fpath) end
	secondary = set_hl(secondary, "MoreMsg")

	return prefix .. root .. secondary
end

---[COMPONENT]
---Get filename
---@return string filename
_G.statusline.components.filename = function()
	if is_special_buf() and vim.bo.buftype ~= "help" then return "" end

	return set_hl(vim.fn.expand("%:t"), "SpecialComment")
end

---[COMPONENT]
---Get filetype, used to display for special bufers
---@return string filetype
_G.statusline.components.filetype = function()
	local ft = vim.bo.filetype
	local bt = vim.bo.buftype

	local s = ""
	local padding = ""
	if bt == "acwrite" then
		padding = " " .. set_hl(config.signs.delimiter, "MoreMsg") .. " "
	end

	-- priority important here
	if is_special_buf() and not vim.tbl_contains({ "fzf" }, ft) then
		s = ft
	else
		return ""
	end

	-- fallback to buftype
	if s == "" and vim.tbl_contains(simple_buftypes, bt) then s = bt end

	-- finally fallback to filetype again
	if s == "" then s = ft end

	local icon, highlight, is_default = require("mini.icons").get("filetype", ft)
	if is_default then
		icon = ""
	else
		icon = set_hl(icon, highlight) .. " "
	end

	if _G.helpers.is_big_file(vim.fn.expand("%")) then s = "BIG " end
	return padding .. icon .. set_hl(s, "Function") .. " "
end

---[COMPONENT]
---Get file icon
---@return string fileicon
_G.statusline.components.fileicon = function()
	if is_special_buf() then return "" end
	local icon, highlight, _ =
		require("mini.icons").get("file", vim.fn.expand("%:p"))
	return set_hl(icon, highlight)
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
			or sinfo.total > 0 and set_hl(sinfo.current, "StatuslineNC") .. set_hl(
				"/",
				"MoreMsg"
			) .. set_hl(sinfo.total, "StatusLineNC")
			or ""

		if search_stat ~= "" then
			return open_bracket() .. search_stat .. close_bracket()
		end
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
		return set_hl(" ● REC [" .. recording_register .. "] ", "Error") .. " "
	end
end

---[COMPONENT]
---Get file format
---@return string fformat
_G.statusline.components.fformat = function()
	if is_special_buf() then return "" end

	local ff = vim.bo.fileformat
	if ff == "unix" or ff == "" then return "" end
	return open_bracket() .. set_hl(ff, "StatusLineNC") .. close_bracket()
end

---[COMPONENT]
---Get file encoding
---@return string ffenc
_G.statusline.components.ffenc = function()
	if is_special_buf() then return "" end

	local fe = vim.bo.fileencoding
	if fe == "utf-8" or fe == "" then return "" end
	return open_bracket() .. set_hl(fe, "StatusLineNC") .. close_bracket()
end

---A number helper or something idk
---@param num string
---@param sep string
---@return string number
local group_number = function(num, sep)
	if num < 999 then
		return tostring(num)
	else
		num = tostring(num)
		return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
	end
end

---[COMPONENT]
---Get line count
---@return string linecount
local get_vlinecount = function()
	if is_special_buf() then return "" end

	local raw_count = vim.fn.line(".") - vim.fn.line("v")
	raw_count = raw_count < 0 and raw_count - 1 or raw_count + 1

	return group_number(math.abs(raw_count), ",")
end

---[COMPONENT]
---Get wordcount for current buffer or visual selection
---@return string wordcount
_G.statusline.components.filepos = function()
	if is_special_buf() then return "" end

	local lines = group_number(vim.api.nvim_buf_line_count(0), ",")
	local mode = vim.api.nvim_get_mode().mode

	if mode == "v" or mode == "V" then
		return set_hl(get_vlinecount(), "StatusLineNC")
			.. set_hl(" lines selected", "MoreMsg")
	else
		return set_hl("%l", "StatusLineNC")
			.. set_hl("/" .. lines .. " lines", "MoreMsg")
	end
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
		set_hl(":", "MoreMsg"),
		set_hl(shiftwidth_string, "StatusLineNC")
	)
end

---[COMPONENT]
---Get a delimiter char
---@return string indentation
_G.statusline.components.delimiter = function()
	if is_special_buf() then return "" end

	return set_hl(config.signs.delimiter, "MoreMsg")
end

---All components properly formatted and rendered
local rendered_components = {
	-- LSP
	lsp_diagnostics = [[%{%v:lua.statusline.components.lsp_diagnostic()%}]],
	-- Git
	git = [[%{%v:lua.statusline.components.git()%}]],
	-- Misc
	align = [[%=]],
	truncate = [[%<]],
	percentage = [[%#StatusLineNC#%P]],
	padding = [[%{%v:lua.statusline.components.padding()%}]],
	delimiter = [[%{%v:lua.statusline.components.delimiter()%}]],
	-- General
	filepath = [[%{%v:lua.statusline.components.filepath()%}]],
	filename = [[%{%v:lua.statusline.components.filename()%}]],
	fileicon = [[%{%v:lua.statusline.components.fileicon()%}]],
	mode = [[%{%v:lua.statusline.components.mode()%}]],
	filepos = [[%{%v:lua.statusline.components.filepos()%}]],
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
		rendered_components.macro,
		rendered_components.mode,
		rendered_components.filetype, -- for simple files
		rendered_components.padding,
		rendered_components.delimiter,
		rendered_components.padding,
		rendered_components.filepath,
		rendered_components.padding,
		rendered_components.delimiter,
		rendered_components.padding,
		rendered_components.fileicon,
		rendered_components.padding,
		rendered_components.filename,
		rendered_components.padding,
		rendered_components.delimiter,
		rendered_components.padding,
		rendered_components.git,
		rendered_components.truncate,
		-- Messy middle bit
		rendered_components.align,
		rendered_components.search,
		rendered_components.fformat,
		rendered_components.fenc,
		rendered_components.lsp_diagnostics,
		rendered_components.padding,
		-- Right most
		rendered_components.align,
		--
		rendered_components.padding,
		rendered_components.indentation,
		rendered_components.padding,
		rendered_components.delimiter,
		--
		rendered_components.padding,
		rendered_components.filepos,
	}, "")
end

vim.o.statusline = "%!v:lua.statusline.get()"
