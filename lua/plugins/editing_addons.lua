local cond = require("user_configs").edit_features

-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Snippet engine
		"L3MON4D3/LuaSnip",
		cond = cond.completion,
		build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "Zeioth/NormalSnippets" },
		},
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
		version = false,
		event = { "InsertEnter", "CmdlineEnter" },
		keys = {
			{
				"<C-M>c",
				function()
					vim.g.cmp_toggle = not vim.g.cmp_toggle
					if not vim.g.cmp_toggle then
						vim.notify("Disabled auto-completion", vim.log.levels.INFO)
					else
						vim.notify("Enabled auto-completion", vim.log.levels.INFO)
					end
				end,
				desc = "Toggle auto-completion",
			},
		},
		dependencies = {
			{ "saadparwaiz1/cmp_luasnip" },
			{ "kdheepak/cmp-latex-symbols" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "FelipeLema/cmp-async-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-cmdline" },
			{ "dmitmel/cmp-cmdline-history" },
			{
				"aspeddro/cmp-pandoc.nvim",
				opts = {
					filetypes = { "pandoc", "markdown", "rmd", "quarto" },
				},
			},
			{
				"tiagovla/zotex.nvim",
				dependencies = { "kkharji/sqlite.lua" },
				opts = {
					path = vim.fn.expand("~/Zotero/zotero.sqlite"),
				},
			},
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			return {
				auto_brackets = {},
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
					select = true,
				},
				preselect = cmp.PreselectMode.Item,
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sorting = {
					priority_weight = 1.0,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-P>"] = cmp.mapping.scroll_docs(-4),
					["<C-N>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
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
					format = function(_, item)
						local icon = require("user_configs").lsp_kind_icons[item.kind]
						icon = " " .. icon .. " "
						item.menu = ""
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
				view = {
					entries = {
						follow_cursor = true,
					},
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
						options = {
							markdown_oxide = {
								keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
							},
						},
						priority = 7,
						group_index = 1,
						max_item_count = 7,
					},
					{ name = "cmp_pandoc", priority = 9 },
					{ name = "zotex", priority = 9 },
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
			if opts then
				cmp.setup(opts)
			end
			local Kind = cmp.lsp.CompletionItemKind
			cmp.event:on("confirm_done", function(event)
				if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
					return
				end
				local entry = event.entry
				local item = entry:get_completion_item()
				if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) and item.insertTextFormat ~= 2 then
					local cursor = vim.api.nvim_win_get_cursor(0)
					local prev_char =
						vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
					if prev_char ~= "(" and prev_char ~= ")" then
						local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
						vim.api.nvim_feedkeys(keys, "i", true)
					end
				end
			end)
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-n>"] = {
						c = false,
					},
					["<C-p>"] = {
						c = false,
					},
				}),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-n>"] = {
						c = false,
					},
					["<C-p>"] = {
						c = false,
					},
				}),
				sources = cmp.config.sources({
					{ name = "async_path" },
					{ name = "cmdline" },
					{ name = "cmdline_history", priority = 9 },
				}),
			})
			for _, cmd_type in ipairs({ "?", "@" }) do
				cmp.setup.cmdline(cmd_type, {
					sources = {
						{ name = "cmdline_history" },
					},
				})
			end
			vim.g.cmp_toggle = true
		end,
	},
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		cond = cond.escape,
		event = "InsertCharPre",
		opts = {
			mapping = { "jk" },
			timeout = vim.o.timeoutlen,
			clear_empty_lines = false,
			keys = "<Esc>",
		},
	},
	{
		-- Add motions to surround objects with brackets etc.
		"echasnovski/mini.surround",
		version = false,
		keys = {
			{ "gsa", desc = "Add surrounding", mode = { "n", "v" } },
			{ "gsd", desc = "Delete surrounding" },
			{ "gsf", desc = "Find right surrounding" },
			{ "gsF", desc = "Find left surrounding" },
			{ "gsc", desc = "Highlight surrounding" },
			{ "gsr", desc = "Replace surrounding" },
			{ "gsn", desc = "Update surround n-lines" },
		},
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},
	{
		-- Bracketed motions for prev and next
		"echasnovski/mini.bracketed",
		version = false,
		keys = {
			{ "]c", desc = "Next comment" },
			{ "[c", desc = "Previous comment" },
			{ "]i", desc = "Next indent" },
			{ "[i", desc = "Previous indent" },
			{ "]j", desc = "Next jumplist" },
			{ "[j", desc = "Previous jumplist" },
			{ "]l", desc = "Next location" },
			{ "[l", desc = "Previous location" },
			{ "]o", desc = "Next oldfile" },
			{ "[o", desc = "Previous oldfile" },
			{ "]q", desc = "Next quickfix" },
			{ "[q", desc = "Previous quickfix" },
			{ "]t", desc = "Next treesitter" },
			{ "[t", desc = "Previous treesitter" },
			{ "]C", desc = "Last comment" },
			{ "[C", desc = "First comment" },
			{ "]I", desc = "Last indent" },
			{ "[I", desc = "First indent" },
			{ "]J", desc = "Last jumplist" },
			{ "[J", desc = "First jumplist" },
			{ "]L", desc = "Last location" },
			{ "[L", desc = "First location" },
			{ "]O", desc = "Last oldfile" },
			{ "[O", desc = "First oldfile" },
			{ "]Q", desc = "Last quickfix" },
			{ "[Q", desc = "First quickfix" },
			{ "]T", desc = "Last treesitter" },
			{ "[T", desc = "First treesitter" },
		},
		opts = {
			buffer = { suffix = "" },
			diagnostic = { suffix = "" },
			conflict = { suffix = "" },
			file = { suffix = "" },
			undo = { suffix = "" },
			window = { suffix = "" },
			yank = { suffix = "" },
		},
	},
	{
		-- Keybindings to move lines and blocks
		"fedepujol/move.nvim",
		cond = cond.move,
		keys = {
			{ "<A-j>", "<cmd>MoveBlock(1)<cr>", mode = "v", desc = "Move block down" },
			{ "<A-k>", "<cmd>MoveBlock(-1)<cr>", mode = "v", desc = "Move block up" },
			{ "<A-h>", "<cmd>MoveHBlocK(-1)<cr>", mode = "v", desc = "Move block left" },
			{ "<A-l>", "<cmd>MoveHBlock(1)<cr>", mode = "v", desc = "Move block right" },
			{ "<A-j>", "<cmd>MoveLine(1)<cr>", mode = "n", desc = "Move line up" },
			{ "<A-k>", "<cmd>MoveLine(-1)<cr>", mode = "n", desc = "Move line down" },
			{ "<A-h>", "<cmd>MoveHChar(-1)<cr>", mode = "n", desc = "Move char left" },
			{ "<A-l>", "<cmd>MoveHChar(1)<cr>", mode = "n", desc = "Move char right" },
			{ "<A-f>", "<cmd>MoveWord(1)<cr>", mode = "n", desc = "Move word forward" },
			{ "<A-b>", "<cmd>MoveWord(-1)<cr>", mode = "n", desc = "Move word backward" },
		},
		opts = {
			char = {
				enable = true,
			},
		},
		config = function(_, opts)
			if opts then
				require("move").setup(opts)
			end
		end,
	},
	{
		-- Jump around the buffer
		"folke/flash.nvim",
		cond = cond.flash,
		keys = {
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
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
			{
				"<C-S>",
				mode = { "c" },
				function()
					require("flash").toggle()
					vim.notify("Toggled searching with Flash", vim.log.levels.INFO)
				end,
				desc = "Toggled Flash Search",
			},
		},
		opts = function()
			return {
				prompt = {
					prefix = { { " FLASH ", "FlashPromptIcon" } },
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
			}
		end,
		config = function(_, opts)
			if opts then
				require("flash").setup(opts)
			end
		end,
	},
	{
		-- Tab out of parentheses
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
			{ "hrsh7th/nvim-cmp" },
			{ "L3MON4D3/LuaSnip" },
		},
		opts = function()
			return {
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
				exclude = {
					"yaml.ansible",
					"gotmpl",
					"template",
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("tabout").setup(opts)
			end
		end,
	},
	{
		-- Highlight brackets when inside block
		"utilyre/sentiment.nvim",
		version = "*",
		event = "BufRead",
		opts = function()
			return {
				pairs = {
					{ "(", ")" },
					{ "{", "}" },
					{ "[", "]" },
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("sentiment").setup(opts)
			end
		end,
	},
	{
		-- Quick guessing indent for filetypes
		"nmac427/guess-indent.nvim",
		event = "BufReadPost",
		opts = {
			override_editorconfig = true,
			auto_cmd = true,
		},
	},
	{
		-- Force cursor to stay in place when doing certain visual motions
		"gbprod/stay-in-place.nvim",
		keys = {
			{
				"==",
				mode = { "n" },
			},
			{
				"<<",
				mode = { "n" },
			},
			{
				">>",
				mode = { "n" },
			},
			{
				"=",
				mode = { "v" },
			},
			{
				"<",
				mode = { "v" },
			},
			{
				">",
				mode = { "v" },
			},
		},
		opts = {},
	},
	{
		-- Toggling booleans and more
		"nat-418/boole.nvim",
		keys = {
			{
				"<C-A>",
				mode = { "n" },
				desc = "Increment",
			},
			{
				"<C-X>",
				mode = { "n" },
				desc = "Decrement",
			},
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
		ft = { "python", "typescript", "javascript" },
	},
	{
		-- Smart rooter, replaces autochdir
		"notjedi/nvim-rooter.lua",
		event = "VeryLazy",
		keys = {
			{
				"<C-M>r",
				function()
					vim.cmd("RooterToggle")
					vim.notify("Toggled Rooter", vim.log.levels.INFO)
				end,
				desc = "Toggle between autochdir 🡘 root dir",
			},
		},
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
		cond = cond.spider,
		keys = {
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
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
	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			mappings = {
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
			},
		},
		keys = {
			{
				"<C-M>p",
				function()
					vim.g.minipairs_disable = not vim.g.minipairs_disable
					if vim.g.minipairs_disable then
						vim.notify("Disabled auto-pairs", vim.log.levels.INFO)
					else
						vim.notify("Enabled auto-pairs", vim.log.levels.INFO)
					end
				end,
				desc = "Toggle auto-pairs",
			},
		},
	},
	{
		-- Textobjects
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					g = function() -- Whole buffer, similar to `gg` and 'G' motion
						local from = { line = 1, col = 1 }
						local to = {
							line = vim.fn.line("$"),
							col = math.max(vim.fn.getline("$"):len(), 1),
						}
						return { from = from, to = to }
					end,
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("mini.ai").setup(opts)
			end
			---@type table<string, string|table>
			local i = {
				[" "] = "Whitespace",
				['"'] = 'Balanced "',
				["'"] = "Balanced '",
				["`"] = "Balanced `",
				["("] = "Balanced (",
				[")"] = "Balanced ) including white-space",
				[">"] = "Balanced > including white-space",
				["<lt>"] = "Balanced <",
				["]"] = "Balanced ] including white-space",
				["["] = "Balanced [",
				["}"] = "Balanced } including white-space",
				["{"] = "Balanced {",
				["?"] = "User Prompt",
				_ = "Underscore",
				a = "Argument",
				b = "Balanced ), ], }",
				c = "Class",
				d = "Digit(s)",
				e = "Word in CamelCase & snake_case",
				f = "Function",
				g = "Entire file",
				o = "Block, conditional, loop",
				q = "Quote `, \", '",
				t = "Tag",
				u = "Use/call function & method",
				U = "Use/call without dot in name",
			}
			local a = vim.deepcopy(i)
			for k, v in pairs(a) do
				a[k] = v:gsub(" including.*", "")
			end

			local ic = vim.deepcopy(i)
			local ac = vim.deepcopy(a)
			for key, name in pairs({ n = "Next", l = "Last" }) do
				i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
				a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
			end
			require("which-key").register({
				mode = { "o", "x" },
				i = i,
				a = a,
			})
		end,
	},
	{
		-- Remove buffers
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<C-Q>",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			-- stylua: ignore
			{ "<C-Down>", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
		},
	},
}
