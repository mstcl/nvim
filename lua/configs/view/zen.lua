local present, zen = pcall(require, "zen-mode")
if not present then
	return
end

local twilight = require("twilight").setup({
	context = 5,
	exclude = {
		"markdown",
	},
})

zen.setup({
	window = {
		backdrop = 1,
		width = 90,
		options = {
			signcolumn = "yes",
			number = false,
			relativenumber = false,
			cursorline = false,
			cursorcolumn = false,
			foldcolumn = "0",
			list = false,
		},
	},
	plugins = {
		gitsigns = { enabled = true },
		kitty = {
			enabled = true,
			font = "+0",
		},
	},
})
