-- Plugins which add additional ways to use nvim
return {
	{
		-- Terminal panel
		"numToStr/FTerm.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {
			border = "single",
			blend = 0,
			dimensions = {
				height = 0.3,
				width = 0.8,
				x = 0.5,
				y = 0.9,
			},
		},
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
		opts = {},
	},
	{
		-- Utility to align text by delimiters
		"echasnovski/mini.align",
		event = "VeryLazy",
		version = false,
		lazy = true,
		opts = {},
	},
	{
		-- View git diff
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
		},
		opts = {},
	},
}
