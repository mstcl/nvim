local conf = require("user_configs")

vim.opt.background = "light"
vim.g.colors_name = "dmg_extended"

vim.g.terminal_color_0 = "#c8beb7"
vim.g.terminal_color_1 = "#630e49"
vim.g.terminal_color_2 = "#74351e"
vim.g.terminal_color_3 = "#184e1e"
vim.g.terminal_color_4 = "#26126d"
vim.g.terminal_color_5 = "#793454"
vim.g.terminal_color_6 = "#5e2b66"
vim.g.terminal_color_7 = "#161e29"
vim.g.terminal_color_8 = "#bdb1a8"
vim.g.terminal_color_9 = "#752c5f"
vim.g.terminal_color_10 = "#813b21"
vim.g.terminal_color_11 = "#24752d"
vim.g.terminal_color_12 = "#483d8b"
vim.g.terminal_color_13 = "#72347c"
vim.g.terminal_color_14 = "#8e3d63"
vim.g.terminal_color_15 = "#2c2621"

package.loaded["dmg"] = nil

local lush = require("lush")
local extended = lush.merge({
	require("dmg"),
	require("dmg_statusline"),
	require("dmg_mini_starter"),
	require("dmg_telescope"),
	require("dmg_ufo"),
	require("dmg_whichkey"),
	require("dmg_neogit"),
	require("dmg_incline"),
})

if conf.lsp_enabled then
	extended = lush.merge({
		extended,
		require("dmg_mason"),
		require("dmg_dressing"),
		require("dmg_null_ls"),
		require("dmg_navic"),
	})
end

if conf.edit_features.completion then
	extended = lush.merge({
		extended,
		require("dmg_cmp"),
	})
end


if conf.edit_features.flash then
	extended = lush.merge({
		extended,
		require("dmg_flash"),
	})
end

if conf.edit_features.biscuits then
	extended = lush.merge({
		extended,
		require("dmg_biscuits"),
	})
end

if conf.ui_features.modes then
	extended = lush.merge({
		extended,
		require("dmg_modes"),
	})
end

if conf.ui_features.tabline then
	extended = lush.merge({
		extended,
		require("dmg_bufferline"),
	})
end

if conf.ui_features.cursorword then
	extended = lush.merge({
		extended,
		require("dmg_mini_cursorword"),
	})
end

if conf.ui_features.indent_lines then
	extended = lush.merge({
		extended,
		require("dmg_hlchunk"),
	})
end

if conf.syntax_features.hlargs then
	extended = lush.merge({
		extended,
		require("dmg_hlargs"),
	})
end

if conf.syntax_features.rainbow then
	extended = lush.merge({
		extended,
		require("dmg_rainbow"),
	})
end

if conf.dap_enabled then
	extended = lush.merge({
		extended,
		require("dmg_dap"),
		require("dmg_dap_ui"),
	})
end

lush(extended)
