vim.opt.background = "light"
vim.g.colors_name = "ivory_extended"

local lush = require("lush")
local extended = lush.merge({
	require("ivory"),
	require("ivory_statusline"),
	require("ivory_telescope"),
	require("ivory_neogit"),
	require("ivory_mini_indentscope"),
	require("ivory_mini_clue"),
	require("ivory_diffview"),
	require("ivory_gitsigns"),
	require("ivory_cmp"),
	require("ivory_aerial"),
	require("ivory_nvim_tree"),
	require("ivory_render_markdown"),
	require("ivory_visualwhitespace"),
	require("ivory_incline"),
	require("ivory_mason"),
	require("ivory_null_ls"),
})

return lush(extended)
