local noice_ok, noice = pcall(require, "noice")
if not noice_ok then
	return
end
local diag = vim.diagnostic
local vi_mode_colors = {
	normal = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("TelescopeSelection", true).foreground)),
	insert = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Statement", true).foreground)),
	visual = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Constant", true).foreground)),
	cmd = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Identifier", true).foreground)),
	replace = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Exception", true).foreground)),
	term = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Warning", true).foreground)),
	fg = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("GalaxyFg", true).background)),
	accent = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Keyword", true).foreground)),
	fg_alt = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("GalaxyFgAlt2", true).foreground)),
	bg_alt = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("GalaxyFgAlt2", true).background)),
}
local get_branch = function()
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir ~= "" then
		local head_file = io.open(git_dir .. "/HEAD", "r")
		if head_file then
			local content = head_file:read("*all")
			head_file:close()
			return content:match("ref: refs/heads/(.-)%s*$")
		end
		return ""
	end
	return ""
end
local utils = require("sttusline.utils")
local mode = require("sttusline.components.mode")
local pos_cursor = require("sttusline.components.pos-cursor")
local indentation = require("sttusline.component").new()
local fileformat = require("sttusline.component").new()
local git_branch = require("sttusline.component").new()
local git_diff = require("sttusline.component").new()
local empty = require("sttusline.component").new()
local lsps_formatters = require("sttusline.component"):new()
local filetype = require("sttusline.component"):new()
local cwd = require("sttusline.component"):new()
local path = require("sttusline.component"):new()
local macro = require("sttusline.component"):new()
local diagnostics = require("sttusline.component").new()
local diagnostics_color = {
	ERROR = "GalaxyOrange",
	WARN = "GalaxyYellow",
	HINT = "GalaxyRed",
	INFO = "GalaxyBlue",
}

