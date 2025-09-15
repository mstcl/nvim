local conf = require("core.variables")
local condition = conf.edit_features

-- Plugins that add extra functionality with keybindings or while editing
return {
	{ -- (better-escape.nvim) Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		event = "InsertCharPre",
		opts = {},
	},
	{ -- (mini.surround) Add motions to surround objects with brackets etc.
		"echasnovski/mini.surround",
		version = false,
		keys = {
			{ "gsa", desc = "add surrounding", mode = { "n", "v" } },
			{ "gsd", desc = "delete surrounding" },
			{ "gsf", desc = "find right surrounding" },
			{ "gsF", desc = "find left surrounding" },
			{ "gsc", desc = "highlight surrounding" },
			{ "gsr", desc = "replace surrounding" },
			{ "gsn", desc = "update surround n-lines" },
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
	{ -- (mini.bracketed) Bracketed motions for prev and next
		"echasnovski/mini.bracketed",
		version = false,
		keys = {
			{ "]b", desc = "next buffer" },
			{ "[b", desc = "previous buffer" },
			{ "]j", desc = "next jumplist" },
			{ "[j", desc = "previous jumplist" },
			{ "]l", desc = "next location" },
			{ "[l", desc = "previous location" },
			{ "]q", desc = "next quickfix" },
			{ "[q", desc = "previous quickfix" },
			{ "]B", desc = "last buffer" },
			{ "[B", desc = "first buffer" },
			{ "]J", desc = "last jumplist" },
			{ "[J", desc = "first jumplist" },
			{ "]L", desc = "last location" },
			{ "[L", desc = "first location" },
			{ "]Q", desc = "last quickfix" },
			{ "[Q", desc = "first quickfix" },
		},
		opts = {
			buffer = { suffix = "" },
			diagnostic = { suffix = "" },
			conflict = { suffix = "" },
			file = { suffix = "" },
			indent = { suffix = "" },
			undo = { suffix = "" },
			window = { suffix = "" },
			yank = { suffix = "" },
			treesitter = { suffix = "" },
			oldfile = { suffix = "" },
			comment = { suffix = "" },
		},
	},
	{ -- (move.nvim) Keybindings to move lines and blocks
		"fedepujol/move.nvim",
		keys = {
			{ "<A-j>", ":MoveBlock(1)<cr>", mode = "v", desc = "move block down" },
			{ "<A-k>", ":MoveBlock(-1)<cr>", mode = "v", desc = "move block up" },
			{ "<A-h>", ":MoveHBlocK(-1)<cr>", mode = "v", desc = "move block left" },
			{ "<A-l>", ":MoveHBlock(1)<cr>", mode = "v", desc = "move block right" },
			{ "<A-j>", ":MoveLine(1)<cr>", mode = "n", desc = "move line up" },
			{ "<A-k>", ":MoveLine(-1)<cr>", mode = "n", desc = "move line down" },
			{ "<A-h>", ":MoveHChar(-1)<cr>", mode = "n", desc = "move char left" },
			{ "<A-l>", ":MoveHChar(1)<cr>", mode = "n", desc = "move char right" },
			{ "<A-f>", ":MoveWord(1)<cr>", mode = "n", desc = "move word forward" },
			{ "<A-b>", ":MoveWord(-1)<cr>", mode = "n", desc = "move word backward" },
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
	{ -- (neotab.nvim) Tab out of parentheses
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {},
	},
	{ -- (boole.nvim) Toggling booleans and more
		"nat-418/boole.nvim",
		keys = {
			{
				"<C-A>",
				mode = { "n" },
				desc = "increment",
			},
			{
				"<C-X>",
				mode = { "n" },
				desc = "decrement",
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
	{ -- (nvim-spider) Better word movement
		"chrisgrieser/nvim-spider",
		keys = {
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
		},
	},
	{ -- (mini.pairs) Auto pairs
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
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
				"<leader>A",
				function()
					vim.g.minipairs_disable = not vim.g.minipairs_disable
				end,
				desc = "autopairs toggle",
			},
		},
	},
	{ -- (blink.cmp) Auto completion *
		"saghen/blink.cmp",
		cond = condition.completion,
		event = "InsertEnter",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "mikavilpas/blink-ripgrep.nvim" },
			{ "samiulsami/cmp-go-deep", dependencies = { "kkharji/sqlite.lua" } },
			{ "saghen/blink.compat" },
		},
		version = "v1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-K>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-space>"] = {},
				["<C-e>"] = {},
				["<C-P>"] = {},
				["<C-N>"] = {},
				["<C-CR>"] = { "hide" },
				["<C-U>"] = { "scroll_documentation_up", "fallback" },
				["<C-D>"] = { "scroll_documentation_down", "fallback" },
			},
			completion = {
				accept = {
					create_undo_point = true,
					auto_brackets = {
						enabled = true,
						default_brackets = { "(", ")" },
						override_brackets_for_filetypes = {},
						kind_resolution = {
							enabled = true,
							blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
						},
						semantic_token_resolution = {
							enabled = true,
							blocked_filetypes = {},
							timeout_ms = 400,
						},
					},
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					border = "none",
					scrollbar = false,
					draw = {
						treesitter = { "lsp" }, -- performance issues
						padding = { 0, 2 },
						gap = 1,
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									return " " .. ctx.kind_icon .. " " .. ctx.icon_gap
								end,
								highlight = function(ctx)
									return ctx.kind_hl
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					window = {
						max_width = 120,
						max_height = math.floor(vim.o.lines * 0.3),
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:FloatBorder,EndOfBuffer:BlinkCmpDoc",
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = conf.lsp_kind_icons,
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"go_deep",
					"ripgrep",
				},
				providers = {
					go_deep = {
						name = "go_deep",
						module = "blink.compat.source",
						min_keyword_length = 3,
						max_items = 5,
						---@module "cmp_go_deep"
						---@type cmp_go_deep.Options
						opts = {
							get_documentation_implementation = "hover",
							get_package_name_implementation = "regex",
						},
					},
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {
							prefix_min_len = 3,
							backend = {
								ripgrep = {
									context_size = 5,
								},
							},
						},
						max_items = 3,
						min_keyword_length = 3,
					},
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						enabled = true,
						transform_items = nil,
						should_show_items = true,
						max_items = nil,
						min_keyword_length = 0,
						fallbacks = { "buffer" },
						score_offset = 2,
						override = nil,
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 3,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = false,
						},
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						score_offset = -3,
						max_items = 3,
						min_keyword_length = 0,
						opts = {
							friendly_snippets = true,
							search_paths = { vim.fn.stdpath("config") .. "/snippets" },
							global_snippets = { "all" },
							extended_filetypes = {},
							ignored_filetypes = {},
							get_filetype = function(_)
								return vim.bo.filetype
							end,
						},
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						max_items = 3,
						min_keyword_length = 3,
					},
				},
			},
			signature = {
				enabled = true,
				window = { direction_priority = { "s", "n" } },
			},
		},
		opts_extend = { "sources.completion.enabled_providers" },
	},
	{ -- (conform.nvim) Formatter
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			quiet = true,
			default_format_opts = { lsp_format = "fallback" },
			formatters_by_ft = {
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				lua = { "stylua", lsp_format = "prefer" },
				markdown = { "prettierd", "injected", "mdslw" },
				quarto = { "prettierd", "injected", "mdslw" },
				yaml = { "prettierd" },
				graphql = { "prettierd" },
				vue = { "prettierd" },
				angular = { "prettierd" },
				less = { "prettierd" },
				flow = { "prettierd" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				go = { "goimports", "gofumpt", "gofmt", "golines", "gci" },
				terraform = { "terraform_fmt" },
				hcl = { "hcl" },
				python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
				opa = { "opa_fmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters = {
				prettier = {
					prepend_args = function()
						return { "--no-semi", "--single-quote", "--no-bracket-spacing", "--print-width", "80" }
					end,
				},
				injected = {
					options = {
						ignore_errors = false,
						lang_to_ext = {
							bash = "sh",
							shell = "sh",
							c_sharp = "cs",
							elixir = "exs",
							javascript = "js",
							julia = "jl",
							latex = "tex",
							markdown = "md",
							python = "py",
							ruby = "rb",
							rust = "rs",
							teal = "tl",
							r = "r",
							typescript = "ts",
							terraform = "tf",
						},
						lang_to_formatters = {},
					},
				},
			},
		},
	},
	{ -- (beam.nvim) Remote operation
		"Piotr1215/beam.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		event = "VeryLazy",
		opts = function()
			return {
				prefix = "gb",
				beam_scope = { enabled = false },
				resolved_conflicts = { "m" },
			}
		end,
		config = function(_, opts)
			require("beam").setup(opts)
			vim.cmd("BeamDiscoverNow")
		end,
	},
}
