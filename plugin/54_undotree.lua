-- Enable and customise the builtinundotree

vim.cmd("packadd nvim.undotree")

local function undotree_open()
	require("undotree").open({
		command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
	})
end

-- When opening undo tree set it to minimal mode
_G.augroup("undotree", {
	{ "Filetype" },
	{
		desc = "open help in vertical split",
		pattern = "nvim-undotree",
		callback = function() vim.cmd("Mode minimal") end,
	},
})

vim.keymap.set("n", "<leader>u", undotree_open, { desc = "Undotree" })
_G.register_toggle("undotree", { "undo" }, undotree_open)
