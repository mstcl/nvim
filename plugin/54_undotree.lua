-- Enable and customise the builtinundotree

vim.cmd("packadd nvim.undotree")

-- When opening undo tree set it to minimal mode
_G.helpers.new_autocmd("undotree", {
	{ "Filetype" },
	{
		desc = "open help in vertical split",
		pattern = "nvim-undotree",
		callback = function() vim.cmd("Mode minimal") end,
	},
})
