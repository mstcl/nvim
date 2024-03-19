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
				["n"] = { "N", "STTUSLINE_NORMAL_MODE" },
				["no"] = { "N-o", "STTUSLINE_NORMAL_MODE" },
				["nov"] = { "N-ov", "STTUSLINE_NORMAL_MODE" },
				["noV"] = { "N-oV", "STTUSLINE_NORMAL_MODE" },
				["noCTRL-V"] = { "N", "STTUSLINE_NORMAL_MODE" },
				["niI"] = { "N-iI", "STTUSLINE_NORMAL_MODE" },
				["niR"] = { "N-iR", "STTUSLINE_NORMAL_MODE" },
				["niV"] = { "N-iV", "STTUSLINE_NORMAL_MODE" },

				["nt"] = { "T", "STTUSLINE_NTERMINAL_MODE" },
				["ntT"] = { "T-T", "STTUSLINE_NTERMINAL_MODE" },

				["v"] = { "V", "STTUSLINE_VISUAL_MODE" },
				["CTRL-V"] = { "V-B", "STTUSLINE_VISUAL_MODE" },
				["vs"] = { "V-S", "STTUSLINE_VISUAL_MODE" },
				["V"] = { "V-LN", "STTUSLINE_VISUAL_MODE" },
				["Vs"] = { "V-LN", "STTUSLINE_VISUAL_MODE" },

				["i"] = { "I", "STTUSLINE_INSERT_MODE" },
				["ic"] = { "I-C", "STTUSLINE_INSERT_MODE" },
				["ix"] = { "I-C", "STTUSLINE_INSERT_MODE" },

				["t"] = { "T", "STTUSLINE_TERMINAL_MODE" },
				["!"] = { "SH", "STTUSLINE_TERMINAL_MODE" },

				["R"] = { "R", "STTUSLINE_REPLACE_MODE" },
				["Rc"] = { "R-c", "STTUSLINE_REPLACE_MODE" },
				["Rx"] = { "R-x", "STTUSLINE_REPLACE_MODE" },
				["Rv"] = { "V-RP", "STTUSLINE_REPLACE_MODE" },
				["Rvc"] = { "V-RPc", "STTUSLINE_REPLACE_MODE" },
				["Rvx"] = { "V-RPx", "STTUSLINE_REPLACE_MODE" },

				["s"] = { "SLC", "STTUSLINE_SELECT_MODE" },
				["S"] = { "S-LN", "STTUSLINE_SELECT_MODE" },

				["c"] = { "C", "STTUSLINE_COMMAND_MODE" },
				["cv"] = { "C", "STTUSLINE_COMMAND_MODE" },
				["ce"] = { "C", "STTUSLINE_COMMAND_MODE" },

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
