vim.opt.background = "dark"
vim.g.colors_name = "tavern_extended"

local lush = require("lush")
local extended = lush.merge({
	require("tavern"),
	require("tavern_statusline"),
	require("tavern_telescope"),
	require("tavern_neogit"),
	require("tavern_mini_indentscope"),
	require("tavern_diffview"),
	require("tavern_gitsigns"),
	require("tavern_cmp"),
	require("tavern_aerial"),
	require("tavern_nvim_tree"),
	require("tavern_render_markdown"),
	require("tavern_visualwhitespace"),
	require("tavern_incline"),
	require("tavern_mason"),
	require("tavern_null_ls"),
})

return lush(extended)
