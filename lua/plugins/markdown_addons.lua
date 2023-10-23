-- Plugins that add functionalities to markdown files
return {
	{
		-- Format tables in markdown files
		"godlygeek/tabular",
		lazy = true,
		cmd = { "Tabularize" }
	},
	{
		-- Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		lazy = true,
		ft = { "markdown" , "quarto"},
		config = function()
			require("section-wordcount").setup({
				highlight = "NonText",
				virt_text_pos = "eol",
			})
			require("section-wordcount").wordcounter({})
		end,
	},
}
