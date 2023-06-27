-- Plugins that modify big UI autocomplete.lua{
	{
        -- Colorscheme
		"https://git.bim.boats/dmg",
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
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("configs.statusline")
		end,
	},
	{
		-- Add a sidebar map
		"echasnovski/mini.map",
		ft = { "python", "tex", "lua", "markdown", "md" },
		version = false,
		config = function()
			require("configs.map")
			vim.cmd("lua MiniMap.toggle()")
		end,
	},
	{
		-- Add a customisable dashboard
		"goolord/alpha-nvim",
		lazy = true,
		cmd = { "Alpha" },
		config = function()
			require("configs.alpha")
		end,
	},
	{
		-- Tabline and bufferline
		"romgrk/barbar.nvim",
		lazy = true,
		event = "BufAdd",
		dependencies = { "nvim-web-devicons" },
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		config = function()
			require("configs.barbar")
		end,
	},
	{
		-- Nice icons for UI
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("configs.devicons")
		end,
	},
	{
		-- Smooth scrolling
		"declancm/cinnamon.nvim",
		lazy = true,
		event = "BufEnter",
		opts = {
			default_keymaps = true,
			centered = true,
			disable = false,
			scroll_limit = 150,
			hide_cursor = true,
			default_delay = 7,
			horizontal_scroll = true,
		},
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
				dependencies = { "kkharji/sqlite.lua" },
			},
		},
	},
}
