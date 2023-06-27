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
		-- Preview markdown in browser
		"iamcco/markdown-preview.nvim",
		lazy = true,
		cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("configs.mdpreview")
		end,
	},
	{
		-- Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		lazy = true,
		ft = { "markdown" },
		opts = {
			highlight = "NonText",
			virt_text_pos = "eol",
		}
	},
}
