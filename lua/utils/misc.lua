local M = {}

function M.has_any_words_before()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.press(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

M.buffer_opts = {
	get_bufnrs = function()
		local bufs = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			bufs[vim.api.nvim_win_get_buf(win)] = true
		end
		return vim.tbl_keys(bufs)
	end,
}

M.telescope_flex_layout = {
	horizontal = {
		prompt_position = "top",
		preview_width = 0.55,
	},
	vertical = {
		prompt_position = "top",
		mirror = false,
	},
	cursor = { prompt_position = "top" },
	center = { prompt_position = "top" },
	bottom_pane = { prompt_position = "top" },
	width = 0.87,
	height = 0.80,
	flip_lines = 55,
	flip_columns = 150,
}

M.telescope_picker_configs = {
	layout_strategy = "flex",
	layout_config = M.telescope_flex_layout,
	disable_devicons = true,
}

M.barbecue_theme = {
	["bg"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("WinBar", true).background)),
	["mg"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Whitespace", true).foreground)),
	["fg"] = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Operator", true).foreground)),
}

local vi_mode_colors = {
	normal = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("TelescopeSelection", true).foreground)),
	insert = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Statement", true).foreground)),
	visual = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Constant", true).foreground)),
	cmd = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Identifier", true).foreground)),
	replace = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Exception", true).foreground)),
	term = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Warning", true).foreground)),
}
function M.statusline_vi_mode()
	local alias = {
		n = "NVM",
		i = "INS",
		c = "CMD",
		V = "VIS",
		[""] = "VIS",
		v = "VIS",
		["r?"] = ":CONFIRM",
		rm = "--MORE",
		R = "REP",
		Rv = "VIR",
		s = "SEL",
		S = "SEL",
		r = "HIT-ENTER",
		[""] = "SEL",
		t = "TERM",
		["!"] = "SHELL",
	}
	local mode_color = {
		n = vi_mode_colors.normal,
		i = vi_mode_colors.insert,
		c = vi_mode_colors.cmd,
		V = vi_mode_colors.visual,
		[""] = vi_mode_colors.visual,
		v = vi_mode_colors.visual,
		["r?"] = vi_mode_colors.visual,
		rm = vi_mode_colors.visual,
		R = vi_mode_colors.replace,
		Rv = vi_mode_colors.replace,
		s = vi_mode_colors.replace,
		S = vi_mode_colors.replace,
		r = vi_mode_colors.replace,
		[""] = vi_mode_colors.replace,
		t = vi_mode_colors.term,
		["!"] = vi_mode_colors.replace,
		ic = vi_mode_colors.insert,
		cv = vi_mode_colors.replace,
		ce = vi_mode_colors.replace,
	}
	local vim_mode = vim.fn.mode()
	vim.api.nvim_command("hi GalaxyViMode gui=bold guifg=#f5f5f5 guibg=" .. mode_color[vim.fn.mode()])
	return "  " .. alias[vim_mode] .. " "
end

return M
