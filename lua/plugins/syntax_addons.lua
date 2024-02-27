-- Plugins to extend syntax, either natively or with treesitter
local cond = require("user_configs").lsp_enabled
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		cmd = {
			"TSInstall",
			"TSInstallSync",
			"TSInstallInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSBufEnable",
			"TSBufToggle",
			"TSEnable",
			"TSToggle",
			"TSModuleInfo",
			"TSEditQuery",
			"TSEditQueryUserAfter",
		},
		event = "FileType",
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
				sync_install = false,
				highlight = {
					enable = true,
					use_languagetree = true,
					additional_vim_regex_highlighting = { "org" },
					disable = { "latex", "yaml" },
				},
				autopairs = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = false,
						node_incremental = "an",
						scope_incremental = "aN",
						node_decremental = "in",
					},
				},
				indent = {
					enable = true,
					disable = { "yaml" },
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
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				lazy = true,
				event = "FileType",
				config = function()
					require("ts_context_commentstring").setup({})
					vim.g.skip_ts_context_commentstring_module = true
				end,
			},
			{ "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, event = "FileType" },
			{ "filNaj/tree-setter", lazy = true, event = "FileType" },
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
		cond = require("user_configs").syntax_features.hlargs,
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
		cond = require("user_configs").syntax_features.rainbow,
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
		cond = require("user_configs").syntax_features.tex,
		ft = { "tex" },
	},
	{
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		lazy = true,
		cond = require("user_configs").syntax_features.org,
		event = { "BufReadPre", "BufEnter *.org", "BufWinEnter *.org" },
		config = function()
			local org_ok, orgmode = pcall(require, "orgmode")
			if not org_ok then
				return
			end

			orgmode.setup({
				org_agenda_files = require("user_configs").org_agenda_files,
				win_split_mode = "vsplit",
				win_border = "single",
				org_highlight_latex_and_related = "entities",
				org_hide_emphasis_markers = true,
			})
			orgmode.setup_ts_grammar()
		end,
	},
	{
		-- Org bullet
		"akinsho/org-bullets.nvim",
		lazy = true,
		cond = require("user_configs").syntax_features.org,
		event = "FileType",
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
		cond = require("user_configs").syntax_features.quarto,
		ft = "quarto",
		dependencies = {
			"jmbuhr/otter.nvim",
			lazy = true,
			cond = cond,
			dependencies = { "neovim/nvim-lspconfig", lazy = true, event = "BufRead" },
			event = "InsertEnter",
			opts = {
				lsp = {
					hover = {
						border = "single",
					},
				},
				buffers = {
					set_filetype = true,
				},
			},
		},
		opts = {
			lspFeatures = {
				languages = { "python", "bash", "html", "lua" },
			},
			keymap = {
				hover = "<C-K>",
				definition = "<leader>qd",
				type_definition = "<leader>qD",
				rename = "<leader>r",
				format = "<leader><space>",
			},
		},
	},
	{
		-- Typst syntax
		"kaarmu/typst.vim",
		lazy = true,
		cond = require("user_configs").syntax_features.typst,
		event = "FileType",
		config = function()
			vim.g.typst_pdf_viewer = "sioyek"
		end,
	},
	{
		-- Ansible syntax
		"pearofducks/ansible-vim",
		cond = require("user_configs").syntax_features.ansible,
		lazy = true,
		event = "VeryLazy",
	},
}
