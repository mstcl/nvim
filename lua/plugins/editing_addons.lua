-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Snippet engine
		"L3MON4D3/LuaSnip",
		build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
		dependencies = {
			{ "rafamadriz/friendly-snippets",     lazy = true, event = "InsertEnter" },
			{ "Zeioth/NormalSnippets",            lazy = true, event = "InsertEnter" },
			{ "benfowler/telescope-luasnip.nvim", lazy = true, event = "InsertEnter" },
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
			{ "jmbuhr/otter.nvim",         lazy = true, event = "InsertEnter" },
			{ "saadparwaiz1/cmp_luasnip",  lazy = true, event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp",      lazy = true, event = "InsertEnter" },
			{ "FelipeLema/cmp-async-path", lazy = true, event = "InsertEnter" },
			{ "hrsh7th/cmp-buffer",        lazy = true, event = "InsertEnter" },
			{
				"aspeddro/cmp-pandoc.nvim",
				lazy = true,
				event = "InsertEnter",
				opts = {
					filetypes = { "pandoc", "markdown", "rmd", "quarto" },
				},
			},
		},
		config = function()
			local cmp_ok, cmp = pcall(require, "cmp")
			if not cmp_ok then
				return
			end
			local luasnip_ok, luasnip = pcall(require, "luasnip")
			if not luasnip_ok then
				return
			end
			cmp.setup({
				enabled = function()
					return vim.g.cmp_toggle
				end,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				preselect = cmp.PreselectMode.Item,
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sorting = {
					priority_weight = 1.0,
				},
				sources = cmp.config.sources({
					{ name = "luasnip",  priority = 9 },
					{ name = "path" },
					{ name = "nvim_lsp", priority = 8,    group_index = 1 },
					{ name = "buffer",   group_index = 2, keyword_length = 5, max_item_count = 3 },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end,
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						local icon = require("user_configs").lsp_kind_icons[item.kind]
						icon = " " .. icon .. " "
						item.menu = "   (" .. item.kind .. ")"
						item.kind = icon
						item.abbr = string.sub(item.abbr, 1, 20)
						return item
					end,
				},
				window = {
					completion = {
						side_padding = 0,
						scrollbar = false,
					},
					documentation = {
						border = "single",
						winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
						max_width = 120,
						max_height = math.floor(vim.o.lines * 0.3),
					},
				},
				experimental = {
					ghost_text = true,
					hl_group = "NonText"
				},
			})
			cmp.setup.filetype({ "quarto, markdown" }, {
				sources = {
					{ name = "path" },
					{ name = "luasnip",    priority = 8 },
					{ name = "nvim_lsp",   priority = 7, group_index = 1 },
					{ name = "cmp_pandoc", priority = 9 },
					{
						name = "buffer",
						options = require("utils.misc").buffer_opts,
					},
				},
			})
			cmp.setup.filetype({ "org" }, {
				sources = {
					{ name = "orgmode" },
					{ name = "path" },
					{ name = "luasnip", priority = 9 },
					{ name = "nvim_lsp" },
					{
						name = "buffer",
						options = require("utils.misc").buffer_opts,
					},
				},
			})
			vim.g.cmp_toggle = true
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
		event = "InsertEnter",
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
		config = function()
			require("utils.mappings.movement")
		end,
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
		event = "InsertEnter",
		lazy = true,
		dependencies = {
			-- { "nvim-treesitter/nvim-treesitter", lazy = true, event = "VeryLazy" },
			{ "hrsh7th/nvim-cmp", lazy = true, event = "InsertEnter" },
			{ "L3MON4D3/LuaSnip", lazy = true, event = "InsertEnter" },
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
		-- 	-- Smart rooter, replaces autochdir
		"notjedi/nvim-rooter.lua",
		lazy = true,
		event = "VeryLazy",
		opts = {
			manual = false,
			exclude_filetypes = { "quarto", "markdown", "org"},
			rooter_patterns = {
				".git",
				".hg",
				"project.json",
				".svn",
				"pyproject.toml",
				"README.md",
			},
		},
	},
}
