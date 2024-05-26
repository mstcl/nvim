local conf = require("core.variables")

vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.o.termguicolors = true
vim.o.background = "light"
vim.g.colors_name = "ivory_extended"

package.loaded["ivory"] = nil

local lush = require("lush")
local extended = lush.merge({
	require("ivory"),
	require("ivory_statusline"),
	require("ivory_dressing"),
	require("ivory_mini_starter"),
	require("ivory_telescope"),
	require("ivory_whichkey"),
	require("ivory_neogit"),
	require("ivory_incline"),
	require("ivory_cmp"),
	require("ivory_flash"),
})

if conf.lsp_enabled then
	extended = lush.merge({
		extended,
		require("ivory_mason"),
		require("ivory_dressing"),
		require("ivory_null_ls"),
		require("ivory_navic"),
	})
end

if conf.ui_features.tabline then
	extended = lush.merge({
		extended,
		require("ivory_bufferline"),
	})
end

if conf.dap_enabled then
	extended = lush.merge({
		extended,
		require("ivory_dap"),
		require("ivory_dap_ui"),
	})
end

lush(extended)
