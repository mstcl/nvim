-- Plugins to extend syntax, either natively or with treesitter
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = "VeryLazy",
		build = ":TSUpdate",
		init = function()
			require("utils.autocmds.treesitter")
		end,
		config = function()
			local ts_okay, ts = pcall(require, "nvim-treesitter.configs")
			if not ts_okay then
				return
			end
			ts.setup({
				ensure_installed = require("user_configs").treesitter_sources,
				highlight = {
					enable = true,
					use_languagetree = true,
					additional_vim_regex_highlighting = { "org" },
					disable = { "latex" },
				},
				autopairs = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = {
					enable = true,
				},
				tree_setter = {
					enable = true,
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25,
					persist_queries = false,
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ak"] = { query = "@block.outer", desc = "around block" },
							["ik"] = { query = "@block.inner", desc = "inside block" },
							["ac"] = { query = "@class.outer", desc = "around class" },
							["ic"] = { query = "@class.inner", desc = "inside class" },
							["a?"] = { query = "@conditional.outer", desc = "around conditional" },
							["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
							["af"] = { query = "@function.outer", desc = "around function " },
							["if"] = { query = "@function.inner", desc = "inside function " },
							["al"] = { query = "@loop.outer", desc = "around loop" },
							["il"] = { query = "@loop.inner", desc = "inside loop" },
							["aa"] = { query = "@parameter.outer", desc = "around argument" },
							["ia"] = { query = "@parameter.inner", desc = "inside argument" },
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]k"] = { query = "@block.outer", desc = "Next block start" },
							["]f"] = { query = "@function.outer", desc = "Next function start" },
							["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
						},
						goto_next_end = {
							["]K"] = { query = "@block.outer", desc = "Next block end" },
							["]F"] = { query = "@function.outer", desc = "Next function end" },
							["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
						},
						goto_previous_start = {
							["[k"] = { query = "@block.outer", desc = "Previous block start" },
							["[f"] = { query = "@function.outer", desc = "Previous function start" },
							["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
						},
						goto_previous_end = {
							["[K"] = { query = "@block.outer", desc = "Previous block end" },
							["[F"] = { query = "@function.outer", desc = "Previous function end" },
							["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							[">K"] = { query = "@block.outer", desc = "Swap next block" },
							[">F"] = { query = "@function.outer", desc = "Swap next function" },
							[">A"] = { query = "@parameter.inner", desc = "Swap next parameter" },
						},
						swap_previous = {
							["<K"] = { query = "@block.outer", desc = "Swap previous block" },
							["<F"] = { query = "@function.outer", desc = "Swap previous function" },
							["<A"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
						},
					},
				},
			})
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, event = "VeryLazy" },
			{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, event = "VeryLazy" },
			{ "filNaj/tree-setter",                          lazy = true, event = "VeryLazy" },
			{
				"nvim-treesitter/playground",
				cmd = "TSPlaygroundToggle",
			},
		},
	},
	{
		-- Highlight argument's definition and usage
		"m-demare/hlargs.nvim",
		lazy = true,
		event = { "VeryLazy" },
		opts = {
			color = "#87591a",
			hl_priority = 200,
		},
	},
	{
		-- Highlight parenthesis
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = { "VeryLazy" },
		config = function()
			local rainbow_ok, rainbow = pcall(require, "rainbow-delimiters.setup")
			if not rainbow_ok then
				return
			end
			rainbow.setup({
				query = {
					[""] = "rainbow-delimiters",
					latex = "rainbow-blocks",
					lua = "rainbow-blocks",
				},
				highlight = {
					"TSRainbowRed",
					"TSRainbowBlue",
					"TSRainbowCyan",
					"TSRainbowGreen",
					"TSRainbowviolet",
					"TSRainbowYellow",
				},
			})
		end,
	},
	{
		-- Concealing in tex
		"KeitaNakamura/tex-conceal.vim",
		lazy = true,
		ft = { "tex" },
	},
	{
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		lazy = true,
		event = { "BufReadPre", "BufEnter *.org", "BufWinEnter *.org" },
		config = function()
			local org_ok, orgmode = pcall(require, "orgmode")
			if not org_ok then
				return
			end

			orgmode.setup({
				org_agenda_files = { "~/sftpgo/orgzly/*", "~/sftpgo/shared/orgzly/*" },
				win_split_mode = "float",
				org_hide_emphasis_markers = true,
			})
			orgmode.setup_ts_grammar()
		end,
	},
	{
		-- Org bullet
		"akinsho/org-bullets.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			indent = true,
			symbols = {
				list = "•",
				headlines = { "◎", "○", "●", "◌" },
				checkboxes = {
					half = { "♣", "OrgTSCheckboxHalfChecked" },
					done = { "✓", "OrgDone" },
					todo = { "✗", "OrgTODO" },
				},
			},
		},
	},
	{
		-- QUARTO setup
		"quarto-dev/quarto-nvim",
		dev = false,
		lazy = true,
		ft = "quarto",
		opts = {
			lspFeatures = {
				languages = { "python", "bash", "html" },
			},
			keymap = {
				hover = "K",
				definition = "<leader>qd",
				type_definition = "<leader>qD",
				rename = "<leader>r",
				format = "<leader><space>",
			},
		},
	},
	{
		"kaarmu/typst.vim",
		lazy = true,
		ft = "typst",
		config = function()
			vim.g.typst_pdf_viewer = "sioyek"
		end,
	},
}
