-- Plugins which add additional ways to use nvim
return {
	{
		-- Terminal panel
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			autochdir = false,
			shade_terminals = false,
			shading_factor = "2",
			highlights = {
				Normal = {
					link = "Floaterm",
				},
			},
			direction = "vertical",
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
	-- {
	-- 	-- Editing in term like one does in a buffer
	-- 	"chomosuke/term-edit.nvim",
	-- 	lazy = true,
	-- 	ft = "toggleterm",
	-- 	version = "1.*",
	-- 	opts = {
	-- 		prompt_end = " %$ ",
	-- 	},
	-- },
}
