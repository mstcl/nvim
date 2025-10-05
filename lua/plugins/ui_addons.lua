local augroup = require("core.utils").augroup
local conf = require("core.variables")
local condition = conf.ui_features

-- Plugins that modify UI
return {
	{ -- (shipwright.nvim & lush.nvim) Colorscheme building
		"rktjmp/shipwright.nvim",
		cmd = "Shipwright",
		dependencies = {
			"rktjmp/lush.nvim",
			-- Lush colorschemes to extend/modify
			"mstcl/ivory",
		},
	},
	{ -- (nvim-highlight-colors) Highlight color blocks
		"brenoprata10/nvim-highlight-colors",
		event = { "BufRead" },
		cmd = { "HighlightColors" },
		keys = {
			{
				"<leader>H",
				function()
					vim.cmd("HighlightColors Toggle")
				end,
				desc = "highlight toggle",
			},
		},
		opts = {
			render = "virtual",
			virtual_symbol = " ■",
			enable_named_colors = false,
			exclude_filetypes = { "Neogit*" },
			exclude_buftypes = { "nofile" },
		},
	},
	{ -- (mini.indentscope) Indent lines *
		"echasnovski/mini.indentscope",
		version = false,
		keys = {
			{
				"<leader>I",
				function()
					vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
				end,
				desc = "indentscope toggle",
			},
		},
		event = "BufReadPre",
		opts = {
			draw = {
				delay = 20,
			},
			mappings = {
				goto_top = "",
				goto_bottom = "",
			},
			symbol = "┃",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			if opts then
				opts.draw.animation = require("mini.indentscope").gen_animation.none()
				require("mini.indentscope").setup(opts)
				vim.g.miniindentscope_disable = not condition.indent_lines
			end
		end,
		init = function()
			augroup("indentLinesDisable", {
				{ "Filetype" },
				{
					pattern = {
						"fzf",
						"toggleterm",
						"ministarter",
						"gitsigns-*",
						"lazy",
						"Neogit*",
						"markdown",
						"Diffview*",
						"aerial",
						"qf",
						"mason",
						"NvimTree",
						"Overseer*",
					},
					desc = "Disable indentscope",
					callback = function()
						vim.b.miniindentscope_disable = true
					end,
				},
			})
		end,
	},
	{ -- (mini.notify) Show notifications (for cmdheight = 0)
		"echasnovski/mini.notify",
		version = false,
		lazy = false,
		keys = {
			{
				"<leader>N",
				function()
					require("mini.notify").clear()
				end,
				desc = "dismiss all notifications",
			},
		},
		opts = function()
			return {
				content = {
					format = function(notif)
						return " " .. "[" .. notif.level .. "]" .. " " .. notif.msg .. " "
					end,
				},
				lsp_progress = { enable = false },
				window = { max_width_share = 1, winblend = 0, config = { border = conf.border } },
			}
		end,
		config = function(_, opts)
			vim.api.nvim_set_hl(0, "MiniNotifyTitle", { link = "DiagnosticOk" })
			require("mini.notify").setup(opts)
			local vim_notify_opts = {
				ERROR = { duration = 5000, hl_group = "DiagnosticOk" },
				WARN = { duration = 5000, hl_group = "DiagnosticOk" },
				INFO = { duration = 2000, hl_group = "DiagnosticOk" },
				DEBUG = { duration = 0, hl_group = "DiagnosticOk" },
				TRACE = { duration = 0, hl_group = "DiagnosticOk" },
				OFF = { duration = 0, hl_group = "DiagnosticSignOk" },
			}
			vim.notify = require("mini.notify").make_notify(vim_notify_opts)
		end,
	},
	{ -- (visual-whitespace.nvim) Whitespace shows on visual selection
		"mcauley-penney/visual-whitespace.nvim",
		event = { "ModeChanged" },
		config = function(_, opts)
			local fg = vim.api.nvim_get_hl(0, { name = "Tabline" }).bg
			local bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "VisualNonText", {
				bg = string.format("#%06x", bg),
				fg = string.format("#%06x", fg),
			})
			if opts then
				require("visual-whitespace").setup(opts)
			end
		end,
	},
	{ -- (nvim-treesitter-context) Treesitter context in-buffer
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		opts = {},
	},
	{ -- (tiny-glimmer.nvim) Cute animations
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		priority = 10,
		opts = {
			overwrite = {
				undo = { enabled = true },
				redo = { enabled = true },
			},
		},
	},
}
