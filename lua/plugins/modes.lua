-- Plugins which add additional ways to use nvim
return {
	{
		-- Terminal panel
		"numToStr/FTerm.nvim",
		lazy = true,
		config = function()
			require("configs.fterm")
		end,
	},
	{
		-- Distraction-free editing mode
		"folke/zen-mode.nvim",
		lazy = true,
		dependencies = { "twilight.nvim" },
		cmd = "ZenMode",
		config = function()
			require("configs.zen")
		end,
	},
	{
		-- Dim all but current paragraph object
		"folke/twilight.nvim",
		lazy = true,
		cmd = "Twilight",
		config = function()
			require("twilight").setup()
		end,
	},
	{
		-- Utility to align text by delimiters
		"echasnovski/mini.align",
		version = false,
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("mini.align").setup()
		end,
	},
}
