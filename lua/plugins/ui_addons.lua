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
		event = "BufRead",
		config = function()
			require("sttusline").setup({
				statusline_color = "StatusLine",
				laststatus = 3,
				components = require("utils.statusline").components,
				disabled = {
					filetypes = require("user_configs").statusline_short_ft,
					buftypes = {
						"terminal",
					},
				},
			})
		end,
	},
	{
		-- Add a sidebar map
		"echasnovski/mini.map",
		lazy = true,
		keys = {
			{ "<C-M>m", mode = "n" },
		},
		version = false,
		config = function()
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
			map.setup({
				integrations = { diagnostic_integration, git_integration },
				symbols = {
					encode = map.gen_encode_symbols.dot("3x2"),
					scroll_line = "▓",
					scroll_view = "▒",
				},
				-- Window options
				window = {
					focusable = false,
					side = "right",
					show_integration_count = false,
					width = 10,
					winblend = 25,
				},
			})
			require("which-key").register({
				["<C-M>m"] = { require("mini.map").toggle, "Toggle code minimap" },
			})
		end,
	},
	{
		-- Tabline and bufferline
		"romgrk/barbar.nvim",
		lazy = true,
		cond = require("user_configs").ui_features.tabline,
		event = "BufRead",
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
				-- enabled = false,
				backend = "builtin",
				builtin = {
					border = "single",
					win_options = {
						cursorline = false,
						cursorlineopt = "number",
						winblend = 0,
						winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder,FloatTitle:Pmenu",
					},
				},
			},
		},
	},
	{
		-- Revamped UI (notification etc.)
		"folke/noice.nvim",
		event = "VeryLazy",
		lazy = true,
		dependencies = {
			{ "MunifTanjim/nui.nvim", lazy = true, event = "VeryLazy" },
		},
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			messages = {
				view_search = "virtualtext",
			},
			views = {
				notify = {
					border = {
						style = "none",
					},
				},
				mini = {
					win_options = {
						winblend = 40,
					},
					position = {
						row = -1,
					},
					border = {
						style = "none",
					},
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "lua_error",
						find = "UfoFallbackException",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "notify",
						kind = "info",
						find = "hlchunk",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "[w]",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "ago",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "notify",
						kind = "info",
						find = "available",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "yanked",
					},
					opts = { skip = true },
				},
				{
					view = "split",
					filter = { event = "msg_show", min_height = 20 },
				},
			},
			cmdline = {
				enabled = true,
				view = "cmdline",
				format = {
					cmdline = {
						icon = ":",
					},
					search_up = {
						icon = "/",
					},
					search_down = {
						icon = "/",
					},
					filter = {
						icon = "*",
					},
					help = {
						icon = "?",
					},
					lua = {
						icon = "@",
					},
				},
			},
			format = {
				level = {
					icons = {
						error = "✗",
						info = "i",
						warn = "!",
					},
				},
			},
		},
	},
	{
		-- Colorcolumn smart functionality
		"fmbarina/multicolumn.nvim",
		lazy = true,
		priority = 10,
		event = "VeryLazy",
		opts = {
			sets = {
				lua = {
					rulers = { 88 },
					scope = "file",
				},
				default = {
					rulers = { 88 },
					full_column = true,
				},
				python = {
					scope = "window",
					rulers = { 88 },
					to_line_end = true,
				},
				starter = {
					rulers = { 9999 },
				},
				NeogitStatus = {
					rulers = { 9999 },
				},
				exclude_ft = { "markdown", "help", "netrw", "starter", "man" },
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
		event = { "BufNew", "BufRead" },
		cmd = { "HighlightColors" },
		opts = {
			enable_named_colors = false,
		}
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
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async", lazy = true, event = "VeryLazy" },
		opts = {
			open_fold_hl_timeout = 150,
			close_fold_kinds = { "imports", "comment" },
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
			provider_selector = function(_, filetype, buftype)
				local function handleFallbackException(bufnr, err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(bufnr, providerName)
					else
						return require("promise").reject(err)
					end
				end
				return (filetype == "" or buftype == "nofile") and "indent"
					or function(bufnr)
						return require("ufo")
							.getFolds(bufnr, "lsp")
							:catch(function(err)
								return handleFallbackException(bufnr, err, "treesitter")
							end)
							:catch(function(err)
								return handleFallbackException(bufnr, err, "indent")
							end)
					end
			end,
		},
	},
	{
		-- Cursorline mode decoration
		"mvllow/modes.nvim",
		cond = require("user_configs").ui_features.modes,
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
		event = "VeryLazy",
		opts = {
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
			{ ";", mode = "n" },
		},
		opts = {
			separate_by_branch = true,
			window = {
				border = 'single',
			},
			show_icons = false,
			leader_key = ";",
		},
	},
}
