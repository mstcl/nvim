-- Plugins to extend syntax, either natively or with treesitter
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = { "BufWinEnter" },
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
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
			require("configs.delimiters")
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
		"hhn-pham/vim-markdown",
		lazy = true,
		branch = "main",
		ft = { "markdown" },
		init = function()
			require("configs.markdown")
		end,
		wants = "tabular",
	},
	{
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("orgmode").setup({
				org_agenda_files = { "~/sftpgo/orgzly/*", "~/sftpgo/shared/orgzly/*" },
				win_split_mode = "float",
				org_hide_emphasis_markers = true,
			})
			require("orgmode").setup_ts_grammar()
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
				headlines = { "❄", "○", "✮", "✖" },
				checkboxes = {
					half = { "☀", "OrgTSCheckboxHalfChecked" },
					done = { "✓", "OrgDone" },
					todo = { "✗", "OrgTODO" },
				},
			},
		},
	},
}
