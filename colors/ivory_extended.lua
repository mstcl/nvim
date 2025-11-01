vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.o.termguicolors = true
vim.o.background = "light"
vim.g.colors_name = "ivory_extended"

local lush = require("lush")
local extended = lush.merge({
	require("ivory"),
	require("ivory.statusline"),
	require("ivory.telescope"),
	require("ivory.neogit"),
	require("ivory.mini_indentscope"),
	require("ivory.mini_clue"),
	require("ivory.diffview"),
	require("ivory.gitsigns"),
	require("ivory.cmp"),
	require("ivory.aerial"),
	require("ivory.nvim_tree"),
	require("ivory.render_markdown"),
	require("ivory.visualwhitespace"),
	require("ivory.incline"),
	require("ivory.mason"),
	require("ivory.null_ls"),
})

return lush(extended)
