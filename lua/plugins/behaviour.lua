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
		opts = {}
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
		-- Show an interactive registers when pasting in normal and insert
		"tversteeg/registers.nvim",
		lazy = true,
		cmd = "Registers",
		keys = {
			{ '"',     mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
		config = function()
			require("configs.registers")
		end,
	},
	{
		-- Naively highlight word under cursor
		"echasnovski/mini.cursorword",
		event = "CursorMoved",
		version = false,
		opts = {}
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
		-- Show indentation levels
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		cmd = {
			"IndentBlanklineEnable",
			"IndentBlanklineToggle",
		},
		opts = {
			buftype_exclude = { "terminal" },
			bufnameExclude = { "README.md" },
			show_current_context = true,
			show_end_of_line = false,
			filetype_exclude = { "tex" },
			enabled = "true",
			char_priority = 50
		}
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
