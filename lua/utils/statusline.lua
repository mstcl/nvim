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
	["n"] = "NO",
	["no"] = "OP",
	["nov"] = "OC",
	["noV"] = "OL",
	["no\x16"] = "OB",
	["\x16"] = "VB",
	["niI"] = "IN",
	["niR"] = "RE",
	["niV"] = "RV",
	["nt"] = "NT",
	["ntT"] = "TM",
	["v"] = "VI",
	["vs"] = "VI",
	["V"] = "VL",
	["Vs"] = "VL",
	["\x16s"] = "VB",
	["s"] = "SE",
	["S"] = "SL",
	["\x13"] = "SB",
	["i"] = "IN",
	["ic"] = "IC",
	["ix"] = "IX",
	["R"] = "RE",
	["Rc"] = "RC",
	["Rx"] = "RX",
	["Rv"] = "RV",
	["Rvc"] = "RC",
	["Rvx"] = "RX",
	["c"] = "CO",
	["cv"] = "CV",
	["r"] = "PR",
	["rm"] = "PM",
	["r?"] = "P?",
	["!"] = "SH",
	["t"] = "TE",
}

---Get current mode
---@return string
function M.get_mode()
	local hl = vim.bo.mod and "TelescopeTitle" or "InclineNormal"
	local mode = vim.fn.mode()
	local mode_str = (mode == "n" and (vim.bo.ro or not vim.bo.ma)) and "RO" or modes[mode]
	return set_hl(string.format(" %s ", mode_str), hl) .. " "
end

function M.get_lsp_progress()
	return require("lsp-progress").progress({
		format = function(client_messages)
			if #client_messages > 0 then
				return table.concat(client_messages, " ")
			end
			if #vim.lsp.get_active_clients() > 0 then
				return ""
			end
			return ""
		end,
	})
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
	return " " .. vim.fn.pathshorten(vim.fn.getcwd(), 1)
end

---Get current git branch
---@return string
function M.get_git_branch()
	---@diagnostic disable-next-line: undefined-field
	local branch = "nil"
	if vim.b.gitsigns_status_dict ~= nil then
		branch = vim.b.gitsigns_status_dict.head
	end
	return set_hl("#", "StatuslineAlt") .. set_hl(branch, "StatusLineNC") .. " "
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

return M
