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
		opts = {
			highlight = "NonText",
			virt_text_pos = "eol",
		},
		config = function(_, opts)
			require("section-wordcount").setup(opts)
			require("section-wordcount").wordcounter({})
		end,
	},
}
