-- Plugins that add functionalities to markdown files
return {
	{
		-- Format tables in markdown files
		"godlygeek/tabular",
		cond = require("user_configs").syntax_features.markdown,
		cmd = { "Tabularize" }
	},
	{
		-- Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		ft = { "markdown" , "quarto"},
		cond = require("user_configs").syntax_features.markdown,
		opts = {
			highlight = "NonText",
			virt_text_pos = "eol",
		},
		config = function(_, opts)
			if opts then
				require("section-wordcount").setup(opts)
			end
			require("section-wordcount").wordcounter({})
		end,
	},
}
