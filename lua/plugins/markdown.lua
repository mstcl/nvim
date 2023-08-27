-- Plugins that add functionalities to markdown files
return {
	{
		-- Format tables in markdown files
		"godlygeek/tabular",
		lazy = true,
		dependencies = { "vim-markdown" },
		ft = { "markdown" },
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
		ft = { "markdown", "org" },
		dependences = "nvim-treesitter/nvim-treesitter",
		opts = {
			markdown = {
				headline_highlights = {},
				fat_headlines = false,
			},
			org = {
				headline_highlights = { "Headline", "Headline1", "Headline2" },
			},
		},
	},
}
