return {
	name = "empty",
	event = { "BufEnter" },
	user_event = { "VeryLazy" },
	timing = false,
	lazy = true,
	configs = {},
	padding = 0,
	colors = "StatuslineAlt",
	update = function()
		return " "
	end,
}
