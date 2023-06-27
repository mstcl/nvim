-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Syntax aware comments & keybindings
		"numToStr/Comment.nvim",
		lazy = true,
		event = "CursorMoved",
		opts = {},
	},
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		lazy = true,
		event = "InsertEnter",
		opts = {
			mapping = { "jk" },
			timeout = vim.o.timeoutlen,
			clear_empty_lines = false,
			keys = "<Esc>",
		},
	},
	{
		-- Plug and play automatically insert autopairs
		"windwp/nvim-autopairs",
		opts = {},
	},
	{
		-- Add motions to surround objects with brackets etc.
		"kylechui/nvim-surround",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		-- Keybindings to move lines and blocks
		"fedepujol/move.nvim",
		lazy = true,
		event = "VeryLazy",
	},
	{
		-- Jump around the buffer
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			prompt = {
				prefix = { { "", "FlashPromptIcon" } },
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
	},
	{
		-- Tab out of parentheses
		"abecodes/tabout.nvim",
		event = "VeryLazy",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
			"sirver/ultisnips",
		},
		opts = {
			tabkey = "<Tab>",
			backwards_tabkey = "<S-Tab>",
			act_as_tab = true,
			act_as_shift_tab = true,
			default_tab = "<C-t>",
			default_shift_tab = "<C-d>",
			enable_backwards = true,
			completion = true,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
			},
			ignore_beginning = true,
			exclude = {},
		},
	},
	{
		-- Enforce good vim habits
		"mm4xshen/hardtime.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			disable_mouse = false,
			disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "alpha" },
			disabled_keys = {},
		},
	},
}
