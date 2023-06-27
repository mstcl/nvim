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
			"HiPhish/nvim-ts-rainbow2",
			{
				"nvim-treesitter/playground",
				cmd = "TSPlaygroundToggle",
			},
			"JoosepAlviste/nvim-ts-context-commentstring",
			{
				"m-demare/hlargs.nvim",
				config = function()
					require("hlargs").setup({ color = "#a77212" })
				end,
			},
		},
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
		-- SXHKD syntax
		"kovetskiy/sxhkd-vim",
		lazy = true,
		ft = "sxhkd",
	},
	{
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup({
				org_agenda_files = { "~/sftpgo/orgzly/Main.org", "~/sftpgo/shared/orgzly/*" },
				win_split_mode = "float",
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
}