mode.set_config({
	modes = {
		["n"] = { "NVM", "STTUSLINE_NORMAL_MODE" },
		["no"] = { "NVM (no)", "STTUSLINE_NORMAL_MODE" },
		["nov"] = { "NVM (nov)", "STTUSLINE_NORMAL_MODE" },
		["noV"] = { "NVM (noV)", "STTUSLINE_NORMAL_MODE" },
		["noCTRL-V"] = { "NVM", "STTUSLINE_NORMAL_MODE" },
		["niI"] = { "NVIM i", "STTUSLINE_NORMAL_MODE" },
		["niR"] = { "NVIM r", "STTUSLINE_NORMAL_MODE" },
		["niV"] = { "NVIM v", "STTUSLINE_NORMAL_MODE" },

		["nt"] = { "TRM", "STTUSLINE_NTERMINAL_MODE" },
		["ntT"] = { "TRM (ntT)", "STTUSLINE_NTERMINAL_MODE" },

		["v"] = { "VIS", "STTUSLINE_VISUAL_MODE" },
		["vs"] = { "V-CH (Ctrl O)", "STTUSLINE_VISUAL_MODE" },
		["V"] = { "V-LN", "STTUSLINE_VISUAL_MODE" },
		["Vs"] = { "V-LN", "STTUSLINE_VISUAL_MODE" },
		["�"] = { "V-BK", "STTUSLINE_VISUAL_MODE" },

		["i"] = { "INS", "STTUSLINE_INSERT_MODE" },
		["ic"] = { "INS (completion)", "STTUSLINE_INSERT_MODE" },
		["ix"] = { "INS completion", "STTUSLINE_INSERT_MODE" },

		["t"] = { "TRM", "STTUSLINE_TERMINAL_MODE" },
		["!"] = { "SHL", "STTUSLINE_TERMINAL_MODE" },

		["R"] = { "RPL", "STTUSLINE_REPLACE_MODE" },
		["Rc"] = { "RPL (Rc)", "STTUSLINE_REPLACE_MODE" },
		["Rx"] = { "RPL (Rx)", "STTUSLINE_REPLACE_MODE" },
		["Rv"] = { "V-RP", "STTUSLINE_REPLACE_MODE" },
		["Rvc"] = { "V-RP (Rvc)", "STTUSLINE_REPLACE_MODE" },
		["Rvx"] = { "V-RP (Rvx)", "STTUSLINE_REPLACE_MODE" },

		["s"] = { "SLC", "STTUSLINE_SELECT_MODE" },
		["S"] = { "S-LN", "STTUSLINE_SELECT_MODE" },
		["�"] = { "S-BK", "STTUSLINE_SELECT_MODE" },

		["c"] = { "CMD", "STTUSLINE_COMMAND_MODE" },
		["cv"] = { "CMD", "STTUSLINE_COMMAND_MODE" },
		["ce"] = { "CMD", "STTUSLINE_COMMAND_MODE" },

		["r"] = { "PRM", "STTUSLINE_CONFIRM_MODE" },
		["rm"] = { "MRE", "STTUSLINE_CONFIRM_MODE" },
		["r?"] = { "CNF", "STTUSLINE_CONFIRM_MODE" },
		["x"] = { "CNF", "STTUSLINE_CONFIRM_MODE" },
	},
	mode_colors = {
		["STTUSLINE_NORMAL_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.normal },
		["STTUSLINE_INSERT_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.insert },
		["STTUSLINE_VISUAL_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.visual },
		["STTUSLINE_NTERMINAL_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.term },
		["STTUSLINE_TERMINAL_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.term },
		["STTUSLINE_REPLACE_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.replace },
		["STTUSLINE_SELECT_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.cmd },
		["STTUSLINE_COMMAND_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.cmd },
		["STTUSLINE_CONFIRM_MODE"] = { fg = vi_mode_colors.fg, bg = vi_mode_colors.cmd },
	},
})
mode.set_padding(1)

macro.set_event({ "BufEnter" })
macro.set_user_event({})
macro.set_timing(true)
macro.set_lazy(false)
macro.set_config({})
macro.set_padding(0)
macro.set_colors({ fg = vi_mode_colors.term, bg = vi_mode_colors.bg_alt })
macro.set_condition(noice.api.statusline.mode.has)
macro.set_update(noice.api.statusline.mode.get)

filetype.set_event({ "BufEnter" })
filetype.set_user_event({ "VeryLazy" })
filetype.set_timing(false)
filetype.set_lazy(true)
filetype.set_config({})
filetype.set_padding({ left = 1 })
filetype.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
filetype.set_update(function()
	return vim.bo.filetype .. " │"
end)

cwd.set_event({ "BufEnter" })
cwd.set_user_event({})
cwd.set_timing(true)
cwd.set_lazy(false)
cwd.set_config({})
cwd.set_padding(0)
cwd.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
cwd.set_update(function()
	return vim.fn.pathshorten(vim.fn.getcwd(), 3) .. " │"
end)

path.set_event({ "BufEnter" })
path.set_user_event({})
path.set_timing(true)
path.set_lazy(false)
path.set_config({})
path.set_padding(1)
path.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
path.set_update(function()
	return vim.fn.pathshorten(vim.fn.expand("%:h"), 3)
end)

git_branch.set_event({ "BufEnter" })
git_branch.set_padding(0)
git_branch.set_user_event({ "VeryLazy", "GitSignsUpdate" })
git_branch.set_condition(function()
	return vim.api.nvim_buf_get_option(0, "buflisted")
end)
git_branch.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
git_branch.set_update(function()
	local branch = get_branch()
	local result = ""
	if branch == "" then
		result = "n/a "
	else
		result = branch .. " │"
	end
	return result
end)

empty.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
empty.set_event({ "BufEnter" })
empty.set_user_event({ "VeryLazy" })
empty.set_timing(false)
empty.set_lazy(true)
empty.set_padding(0)
empty.set_update(function()
	return " "
end)

lsps_formatters.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
lsps_formatters.set_event({ "LspAttach", "LspDetach", "BufWritePost", "BufEnter", "VimResized" })
lsps_formatters.set_user_event({})
lsps_formatters.set_condition(function()
	return vim.o.columns > 70
end)
lsps_formatters.set_padding(0)
lsps_formatters.set_update(function()
	local buf_clients = vim.lsp.buf_get_clients()
	if not buf_clients or #buf_clients == 0 then
		return ""
	end
	local server_names = {}
	for _, client in pairs(buf_clients) do
		local client_name = client.name
		if client_name ~= "null-ls" and client_name ~= "copilot" then
			table.insert(server_names, client_name)
		end
	end
	if package.loaded["null-ls"] then
		local has_null_ls, null_ls = pcall(require, "null-ls")
		if has_null_ls then
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local null_ls_methods = {
				null_ls.methods.DIAGNOSTICS,
				null_ls.methods.DIAGNOSTICS_ON_OPEN,
				null_ls.methods.DIAGNOSTICS_ON_SAVE,
				null_ls.methods.FORMATTING,
			}
			local get_null_ls_sources = function(methods, name_only)
				local sources = require("null-ls.sources")
				local available_sources = sources.get_available(buf_ft)
				methods = type(methods) == "table" and methods or { methods }
				if #methods == 0 then
					if name_only then
						return vim.tbl_map(function(source)
							return source.name
						end, available_sources)
					end
					return available_sources
				end
				local source_results = {}
				for _, source in ipairs(available_sources) do
					for _, method in ipairs(methods) do
						if source.methods[method] then
							if name_only then
								table.insert(source_results, source.name)
							else
								table.insert(source_results, source)
							end
							break
						end
					end
				end
				return source_results
			end
			local null_ls_builtins = get_null_ls_sources(null_ls_methods, true)
			vim.list_extend(server_names, null_ls_builtins)
		end
	end

	if package.loaded["conform"] then
		local has_conform, conform = pcall(require, "conform")
		if has_conform then
			vim.list_extend(
				server_names,
				vim.tbl_map(function(formatter)
					return formatter.name
				end, conform.list_formatters(0))
			)
		end
	end

	return "│ " .. table.concat(vim.fn.uniq(server_names), ", ") .. " │"
end)

pos_cursor.set_colors({ bg = vi_mode_colors.accent, fg = vi_mode_colors.fg })

fileformat.set_event({ "BufEnter" })
fileformat.set_user_event({ "VeryLazy" })
fileformat.set_timing(false)
fileformat.set_lazy(true)
fileformat.set_config({})
fileformat.set_padding(1)
fileformat.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
fileformat.set_update(function()
	return vim.o.fileformat .. " │"
end)

indentation.set_event({ "BufEnter" })
indentation.set_user_event({ "VeryLazy" })
indentation.set_timing(false)
indentation.set_lazy(true)
indentation.set_config({})
indentation.set_padding(0)
indentation.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
indentation.set_update(function()
	local indent_mode = "tab"
	if vim.o.expandtab then
		indent_mode = "shift"
	end
	return indent_mode .. ": " .. vim.o.shiftwidth .. " │"
end)

diagnostics.set_event({
	"DiagnosticChanged",
})
diagnostics.set_user_event({})
diagnostics.set_condition(function()
	local ft = vim.api.nvim_buf_get_option(0, "filetype")
	return ft ~= "lazy"
end)
diagnostics.set_padding(1)
diagnostics.set_update(function()
	local result = {}
	local icons = {
		ERROR = require("user_configs").lsp_signs["Error"],
		WARN = require("user_configs").lsp_signs["Warn"],
		INFO = require("user_configs").lsp_signs["Info"],
		HINT = require("user_configs").lsp_signs["Hint"],
	}
	local order = { "ERROR", "WARN", "INFO", "HINT" }

	for _, key in ipairs(order) do
		local count = #diag.get(0, { severity = diag.severity[key] })
		if count > 0 then
			local color = diagnostics_color[key]
			if color then
				if utils.is_color(color) or type(color) == "table" then
					table.insert(result, utils.add_highlight_name(icons[key] .. count, "STTUSLINE_DIAGNOSTICS_" .. key))
				else
					table.insert(result, utils.add_highlight_name(icons[key] .. count, color))
				end
			end
		end
	end

	return #result > 0 and table.concat(result, " ") or ""
end)

git_diff.set_event({ "BufWritePost", "VimResized", "BufEnter" })
git_diff.set_user_event({ "GitSignsUpdate" })
git_diff.set_padding(1)
git_diff.set_colors({ fg = vi_mode_colors.fg_alt, bg = vi_mode_colors.bg_alt })
git_diff.set_update(function()
	local git_status = vim.b.gitsigns_status_dict
	local order = { "added", "changed", "removed" }
	local result = {}
	local icons = {
		added = "+",
		changed = "~",
		removed = "-",
	}
	local diff_colors = {
		added = "GalaxyGreen",
		changed = "GalaxyMagenta",
		removed = "GalaxyRed",
	}
	if git_status == nil then
		return "n/a"
	elseif git_status["added"] == 0 and git_status["changed"] == 0 and git_status["removed"] == 0 then
		return "clean"
	else
		for _, v in ipairs(order) do
			if git_status[v] and git_status[v] > 0 then
				local color = diff_colors[v]

				if color then
					if utils.is_color(color) or type(color) == "table" then
						table.insert(
							result,
							utils.add_highlight_name(icons[v] .. git_status[v], "STTUSLINE_GIT_DIFF_" .. v)
						)
					else
						table.insert(result, utils.add_highlight_name(icons[v] .. git_status[v], color))
					end
				end
			end
		end
		return #result > 0 and table.concat(result, " ") or ""
	end
end)
git_diff.set_condition(function()
	return vim.o.columns > 70
end)

local M = {}

M.components = {
	mode,
	pos_cursor,
	empty,
	git_branch,
	git_diff,
	diagnostics,
	macro,
	"%=",
	fileformat,
	indentation,
	filetype,
	cwd,
	path,
}

return M
