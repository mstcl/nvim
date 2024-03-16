local cond = require("user_configs").edit_features

-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Snippet engine
		"L3MON4D3/LuaSnip",
		cond = cond.completion,
		build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
		dependencies = {
			{ "rafamadriz/friendly-snippets",     lazy = true, event = "InsertEnter" },
			{ "Zeioth/NormalSnippets",            lazy = true, event = "InsertEnter" },
			{ "benfowler/telescope-luasnip.nvim", lazy = true, event = "InsertEnter" },
		},
		lazy = true,
		event = "ModeChanged *:[iRss\x13vV\x16]*",
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
			local luasnip_ok, luasnip = pcall(require, "luasnip")
			if not luasnip_ok then
				return
			end
			luasnip.filetype_extend("typescript", { "tsdoc" })
			luasnip.filetype_extend("javascript", { "jsdoc" })
			luasnip.filetype_extend("lua", { "luadoc" })
			luasnip.filetype_extend("python", { "pydoc" })
			luasnip.filetype_extend("rust", { "rustdoc" })
			luasnip.filetype_extend("cs", { "csharpdoc" })
			luasnip.filetype_extend("java", { "javadoc" })
			luasnip.filetype_extend("c", { "cdoc" })
			luasnip.filetype_extend("cpp", { "cppdoc" })
			luasnip.filetype_extend("php", { "phpdoc" })
			luasnip.filetype_extend("kotlin", { "kdoc" })
			luasnip.filetype_extend("ruby", { "rdoc" })
			luasnip.filetype_extend("sh", { "shelldoc" })
			luasnip.filetype_extend("quarto", { "markdown" })
			luasnip.filetype_extend("rmarkdown", { "markdown" })
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})
		end,
	},
	{
		-- Autocompletion menu & plugins
		"hrsh7th/nvim-cmp",
		cond = cond.completion,
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			{ "saadparwaiz1/cmp_luasnip",   lazy = true, event = "InsertEnter" },
			{ "kdheepak/cmp-latex-symbols", lazy = true, event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp",       lazy = true, event = "InsertEnter" },
			{ "FelipeLema/cmp-async-path",  lazy = true, event = "InsertEnter" },
			{ "hrsh7th/cmp-buffer",         lazy = true, event = "InsertEnter" },
			{
				"aspeddro/cmp-pandoc.nvim",
				lazy = true,
				event = "InsertEnter",
				opts = {
					filetypes = { "pandoc", "markdown", "rmd", "quarto" },
				},
			},
		},
		opts = function()
			local cmp_ok, cmp = pcall(require, "cmp")
			if not cmp_ok then
				return
			end
			local luasnip_ok, luasnip = pcall(require, "luasnip")
			if not luasnip_ok then
				return
			end
			return {
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
						item.abbr = string.sub(item.abbr, 1, 30)
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
					hl_group = "NonText",
				},
				sources = cmp.config.sources({
					{ name = "latex_symbols", priority = 2 },
					{ name = "otter" },
					{ name = "orgmode" },
					{
						name = "async_path",
						max_item_count = 4,
					},
					{
						name = "luasnip",
						priority = 8,
						max_item_count = 3,
					},
					{
						name = "nvim_lsp",
						priority = 7,
						group_index = 1,
						max_item_count = 5,
					},
					{ name = "cmp_pandoc", priority = 9 },
					{
						name = "buffer",
						options = require("utils.misc").buffer_opts,
						keyword_length = 5,
						max_item_count = 2,
					},
				}),
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup(opts)
			vim.g.cmp_toggle = true
		end,
	},
	{
		-- Syntax aware comments & keybindings
		"numToStr/Comment.nvim",
		lazy = true,
		keys = {
			{ "gc", mode = { "n", "x" } },
			{ "gb", mode = { "n", "x" } },
		},
		opts = {},
	},
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		cond = cond.escape,
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
		event = { "InsertEnter", "CmdlineEnter" },
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
		keys = {
			"ys",
			"ds",
			"cs",
			{ "S",      mode = "x" },
			{ "<C-g>s", mode = "i" },
		},
		opts = {},
	},
	{
		-- Keybindings to move lines and blocks
		"fedepujol/move.nvim",
		cond = cond.move,
		lazy = true,
		event = "BufRead",
		opts = {
			char = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("move").setup(opts)
			require("utils.mappings.movement")
		end,
	},
	{
		-- Jump around the buffer
		"folke/flash.nvim",
		cond = cond.flash,
		lazy = true,
		keys = {
			{ "s", mode = { "n", "x", "o" } },
			{ "R", mode = { "n", "x", "o" } },
			{ "r", mode = { "o" } },
		},
		---@type Flash.Config
		opts = {
			prompt = {
				prefix = { { "Flash", "FlashPromptIcon" } },
			},
			modes = {
				char = {
					multi_line = false,
				},
			},
			label = {
				rainbow = {
					enabled = true,
					shade = 9,
				},
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
				{ open = "<", close = ">" },
				{ open = "$", close = "$" },
				{ open = "%", close = "%" },
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
		-- Toggling booleans and more
		"nat-418/boole.nvim",
		lazy = true,
		keys = {
			{ "<C-A>", mode = { "n" } },
			{ "<C-X>", mode = { "n" } },
		},
		opts = {
			mappings = {
				increment = "<C-A>",
				decrement = "<C-X>",
			},
			allow_caps_additions = {
				{ "true", "false" },
			},
		},
	},
	{
		-- Context at end of block, outside parentheses
		"code-biscuits/nvim-biscuits",
		cond = cond.biscuits,
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
		-- Smart rooter, replaces autochdir
		"notjedi/nvim-rooter.lua",
		lazy = true,
		event = "VeryLazy",
		cond = cond.rooter,
		opts = {
			manual = false,
			exclude_filetypes = { "quarto", "markdown", "org", "tex", "bib" },
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
	{
		-- Better word movement
		"chrisgrieser/nvim-spider",
		lazy = true,
		cond = cond.spider,
		keys = {
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x"} },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x"} },
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x"} },
		},
	},
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			open_browser_app = "xdg-open",
			handlers = {
				plugin = true,
				github = true,
				brewfile = true,
				package_json = true,
				search = true,
			},
		},
	},
}
