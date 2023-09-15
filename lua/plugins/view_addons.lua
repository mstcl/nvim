-- Plugins which add additional ways to use nvim
return {
	{
		-- Terminal panel
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("configs.view.toggleterm")
		end,
	},
	{
		-- Distraction-free editing mode
		"folke/zen-mode.nvim",
		lazy = true,
		dependencies = { "twilight.nvim" },
		cmd = "ZenMode",
		config = function()
			require("configs.view.zen")
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
	{
		-- Buffer-like file browser
		"stevearc/oil.nvim",
		config = function()
			require("configs.view.oil")
		end,
	},
	{
		-- Keymapping cheatsheet
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			icons = {
				breadcrumb = "▸",
				separator = "⟫",
			},
		},
	},
	{
		-- Minimalist start screen
		"echasnovski/mini.starter",
		lazy = true,
		event = "VimEnter",
		priority = 100,
		version = false,
		config = function()
			require("configs.view.starter")
		end,
	},
	{
		-- Multipurpose panel, mainly for navigation
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		config = function()
			require("configs.view.telescope")
		end,
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"tsakirist/telescope-lazy.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"jvgrootveld/telescope-zoxide",
			{
				"rudism/telescope-dict.nvim",
				ft = { "markdown", "tex" },
			},
			{
				"nvim-telescope/telescope-frecency.nvim",
			},
		},
	},
}
