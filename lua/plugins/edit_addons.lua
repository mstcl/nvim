local cond = require("core.variables").edit_features

-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Autocompletion menu & plugins
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter" },
		keys = {
			{
				"<C-M>ca",
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
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "FelipeLema/cmp-async-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "rafamadriz/friendly-snippets" },
			{
				"garymjr/nvim-snippets",
				opts = {
					friendly_snippets = true,
					extended_filetypes = {
						{ typescript = { "tsdoc" } },
						{ javascript = { "jsdoc" } },
						{ lua = { "luadoc" } },
						{ python = { "pydoc" } },
						{ rust = { "rustdoc" } },
						{ cs = { "csharpdoc" } },
						{ java = { "javadoc" } },
						{ c = { "cdoc" } },
						{ cpp = { "cppdoc" } },
						{ php = { "phpdoc" } },
						{ kotlin = { "kdoc" } },
						{ ruby = { "rdoc" } },
						{ sh = { "shelldoc" } },
						{ quarto = { "markdown" } },
						{ rmarkdown = { "markdown" } },
					},
				},
			},
			{
				"aspeddro/cmp-pandoc.nvim",
				opts = {
					filetypes = { "pandoc", "markdown", "rmd", "quarto" },
				},
			},
		},
		opts = function()
			local cmp = require("cmp")
			return {
				auto_brackets = {},
				enabled = function()
					return vim.g.cmp_toggle
				end,
				snippet = {
					expand = function(snippet)
						vim.snippet.expand(snippet.body)
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
					["<CR>"] = function(fallback)
						if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
							if cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }) then
								return
							end
						end
						return fallback()
					end,
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					["<Tab>"] = function(_)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif vim.snippet.active({ direction = 1 }) then
							vim.snippet.jump(1)
						else
							require("neotab").tabout()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						elseif vim.snippet.active({ direction = -1 }) then
							vim.snippet.jump(-1)
						else
							fallback()
						end
					end,
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, item)
						local icon = require("core.variables").lsp_kind_icons[item.kind]
						if icon == nil then
							icon = "•"
						end
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
					{ name = "snippets", priority = 8, max_item_count = 3 },
					{ name = "otter" },
					{
						name = "async_path",
						max_item_count = 4,
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
					{
						name = "buffer",
						options = require("core.utils").buffer_opts,
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
			vim.g.cmp_toggle = cond.completion
		end,
	},
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
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
		keys = {
			{ "<A-j>", ":MoveBlock(1)<cr>", mode = "v", desc = "Move block down" },
			{ "<A-k>", ":MoveBlock(-1)<cr>", mode = "v", desc = "Move block up" },
			{ "<A-h>", ":MoveHBlocK(-1)<cr>", mode = "v", desc = "Move block left" },
			{ "<A-l>", ":MoveHBlock(1)<cr>", mode = "v", desc = "Move block right" },
			{ "<A-j>", ":MoveLine(1)<cr>", mode = "n", desc = "Move line up" },
			{ "<A-k>", ":MoveLine(-1)<cr>", mode = "n", desc = "Move line down" },
			{ "<A-h>", ":MoveHChar(-1)<cr>", mode = "n", desc = "Move char left" },
			{ "<A-l>", ":MoveHChar(1)<cr>", mode = "n", desc = "Move char right" },
			{ "<A-f>", ":MoveWord(1)<cr>", mode = "n", desc = "Move word forward" },
			{ "<A-b>", ":MoveWord(-1)<cr>", mode = "n", desc = "Move word backward" },
		},
		opts = function()
			return {
				char = {
					enable = true,
				},
				block = {
					indent = false,
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("move").setup(opts)
			end
		end,
	},
	{
		-- Jump around the buffer
		"folke/flash.nvim",
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
		"kawre/neotab.nvim",
		event = "InsertEnter",
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
		-- Better word movement
		"chrisgrieser/nvim-spider",
		keys = {
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
		},
	},
	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			mappings = {
				["`"] = {
					action = "closeopen",
					pair = "``",
					neigh_pattern = "[^\\`].",
					register = { cr = false },
				},
			},
		},
		keys = {
			{
				"<C-M>ap",
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
					g = function()
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
				---@diagnostic disable-next-line: param-type-mismatch
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
}
