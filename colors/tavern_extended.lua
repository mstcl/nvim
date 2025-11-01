vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "tavern_extended"

package.loaded["tavern"] = nil

local lush = require("lush")
local extended = lush.merge({
	require("tavern"),
	require("tavern.statusline"),
	require("tavern.telescope"),
	require("tavern.neogit"),
	require("tavern.mini_indentscope"),
	require("tavern.mini_clue"),
	require("tavern.diffview"),
	require("tavern.gitsigns"),
	require("tavern.cmp"),
	require("tavern.aerial"),
	require("tavern.nvim_tree"),
	require("tavern.render_markdown"),
	require("tavern.visualwhitespace"),
	require("tavern.incline"),
	require("tavern.mason"),
	require("tavern.null_ls"),
})

return lush(extended)
