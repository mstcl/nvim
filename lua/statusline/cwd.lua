return {
	name = "cwd",
	event = { "BufEnter" },
	user_event = {},
	timing = true,
	lazy = false,
	configs = {},
	padding = 0,
	colors = "StatuslineAlt",
	update = function()
		return vim.fn.pathshorten(vim.fn.getcwd(), 3) .. " │"
	end,
}
