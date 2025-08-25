local conf = require("core.variables")

local lush = require("lush")
local extended = lush.merge({
	require("ivory"),
	require("ivory_statusline"),
	require("ivory_telescope"),
	require("ivory_whichkey"),
	require("ivory_neogit"),
	require("ivory_mini_indentscope"),
	require("ivory_diffview"),
	require("ivory_gitsigns"),
	require("ivory_cmp"),
	require("ivory_aerial"),
})

if conf.lsp_enabled then
	extended = lush.merge({
		extended,
		require("ivory_mason"),
		require("ivory_null_ls"),
	})
end

if conf.ui_features.incline then
	extended = lush.merge({
		extended,
		require("ivory_incline"),
	})
end

if conf.ui_features.starter then
	extended = lush.merge({
		extended,
		require("ivory_mini_starter"),
	})
end

if conf.ui_features.tabline then
	extended = lush.merge({
		extended,
		require("ivory_bufferline"),
		require("ivory_mini_tabline"),
	})
end

if conf.dap_enabled then
	extended = lush.merge({
		extended,
		require("ivory_dap"),
		require("ivory_dap_ui"),
	})
end

return lush(extended)
