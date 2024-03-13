return {
	name = "indentation",
	event = { "BufEnter" },
	user_event = { "VeryLazy" },
	timing = false,
	lazy = true,
	configs = {},
	padding = 0,
	colors = "StatuslineAlt",
	update = function()
		local indent_mode = "tab"
		if vim.o.expandtab then
			indent_mode = "shift"
		end
		return indent_mode .. ": " .. vim.o.shiftwidth .. " │"
	end,
}
