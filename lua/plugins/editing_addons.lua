-- Plugins that add extra functionality with keybindings or while editing
return {
	-- {
	-- 	-- Snippet engine
	-- 	"sirver/ultisnips",
	-- 	lazy = true,
	-- 	event = "InsertEnter",
	-- 	init = function()
	-- 		vim.g.UltiSnipsExpandTrigger = "<nop>"
	-- 		vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
	-- 		vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
	-- 		vim.g.UltiSnipsRemoveSelectModeMappings = 0
	-- 	end,
	-- 	config = function()
	-- 		vim.cmd('let g:UltiSnipsSnippetDirectories=["~/.config/nvim/ultisnips"]')
	-- 	end,
	-- },
	{
		"L3MON4D3/LuaSnip",
		build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"Zeioth/NormalSnippets",
			"benfowler/telescope-luasnip.nvim",
		},
		lazy = true,
		event = "InsertEnter",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			region_check_events = "CursorMoved",
		},
		config = function(_, opts)
			if opts then
				require("luasnip").config.setup(opts)
			end
			vim.tbl_map(function(type)
				require("luasnip.loaders.from_" .. type).lazy_load()
			end, { "vscode", "snipmate", "lua" })
			require("luasnip").filetype_extend("typescript", { "tsdoc" })
			require("luasnip").filetype_extend("javascript", { "jsdoc" })
			require("luasnip").filetype_extend("lua", { "luadoc" })
			require("luasnip").filetype_extend("python", { "pydoc" })
			require("luasnip").filetype_extend("rust", { "rustdoc" })
			require("luasnip").filetype_extend("cs", { "csharpdoc" })
			require("luasnip").filetype_extend("java", { "javadoc" })
			require("luasnip").filetype_extend("c", { "cdoc" })
			require("luasnip").filetype_extend("cpp", { "cppdoc" })
			require("luasnip").filetype_extend("php", { "phpdoc" })
			require("luasnip").filetype_extend("kotlin", { "kdoc" })
			require("luasnip").filetype_extend("ruby", { "rdoc" })
			require("luasnip").filetype_extend("sh", { "shelldoc" })
		end,
	},
	{
		-- Autocompletion menu & plugins
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			{ "jmbuhr/otter.nvim",            lazy = true, event = "VeryLazy" },
			-- { "ultisnips",                           lazy = true, event = "VeryLazy" },
			{ "saadparwaiz1/cmp_luasnip",     lazy = true, event = "VeryLazy" },
			-- { "quangnguyen30192/cmp-nvim-ultisnips", lazy = true, event = "VeryLazy" },
			{ "hrsh7th/cmp-nvim-lsp",         lazy = true, event = "VeryLazy" },
			{ "hrsh7th/cmp-path",             lazy = true, event = "VeryLazy" },
			{ "hrsh7th/cmp-buffer",           lazy = true, event = "VeryLazy" },
			{ "jmbuhr/cmp-pandoc-references", lazy = true, event = "VeryLazy" },
		},
		config = function()
			require("configs.editing.cmp")
		end,
	},
	{
		-- Syntax aware comments & keybindings
		"numToStr/Comment.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			opts = function()
				local commentstring_avail, commentstring =
					pcall(require, "ts_context_commentstring.integrations.comment_nvim")
				return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
			end,
		},
	},
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		lazy = true,
		event = "InsertCharPre",
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
		lazy = true,
		event = "VeryLazy",
		opts = {
			check_ts = true,
			ts_config = { java = false },
			fast_wrap = {
				map = "<M-e>",
				manual_position = false,
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "CurSearch",
				highlight_grey = "Comment",
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
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("configs.editing.tabout")
		end,
	},
	{
		-- Highlight brackets when inside block
		"utilyre/sentiment.nvim",
		version = "*",
		lazy = true,
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
		event = "VeryLazy",
		opts = {
			override_editorconfig = true,
			auto_cmd = true,
		},
	},
	{
		-- Force cursor to stay in place when doing certain visual motions
		"gbprod/stay-in-place.nvim",
		lazy = true,
		event = "VeryLazy",
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
			prefix_string = " □ ",
			language_config = {
				org = {
					disabled = true,
				},
				markdown = {
					disabled = true,
				},
			},
		},
	},
	{
		-- Automatically add f-strings
		"chrisgrieser/nvim-puppeteer",
		lazy = false,
	},
	{
		-- Smart project root autochdir
		"Zeioth/project.nvim",
		lazy = true,
		event = "VeryLazy",
		cmd = "ProjectRoot",
		opts = {
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				".solution",
			},
			exclude_dirs = {
				"~/",
			},
			silent_chdir = true,
			manual_mode = false,
			exclude_filetype_chdir = { "" },
			exclude_buftype_chdir = { "nofile", "terminal" },
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
}
