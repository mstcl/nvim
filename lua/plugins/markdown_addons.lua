-- Plugins that add functionalities to markdown files
return {
	{
		-- Format tables in markdown files
		"godlygeek/tabular",
		lazy = true,
		dependencies = { "vim-markdown" },
		cmd = { "Tabularize" }
	},
	{
		-- Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		lazy = true,
		ft = { "markdown" },
		config = function()
			require("section-wordcount").setup({
				highlight = "NonText",
				virt_text_pos = "eol",
			})
			require("section-wordcount").wordcounter({})
		end,
	},
	{
		-- Add background to some blocks
		"lukas-reineke/headlines.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			markdown = {
				headline_highlights = {},
				fat_headlines = false,
			},
			org = {
				fat_headlines = true,
				codeblock_highlight = "CodeBlock",
				dash_highlight = "Dash",
				dash_string = "-",
				quote_highlight = "Quote",
			},
		},
	},
	{
		-- Add TOC
		"mzlogin/vim-markdown-toc",
		lazy = true,
		ft = { "markdown" },
	},
}
