vim.opt.background = "light"
vim.g.colors_name = "ivory_extended"

local lush = require("lush")
local extended = lush.merge({
	require("ivory"),
	require("ivory_statusline"),
	require("ivory_telescope"),
	require("ivory_neogit"),
	require("ivory_mini_indentscope"),
	require("ivory_diffview"),
	require("ivory_gitsigns"),
	require("ivory_cmp"),
	require("ivory_aerial"),
	require("ivory_nvim_tree"),
	require("ivory_render_markdown"),
	require("ivory_visualwhitespace"),
	require("ivory_incline"),
})

---@diagnostic disable-next-line: unnecessary-if
if _G.config.features.lsp.enabled then
	extended = lush.merge({
		extended,
		require("ivory_mason"),
		require("ivory_null_ls"),
	})
end

---@diagnostic disable-next-line: unnecessary-if
if _G.config.features.dap.enabled then
	extended = lush.merge({
		extended,
		require("ivory_dap"),
		require("ivory_dap_ui"),
	})
end

return lush(extended)
