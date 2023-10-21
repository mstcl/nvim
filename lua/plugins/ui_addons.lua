-- Plugins that modify UI
return {
	{
		-- Colorscheme
		dir = "/hades/projects/dmg/",
		name = "dmg",
		lazy = false,
		priority = 1000,
		config = function()
			vim.api.nvim_command("colorscheme dmg")
		end,
	},
	{
		-- Statusline
		"nvimdev/galaxyline.nvim",
		lazy = true,
		event = { "VeryLazy" },
		branch = "main",
		config = function()
			require("configs.ui.statusline")
		end,
	},
	{
		-- Add a sidebar map
		"echasnovski/mini.map",
		lazy = true,
		event = "VeryLazy",
		version = false,
		config = function()
			require("configs.ui.map")
		end,
	},
	{
		-- Tabline and bufferline
		"romgrk/barbar.nvim",
		lazy = true,
		event = "VeryLazy",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		config = function()
			require("configs.ui.barbar")
		end,
	},
	{
		-- Add nice input dialogs to prompt
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("configs.ui.dressing")
		end,
	},
	{
		-- Revamped UI (notification etc.)
		"folke/noice.nvim",
		event = "VeryLazy",
		lazy = true,
		dependencies = {
			{ "MunifTanjim/nui.nvim", lazy = true, event = "VeryLazy" },
			{
				"rcarriga/nvim-notify",
				lazy = true,
				event = "VeryLazy",
			},
		},
		config = function()
			require("configs.ui.noice")
		end,
	},
	{
		-- Colorcolumn smart functionality
		"fmbarina/multicolumn.nvim",
		lazy = true,
		priority = 10,
		event = "VeryLazy",
		config = function()
			require("configs.ui.multicolumn")
		end,
	},
	{
		-- Show indent lines
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("configs.ui.hlchunk")
		end,
	},
	{
		-- Highlight color blocks
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		event = "VeryLazy",
		cmd = { "ColorizerToggle" },
		config = function()
			require("colorizer").setup()
			vim.cmd("ColorizerAttachToBuffer")
		end,
	},
	{
		-- Folding customization using LSP and more
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async", lazy = true, event = "VeryLazy" },
		config = function()
			require("configs.ui.ufo")
		end,
	},
	{
		-- Naively highlight word under cursor
		"echasnovski/mini.cursorword",
		-- "utsontungexpt/stcursorword",
		lazy = true,
		event = "VeryLazy",
		opts = {},
		version = false,
	},
}
