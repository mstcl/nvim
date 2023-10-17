-- Plugins to extend syntax, either natively or with treesitter
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			require("configs.syntax.treesitter")
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, event = "VeryLazy" },
			{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, event = "VeryLazy" },
			{ "filNaj/tree-setter",                          lazy = true, event = "VeryLazy" },
			{
				"nvim-treesitter/playground",
				cmd = "TSPlaygroundToggle",
			},
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
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		lazy = true,
		event = { "BufReadPre", "BufEnter *.org", "BufWinEnter *.org" },
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
		event = "VeryLazy",
		opts = {
			indent = true,
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
	{
		-- QUARTO setup
		"quarto-dev/quarto-nvim",
		dev = false,
		lazy = true,
		ft = "quarto",
		opts = {
			lspFeatures = {
				languages = { "python", "bash", "html" },
			},
			keymap = {
				hover = "K",
				definition = "<leader>qd",
				type_definition = "<leader>qD",
				rename = "<leader>r",
				format = "<leader><space>",
			},
		},
	},
}
