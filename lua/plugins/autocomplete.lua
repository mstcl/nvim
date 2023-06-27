return {
	{
		-- Fancy command wildmenu
		"gelguy/wilder.nvim",
		lazy = true,
		build = ":UpdateRemotePlugins",
		event = "CmdlineEnter",
		config = function()
			require("configs.wilder")
		end,
	},
	{
		-- Snippet engine
		"sirver/ultisnips",
		lazy = true,
		event = "InsertEnter",
		init = function()
			vim.g.UltiSnipsExpandTrigger = "<nop>"
			vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
			vim.g.UltiSnipsRemoveSelectModeMappings = 0
		end,
		config = function()
			vim.cmd('let g:UltiSnipsSnippetDirectories=["/home/lckdscl/.config/nvim/ultisnips"]')
		end,
	},
	{
		-- Autocompletion menu & plugins
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			require("configs.cmp")
		end,
	},
}
