-- Plugins that modify big UI
return {
	{
		-- Colorscheme
		dir = "/media3/projects/dmg/",
		name = "dmg",
		lazy = false,
		priority = 1000,
		config = function()
			vim.api.nvim_command("colorscheme dmg")
		end,
	},
	{
		-- Statusline
		"AkashKarnatak/galaxyline.nvim",
		lazy = true,
		event = "VeryLazy",
		branch = "main",
		config = function()
			require("configs.statusline")
		end,
	},
	{
		-- Add a sidebar map
		"echasnovski/mini.map",
		lazy = true,
		event = "VeryLazy",
		version = false,
		config = function()
			require("configs.map")
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
			require("configs.barbar")
		end,
	},
	{
		-- Add nice input dialogs to prompt
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("configs.dressing")
		end,
	},
	{
		-- Multipurpose panel, mainly for navigation
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		config = function()
			require("configs.telescope")
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
				dependencies = {
					{
						"kkharji/sqlite.lua",
						lazy = true,
						event = "VeryLazy",
					},
				},
			},
		},
	},
	{
		-- Revamped UI
		"folke/noice.nvim",
		event = "VeryLazy",
		lazy = true,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("configs.noice")
		end,
	},
	{
		-- Colorcolumn smart functionality
		"fmbarina/multicolumn.nvim",
		lazy = true,
		priority = 10,
		event = "VeryLazy",
		opts = {
			sets = {
				lua = {
					scope = "file",
				},
				default = {
					rulers = { 88 },
					full_column = true,
				},
				python = {
					scope = "window",
					rulers = { 88 },
					to_line_end = true,
				},
				exclude_ft = { "markdown", "help", "netrw", "starter" },
			},
		},
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
			require("configs.starter")
		end,
	},
}
