return {
	{
		"KeitaNakamura/tex-conceal.vim",
		lazy = true,
		ft = { "tex" },
	},
	{
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
		"kovetskiy/sxhkd-vim",
		lazy = true,
		ft = "sxhkd",
	},
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup({
				org_agenda_files = { "~/sftpgo/orgzly/Main.org", "~/sftpgo/shared/orgzly/*" },
				win_split_mode = "float",
			})
			require("orgmode").setup_ts_grammar()
		end,
	},
}
