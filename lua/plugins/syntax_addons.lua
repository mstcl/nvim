-- Plugins to extend syntax, either natively or with treesitter
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = { "BufWinEnter" },
		build = ":TSUpdate",
		config = function()
			require("configs.syntax.treesitter")
		end,
		dependencies = {
			"filNaj/tree-setter",
			{
				"nvim-treesitter/playground",
				cmd = "TSPlaygroundToggle",
			},
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		-- Highlight argument's definition and usage
		"m-demare/hlargs.nvim",
		lazy = true,
		event = { "BufWinEnter" },
		opts = {
			color = "#87591a",
			hl_priority = 200,
		},
	},
	{
		-- Highlight parenthesis
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = { "BufWinEnter" },
		config = function()
			require("configs.syntax.delimiters")
		end,
	},
	{
		-- Concealing in tex
		"KeitaNakamura/tex-conceal.vim",
		lazy = true,
		ft = { "tex" },
	},
	{
		-- Markdown syntax
		"mstcl/vim-markdown",
		lazy = true,
		branch = "main",
		ft = { "markdown" },
		init = function()
			require("configs.syntax.markdown")
		end,
	},
	{
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("configs.syntax.orgmode")
		end,
	},
	{
		-- Dokuwiki syntax
		"nblock/vim-dokuwiki",
		lazy = true,
		ft = "dokuwiki",
	},
	{
		-- Org bullet
		"akinsho/org-bullets.nvim",
		lazy = true,
		ft = "org",
		opts = {
			symbols = {
				list = "•",
				headlines = { "◎", "○", "●", "◌" },
				checkboxes = {
					half = { "♣", "OrgTSCheckboxHalfChecked" },
					done = { "✓", "OrgDone" },
					todo = { "✗", "OrgTODO" },
				},
			},
		},
	},
}
