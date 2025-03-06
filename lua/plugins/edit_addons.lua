local cond = require("core.variables").edit_features
local function override_event()
  return {}
end

-- Plugins that add extra functionality with keybindings or while editing
return {
	{
		-- Allows mapping custom escape keys without ruining typing experience.
		"max397574/better-escape.nvim",
		event = "InsertCharPre",
		opts = {},
	},
	{
		-- Add motions to surround objects with brackets etc.
		"echasnovski/mini.surround",
		version = false,
		keys = {
			{ "gsa", desc = "Add surrounding",        mode = { "n", "v" } },
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
			{ "<A-j>", ":MoveBlock(1)<cr>",   mode = "v", desc = "Move block down" },
			{ "<A-k>", ":MoveBlock(-1)<cr>",  mode = "v", desc = "Move block up" },
			{ "<A-h>", ":MoveHBlocK(-1)<cr>", mode = "v", desc = "Move block left" },
			{ "<A-l>", ":MoveHBlock(1)<cr>",  mode = "v", desc = "Move block right" },
			{ "<A-j>", ":MoveLine(1)<cr>",    mode = "n", desc = "Move line up" },
			{ "<A-k>", ":MoveLine(-1)<cr>",   mode = "n", desc = "Move line down" },
			{ "<A-h>", ":MoveHChar(-1)<cr>",  mode = "n", desc = "Move char left" },
			{ "<A-l>", ":MoveHChar(1)<cr>",   mode = "n", desc = "Move char right" },
			{ "<A-f>", ":MoveWord(1)<cr>",    mode = "n", desc = "Move word forward" },
			{ "<A-b>", ":MoveWord(-1)<cr>",   mode = "n", desc = "Move word backward" },
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
	{
		-- Auto pairs
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
		-- Auto completion
		"saghen/blink.cmp",
		cond = cond.completion,
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
		},
		version = "v0.*",
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
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = require("core.variables").lsp_kind_icons,
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"ripgrep",
				},
				providers = {
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {
							prefix_min_len = 3,
							context_size = 5,
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
							get_filetype = function(context)
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
				window = {
					direction_priority = { "s", "n" },
				},
			},
		},
		opts_extend = { "sources.completion.enabled_providers" },
	},
}
