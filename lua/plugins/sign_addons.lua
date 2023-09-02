-- Plugins that add things to the signcolumn (or foldcolumn)
return {
	{
		-- Git status in signcolumn
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.sign.gitsigns")
		end,
	},
	{
		-- Marks in signcolumn
		"chentoast/marks.nvim",
		lazy = true,
		ft = "markdown",
		config = function()
			require("configs.sign.marks")
		end,
	},
	{
		-- Show signs for folded blocks
		"lewis6991/foldsigns.nvim",
		lazy = true,
		event = "BufRead",
		opts = {
			exclude = { "LspDiagnosticsSignWarning" },
		},
	},
	{
		-- Utility to hide numbers in foldcolumn
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				segments = {
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{ text = { "%s" },                  click = "v:lua.ScSa" },
					{
						text = { builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
				},
			})
		end,
	},
}