local conf = require("core.variables")

local lush = require("lush")
local extended = lush.merge({
	require("dmg"),
	require("dmg_statusline"),
	require("dmg_dressing"),
	require("dmg_mini_starter"),
	require("dmg_telescope"),
	require("dmg_whichkey"),
	require("dmg_neogit"),
	require("dmg_incline"),
	require("dmg_cmp"),
	require("dmg_flash"),
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

if conf.ui_features.tabline then
	extended = lush.merge({
		extended,
		require("dmg_bufferline"),
	})
end

if conf.dap_enabled then
	extended = lush.merge({
		extended,
		require("dmg_dap"),
		require("dmg_dap_ui"),
	})
end

return lush(extended)
