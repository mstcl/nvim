vim.cmd("packadd nvim.undotree")
vim.keymap.set(
	"n",
	"<leader>u",
	function()
		require("undotree").open({
			command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
		})
	end,
	{ desc = "Undotree" }
)

_G.augroup("undotree", {
	{ "Filetype" },
	{
		desc = "open help in vertical split",
		pattern = "nvim-undotree",
		callback = function() vim.cmd("MinimalMode") end,
	},
})
