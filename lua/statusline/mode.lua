local vi_mode_colors = {
	normal = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Normal", true).foreground)),
	insert = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Statement", true).foreground)),
	visual = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Constant", true).foreground)),
	cmd = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Identifier", true).foreground)),
	replace = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Exception", true).foreground)),
	term = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Warning", true).foreground)),
	fg = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Statusline", true).background)),
}

return {
	"mode",
	{
		configs = {
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
		},
		padding = 1,
	},
}
