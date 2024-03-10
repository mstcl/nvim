local noice_ok, noice = pcall(require, "noice")
if not noice_ok then
	return
end

return {
	name = "macro",
	event = { "BufEnter" },
	user_event = { "VeryLazy" },
	timing = true,
	lazy = false,
	configs = {},
	padding = 0,
	colors = "StatuslineAlt",
	condition = noice.api.statusline.mode.has,
	update = noice.api.statusline.mode.get,
}
