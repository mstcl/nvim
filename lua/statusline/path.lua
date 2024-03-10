return {
	name = "patph",
	event = { "BufEnter" },
	user_event = {},
	timing = true,
	lazy = false,
	configs = {},
	padding = 1,
	colors = "StatuslineAlt",
	update = function()
		return vim.fn.pathshorten(vim.fn.expand("%:h"), 3)
	end,
}
