return {
	"pos-cursor",
	{
		colors = {
			fg = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Statusline", true).background)),
			bg = "#" .. tostring(string.format("%06x", vim.api.nvim_get_hl_by_name("Keyword", true).foreground)),
		},
	},
}
