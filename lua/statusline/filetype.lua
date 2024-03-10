return {
	name = "filetype",
	event = { "BufEnter" },
	user_event = { "VeryLazy" },
	timing = false,
	lazy = true,
	configs = {},
	padding = { left = 1 },
	colors = "StatuslineAlt",
	update = function()
		return vim.bo.filetype .. " │"
	end,
}
