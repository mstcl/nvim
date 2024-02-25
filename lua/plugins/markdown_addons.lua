-- Plugins that add functionalities to markdown files
return {
	{
		-- Format tables in markdown files
		"godlygeek/tabular",
		lazy = true,
		cond = require("user_configs").syntax_features.markdown,
		cmd = { "Tabularize" }
	},
	{
		-- Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		lazy = true,
		ft = { "markdown" , "quarto"},
		cond = require("user_configs").syntax_features.markdown,
		config = function()
			require("section-wordcount").setup({
				highlight = "NonText",
				virt_text_pos = "eol",
			})
			require("section-wordcount").wordcounter({})
		end,
	},
}
