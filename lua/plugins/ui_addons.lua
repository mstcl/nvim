local augroup = require("utils.misc").augroup
-- Plugins that modify UI
return {
	{
		-- Colorscheme
		"mstcl/dmg",
		lazy = false,
		priority = 1000,
		dependencies = {
			"rktjmp/lush.nvim",
		},
		config = function()
			vim.cmd.colorscheme("dmg_extended")
		end,
	},
	{
		-- Add a sidebar map
		"echasnovski/mini.map",
		keys = {
			{
				"<C-M>m",
				function()
					require("mini.map").toggle()
					vim.notify("Toggled mini map", vim.log.levels.INFO)
				end,
				desc = "Toggle code minimap",
			},
		},
		version = false,
		opts = function()
			local map = require("mini.map")
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
			if opts then
				require("mini.map").setup(opts)
			end
		end,
	},
	{
		-- Add nice input dialogs to prompt
		"stevearc/dressing.nvim",
		init = function()
			local lush = require("lush")
			lush(lush.extends({ require("dmg") }).with(require("dmg_dressing")))
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
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
		-- Colorcolumn smart functionality
		"fmbarina/multicolumn.nvim",
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
		-- Highlight color blocks
		"brenoprata10/nvim-highlight-colors",
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
		event = "BufRead",
		cond = require("user_configs").ui_features.cursorword,
		keys = {
			{
				"<C-M>w",
				function()
					vim.g.minicursorword_disable = not vim.g.minicursorword_disable
					if vim.g.minicursorword_disable then
						vim.notify("Disabled cursorword", vim.log.levels.INFO)
					else
						vim.notify("Enabled cursorword", vim.log.levels.INFO)
					end
				end,
				desc = "Toggle cursorword",
			},
		},
		init = function()
			vim.cmd("autocmd Filetype markdown,tex,quarto lua vim.b.minicursorword_disable = true")
		end,
		opts = {},
		version = false,
	},
	{
		-- Folding customization using LSP and more
		"kevinhwang91/nvim-ufo",
		event = "VimEnter",
		dependencies = { "kevinhwang91/promise-async" },
		keys = {
			{
				"<C-K>",
				"<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<cr>",
				desc = "Peek fold",
			},
		},
		init = function()
			---@diagnostic disable-next-line: inject-field
			vim.o.foldcolumn = "1" -- '0' is not bad
			---@diagnostic disable-next-line: inject-field
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			---@diagnostic disable-next-line: inject-field
			vim.o.foldlevelstart = 99
			---@diagnostic disable-next-line: inject-field
			vim.o.foldenable = true
		end,
		opts = function()
			---Set nvim-ufo truncate text
			---@return string
			local function ufo_handler(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "DiffChange" })
				return newVirtText
			end
			return {
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
				fold_virt_text_handler = ufo_handler,
			}
		end,
		config = function(_, opts)
			if opts then
				require("ufo").setup(opts)
			end
		end,
	},
	{
		-- Cursorline mode decoration
		"mvllow/modes.nvim",
		cond = require("user_configs").ui_features.modes,
		event = "BufReadPre",
		opts = {
			set_number = false,
		},
	},
	{
		-- Tabs and buffer
		"tiagovla/scope.nvim",
		cond = require("user_configs").ui_features.scope,
		event = "BufRead",
		opts = {},
	},
	{
		-- Winbar/bufferline alternative
		"b0o/incline.nvim",
		event = "BufReadPost",
		opts = {
			hide = {
				only_win = true,
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
		-- Switch between buffers, the minimal way
		"ernstwi/juggler.nvim",
		opts = {
			highlight_group_active = "Question", -- The selected buffer.
			highlight_group_inactive = "StatuslineAlt", -- All other buffers.
			highlight_group_separator = "Whitespace", -- The `|` between buffers.
		},
		keys = {
			{
				"<leader>j",
				function()
					require("juggler").activate()
				end,
				desc = "Juggler buffers",
			},
		},
		dependencies = {
			"nvimtools/hydra.nvim",
		},
	},
	{
		-- Code runner
		"stevearc/overseer.nvim",
		keys = {
			{
				"<C-M>o",
				function()
					vim.cmd("OverseerToggle")
					vim.notify("Toggled overseer", vim.log.levels.INFO)
				end,
				desc = "Toggle Overseer",
			},
			{
				"<leader>m",
				"<cmd>OverseerRun<cr>",
				desc = "Run tasks",
			},
		},
		opts = {
			form = {
				border = "single",
				win_opts = {
					winblend = 0,
				},
			},
			confirm = {
				border = "single",
				win_opts = {
					winblend = 0,
				},
			},
			task_win = {
				border = "single",
				win_opts = {
					winblend = 0,
				},
			},
			help_win = {
				border = "single",
				win_opts = {
					winblend = 0,
				},
			},
		},
	},
	{
		-- Search and replace
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar" },
		opts = {
			disableBufferLineNumbers = true,
			resultsSeparatorLineChar = "─",
			spinnerStates = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
			icons = {
				enabled = false,
			},
		},
	},
	{
		-- Tabline and bufferline
		"echasnovski/mini.tabline",
		version = false,

		opts = {
			show_icons = false,
		},
		cond = require("user_configs").ui_features.tabline,
		init = function(_, opts)
			augroup("loadTabline", {
				{ "BufReadPre" },
				{
					pattern = "*",
					desc = "Lazy load tabline",
					callback = function()
						if vim.bo.filetype ~= "starter" and vim.o.showtabline == 0 then
							vim.o.showtabline = 2
							require("mini.tabline").setup(opts)
							vim.api.nvim_set_hl(0, "MiniTablineFill", { link = "TablineFill" })
						end
					end,
				},
			})
		end,
	},
	{
		-- Indent lines
		"echasnovski/mini.indentscope",
		version = false,
		keys = {
			{
				"<C-M>i",
				function()
					vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
					if vim.g.miniindentscope_disable then
						vim.notify("Disabled indent scope", vim.log.levels.INFO)
					else
						vim.notify("Enabled indent scope", vim.log.levels.INFO)
					end
				end,
				desc = "Toggle indentscope",
			},
		},
		event = "BufReadPre",
		opts = {
			draw = {
				delay = 50,
			},
			mappings = {
				goto_top = "",
				goto_bottom = "",
			},
			symbol = "│",
		},
		cond = require("user_configs").ui_features.indent_lines,
		init = function()
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
		end,
	},
	{
		-- Show notifications (for cmdheight = 0)
		"echasnovski/mini.notify",
		version = false,
		keys = {
			{
				"<C-BS>",
				function()
					require("mini.notify").clear()
				end,
				desc = "Dismiss all notifications",
			},
		},
		opts = {
			content = {
				format = function(notif)
					return " " .. notif.msg .. " "
				end,
			},
			lsp_progress = {
				enable = false,
			},
			window = {
				config = {
					border = "none",
				},
			},
		},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.notify = function(...)
				if not require("lazy.core.config").plugins["mini.notify"]._.loaded then
					require("lazy").load({ plugins = "mini.notify" })
				end
				require("mini.notify").make_notify()(...)
			end
		end,
	},
	{
		-- Animations
		"echasnovski/mini.animate",
		event = "CursorMoved",
		keys = {
			{
				"<C-M>a",
				function()
					vim.g.minianimate_disable = not vim.g.minianimate_disable
					if vim.g.minianimate_disable then
						vim.notify("Disabled animation", vim.log.levels.INFO)
					else
						vim.notify("Enabled animation", vim.log.levels.INFO)
					end
				end,
				desc = "Toggle animate",
			},
		},
		opts = function()
			-- don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				cursor = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				resize = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
			}
		end,
	},
}
