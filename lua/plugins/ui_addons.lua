-- Plugins that modify UI
return {
	{
		-- Colorscheme
		"mstcl/dmg",
		lazy = false,
		priority = 1000,
		config = function()
			vim.api.nvim_command("colorscheme dmg")
			if require("user_configs").dap_enabled then
				local dap_signs = require("user_configs").dap_signs
				for type, icon in pairs(dap_signs) do
					local hl = "Dap" .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end
			end
			if require("user_configs").lsp_enabled then
				local lsp_signs = require("user_configs").lsp_signs
				for type, icon in pairs(lsp_signs) do
					local hl = "DiagnosticSign" .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end
			end
		end,
	},
	{
		-- Statusline
		"sontungexpt/sttusline",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		branch = "table_version",
		opts = function()
			return {
				statusline_color = "StatusLine",
				laststatus = 3,
				components = {
					require("statusline.mode"),
					require("statusline.pos_cursor"),
					require("statusline.empty"),
					require("statusline.git_branch"),
					require("statusline.git_diff"),
					require("statusline.diagnostics"),
					-- require("statusline.macro"),
					"%=",
					require("statusline.fileformat"),
					require("statusline.indentation"),
					require("statusline.filetype"),
					require("statusline.cwd"),
					require("statusline.path"),
				},
				disabled = {
					filetypes = require("user_configs").statusline_short_ft,
					buftypes = {
						"terminal",
					},
				},
			}
		end,
		config = function(_, opts)
			require("sttusline").setup(opts)
		end,
	},
	{
		-- Add a sidebar map
		"echasnovski/mini.map",
		lazy = true,
		keys = {
			{
				"<C-M>m",
				function()
					require("mini.map").toggle()
				end,
				desc = "Toggle code minimap",
			},
		},
		version = false,
		opts = function()
			local map_ok, map = pcall(require, "mini.map")
			if not map_ok then
				return
			end
			local git_integration = map.gen_integration.gitsigns({
				add = "GitSignsAdd",
				change = "GitSignsChange",
				delete = "GitSignsDelete",
			})
			local diagnostic_integration = map.gen_integration.diagnostic({
				error = "DiagnosticFloatingError",
				warn = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			})
			return {
				integrations = { diagnostic_integration, git_integration },
				symbols = {
					encode = map.gen_encode_symbols.dot("3x2"),
					scroll_line = "▓",
					scroll_view = "▒",
				},
				window = {
					focusable = false,
					side = "right",
					show_integration_count = false,
					width = 10,
					winblend = 25,
				},
			}
		end,
		config = function(_, opts)
			require("mini.map").setup(opts)
		end,
	},
	{
		-- Tabline and bufferline
		"romgrk/barbar.nvim",
		lazy = true,
		cond = require("user_configs").ui_features.tabline,
		event = "BufRead",
		keys = {
			{
				"<Left>",
				"<cmd>BufferPrevious",
				desc = "Buffer previous",
			},
			{
				"<Right>",
				"<cmd>BufferNext<cr>",
				desc = "Buffer next",
			},
			{
				"<leader><Left>",
				"<cmd>BufferMovePrevious<cr>",
				desc = "Move buffer backward",
			},
			{
				"<leader><Right>",
				"<cmd>BufferMoveNext<cr>",
				desc = "Move buffer forward",
			},
			{
				"<leader>`",
				"<cmd>BufferFirst<cr>",
				desc = "Buffer first",
			},
			{
				"<leader>-",
				"<cmd>BufferLast<cr>",
				desc = "Buffer last",
			},
			{
				"<leader>1",
				"<cmd>BufferGoto 1<cr>",
				desc = "Buffer 1",
			},
			{
				"<leader>2",
				"<cmd>BufferGoto 2<cr>",
				desc = "Buffer 2",
			},
			{
				"<leader>3",
				"<cmd>BufferGoto 3<cr>",
				desc = "Buffer 3",
			},
			{
				"<leader>4",
				"<cmd>BufferGoto 4<cr>",
				desc = "Buffer 4",
			},
			{
				"<leader>5",
				"<cmd>BufferGoto 5<cr>",
				desc = "Buffer 5",
			},
			{
				"<leader>6",
				"<cmd>BufferGoto 6<cr>",
				desc = "Buffer 6",
			},
			{
				"<leader>7",
				"<cmd>BufferGoto 7<cr>",
				desc = "Buffer 7",
			},
			{
				"<leader>8",
				"<cmd>BufferGoto 8<cr>",
				desc = "Buffer 8",
			},
			{
				"<leader>9",
				"<cmd>BufferGoto 9<cr>",
				desc = "Buffer 9",
			},
			{
				"<Up>",
				"<cmd>BufferPin<cr>",
				desc = "Buffer pin",
			},
			{
				"<Down>",
				"<cmd>BufferClose<cr>",
				desc = "Buffer close",
			},
			{
				"<leader>b",
				"<cmd>BufferPick<cr>",
				desc = "Pick buffer",
			},
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			auto_hide = false,
			tabpages = true,
			closable = true,
			clickable = true,
			focus_on_close = "left",
			hide = { extensions = false, inactive = false },
			highlight_inactive_file_icons = false,
			exclude_name = { "python", "[dap-repl]" },
			icons = {
				buffer_index = true,
				buffer_number = false,
				button = "⋄",
				gitsigns = {
					added = { enabled = false, icon = "+" },
					changed = { enabled = false, icon = "~" },
					deleted = { enabled = false, icon = "-" },
				},
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "*" },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = false },
				},
				filetype = {
					custom_colors = true,
					enabled = false,
				},
				separator = { left = ",", right = "" },
				modified = { button = "✦" },
				pinned = { button = "٭", filename = true },
				current = { buffer_index = true, filename = true },
				inactive = { filename = true },
			},
			insert_at_end = false,
			maximum_padding = 0,
			maximum_length = 30,
			semantic_letters = true,
			letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
			no_name_title = nil,
		},
	},
	{
		-- Add nice input dialogs to prompt
		"stevearc/dressing.nvim",
		lazy = true,
		event = "LspAttach",
		opts = {
			input = {
				insert_only = true,
				prompt_align = "left",
				start_in_insert = true,
				relative = "cursor",
				border = "single",
				prefer_width = 20,
				max_width = nil,
				min_width = 10,
				get_config = nil,
				win_options = {
					winblend = 0,
					winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder,FloatTitle:Pmenu",
				},
			},
			override = {
				anchor = "SW",
			},
			select = {
				backend = "fzf_lua",
				fzf_lua = {
					winopts = {
						height = 0.5,
						width = 0.5,
						preview = {
							hidden = "nohidden",
							vertical = "up:45%",
							layout = "vertical",
						},
					},
				},
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "CmdlineEnter" },
		opts = {
			progress = {
				suppress_on_insert = true,
				display = {
					render_limit = 3,
					done_icon = "✓",
				},
			},
			notification = {
				override_vim_notify = true,
			},
		},
	},
	{
		-- Colorcolumn smart functionality
		"fmbarina/multicolumn.nvim",
		lazy = true,
		priority = 10,
		event = "BufReadPre",
		opts = {
			sets = {
				lua = {
					rulers = { 80 },
					scope = "file",
				},
				default = {
					rulers = { 80 },
					full_column = true,
				},
				python = {
					scope = "window",
					rulers = { 80 },
					to_line_end = true,
				},
				starter = {
					rulers = { 9999 },
				},
				NeogitStatus = {
					rulers = { 9999 },
				},
				exclude_ft = { "help", "netrw", "starter", "man", "qf" },
			},
		},
	},
	{
		-- Show indent lines
		"shellRaining/hlchunk.nvim",
		lazy = true,
		cond = require("user_configs").ui_features.indent_lines,
		event = "LspAttach",
		opts = {
			indent = {
				exclude_filetypes = require("user_configs").indent_scope_disabled_ft,
			},
			blank = {
				enable = false,
			},
			line_num = {
				enable = false,
			},
			chunk = {
				enable = false,
			},
		},
	},
	{
		-- Highlight color blocks
		"brenoprata10/nvim-highlight-colors",
		lazy = true,
		event = { "BufRead" },
		cmd = { "HighlightColors" },
		keys = {
			{
				"<C-M>h",
				"<cmd>HighlightColors Toggle<cr>",
				desc = "Toggle highlighting colours",
			},
		},
		opts = {
			enable_named_colors = false,
		},
	},
	{
		-- Naively highlight word under cursor
		"echasnovski/mini.cursorword",
		lazy = true,
		event = "BufRead",
		cond = require("user_configs").ui_features.cursorword,
		init = function()
			_G.cursorword_blocklist = function()
				local curword = vim.fn.expand("<cword>")
				local filetype = vim.bo.filetype
				local blocklist = {}
				if filetype == "lua" then
					blocklist = { "local", "require", "true", "false", "--" }
				end
				vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
			end
			vim.cmd("au CursorMoved * lua _G.cursorword_blocklist()")
		end,
		opts = {},
		version = false,
	},
	{
		-- Folding customization using LSP and more
		"kevinhwang91/nvim-ufo",
		lazy = true,
		event = "VimEnter",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			open_fold_hl_timeout = 150,
			close_fold_kinds_ft = {
				default = { "imports", "comment" },
				json = { "array" },
			},
			preview = {
				win_config = {
					border = "single",
					winhighlight = "Pmenu:Normal",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			fold_virt_text_handler = require("utils.lsp").ufo_handler,
		},
	},
	{
		-- Cursorline mode decoration
		"mvllow/modes.nvim",
		cond = require("user_configs").ui_features.modes,
		lazy = true,
		event = "BufReadPre",
		opts = {
			set_number = false,
		},
	},
	{
		-- Tabs and buffer
		"tiagovla/scope.nvim",
		cond = require("user_configs").ui_features.scope,
		lazy = true,
		event = "BufRead",
		opts = {},
	},
	{
		-- Winbar/bufferline alternative
		"b0o/incline.nvim",
		lazy = true,
		event = "BufReadPost",
		opts = {
			hide = {
				cursorline = true,
			},
			window = {
				margin = {
					horizontal = 0,
					vertical = 0,
				},
			},
		},
	},
	{
		"otavioschwanck/arrow.nvim",
		lazy = true,
		keys = {
			{
				"<Bslash>",
				desc = "Quick bufferlist",
				mode = "n",
			},
		},
		opts = {
			separate_by_branch = true,
			window = {
				border = "single",
			},
			show_icons = false,
			leader_key = "<Bslash>",
		},
	},
}
