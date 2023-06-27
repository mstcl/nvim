-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Syntax aware comments & keybindings
		"numToStr/Comment.nvim",
		lazy = true,
		event = "CursorMoved",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("configs.escape")
		end,
	},
	{
		-- Plug and play automatically insert autopairs
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		-- Add motions to surround objects with brackets etc.
		"ur4ltz/surround.nvim",
		lazy = true,
		keys = {
			{ "s", mode = { "n", "v" } },
			{ "c", mode = { "n", "v" } },
			{ "d", mode = { "n", "v" } },
		},
		config = function()
			require("surround").setup({
				mappings_style = "surround",
				space_on_alias = false,
				space_on_closing_char = false,
			})
		end,
	},
	{
		-- Keybindings to move lines and blocks
		"fedepujol/move.nvim",
		lazy = true,
		event = "CursorMoved",
	},
}
