-- Plugins that add extra functionalities by modifying behaviours of default nvim
return {
	{
		-- Show gutter signs even for folded blocks
		"lewis6991/foldsigns.nvim",
		lazy = true,
		event = "BufRead",
		opts = {
			exclude = { "LspDiagnosticsSignWarning" },
		},
	},
	{
		-- Folding customization using LSP and more
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async", "neovim/nvim-lspconfig" },
		config = function()
			require("configs.ufo")
		end,
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
		-- Show gutter symbols for marks
		"chentoast/marks.nvim",
		lazy = true,
		ft = "markdown",
		config = function()
			require("configs.marks")
		end,
	},
	{
		-- Naively highlight word under cursor
		"echasnovski/mini.cursorword",
		event = "CursorMoved",
		version = false,
		opts = {},
	},
	{
		-- Highlight color blocks
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		ft = {
			"html",
			"css",
			"sass",
			"vim",
			"lua",
			"javascript",
			"typescript",
			"dosini",
			"ini",
			"conf",
			"json",
			"cfg",
		},
		cmd = { "ColorizerToggle" },
		config = function()
			require("colorizer").setup()
			vim.cmd("ColorizerAttachToBuffer")
		end,
	},
	{
		-- Show indent lines
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("configs.hlchunk")
		end,
	},
	{
		-- Utility to hide numbers in foldcolumn
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				segments = {
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{ text = { "%s" },                  click = "v:lua.ScSa" },
					{
						text = { builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
				},
			})
		end,
	},
	{
		-- Git status in gutter
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.gitsigns")
		end,
	},
}
