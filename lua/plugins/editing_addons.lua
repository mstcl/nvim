-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Snippet engine
		"sirver/ultisnips",
		lazy = true,
		event = "InsertEnter",
		init = function()
			vim.g.UltiSnipsExpandTrigger = "<nop>"
			vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
			vim.g.UltiSnipsRemoveSelectModeMappings = 0
		end,
		config = function()
			vim.cmd('let g:UltiSnipsSnippetDirectories=["~/.config/nvim/ultisnips"]')
		end,
	},
	{
		-- Autocompletion menu & plugins
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			require("configs.editing.cmp")
		end,
	},
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
		opts = {
			fast_wrap = {
				manual_position = false,
			},
		},
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
				prefix = { { "◆", "FlashPromptIcon" } },
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
		config = function()
			require("configs.editing.tabout")
		end,
	},
	{
		-- Highlight brackets when inside block
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			pairs = {
				{ "(", ")" },
				{ "{", "}" },
				{ "[", "]" },
			},
		},
	},
	{
		-- Quick guessing indent for filetypes
		"nmac427/guess-indent.nvim",
		lazy = true,
		event = "BufRead",
		opts = {
			override_editorconfig = true,
			auto_cmd = true,
		},
	},
	{
		-- Force cursor to stay in place when doing certain visual motions
		"gbprod/stay-in-place.nvim",
		lazy = true,
		event = "CursorMoved",
		opts = {},
	},
	{
		-- Invert toggler
		"nguyenvukhang/nvim-toggler",
		lazy = true,
		event = "VeryLazy",
		opts = {
			remove_default_keybinds = true,
		},
	},
	{
		-- Context at end of block
		"code-biscuits/nvim-biscuits",
		lazy = true,
		event = "VeryLazy",
		opts = {
			show_on_start = true,
			cursor_line_only = true,
			prefix_string = " □ "
		}
	}
}
