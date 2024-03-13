return {
	name = "fileformat",
	event = { "BufEnter" },
	user_event = { "VeryLazy" },
	timing = false,
	lazy = true,
	configs = {},
	padding = 1,
	colors = "StatuslineAlt",
	update = function()
		return vim.o.fileformat .. " │"
	end,
}
