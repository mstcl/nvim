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
	require("ivory_nvim_tree"),
})

---@diagnostic disable-next-line: unnecessary-if
if conf.lsp_enabled then
	extended = lush.merge({
		extended,
		require("ivory_mason"),
		require("ivory_null_ls"),
	})
end

---@diagnostic disable-next-line: unnecessary-if
if conf.dap_enabled then
	extended = lush.merge({
		extended,
		require("ivory_dap"),
		require("ivory_dap_ui"),
	})
end

return lush(extended)
