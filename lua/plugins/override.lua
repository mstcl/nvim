-- Additional addons go here
return {
	{
		"elanmed/fzf-lua-frecency.nvim",
		lazy = false,
		keys = {
			{
				"<leader>h",
				"<cmd>FzfLua frecency<cr>",
				desc = "Browse history",
			},
			{
				"<leader>f",
				"<cmd>FzfLua frecency cwd_only=true<cr>",
				desc = "Find files",
			},
		},
		opts = {
			display_score = false,
		},
	},
}
