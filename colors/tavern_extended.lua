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
})

---@diagnostic disable-next-line: unnecessary-if
if _G.config.features.lsp.enabled then
	extended = lush.merge({
		extended,
		require("tavern_mason"),
		require("tavern_null_ls"),
	})
end

---@diagnostic disable-next-line: unnecessary-if
if _G.config.features.dap.enabled then
	extended = lush.merge({
		extended,
		require("tavern_dap"),
		require("tavern_dap_ui"),
	})
end

return lush(extended)
