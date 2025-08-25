local augroup = require("core.utils").augroup
local condition = require("core.variables").ui_features
local big = require("core.utils").big

-- Plugins that modify UI
return {
	{ -- (shipwright.nvim & lush.nvim) Colorscheme building
		"rktjmp/shipwright.nvim",
		cmd = "Shipwright",
		dependencies = {
			"rktjmp/lush.nvim",
			-- Lush colorschemes to extend/modify
			"mstcl/dmg",
			"mstcl/ivory",
		},
	},
	{ -- (nvim-highlight-colors) Highlight color blocks
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
			render = "virtual",
			virtual_symbol = " ■",
			enable_named_colors = false,
		},
	},
	{ -- (incline.nvim) Winbar/bufferline alternative *
		"b0o/incline.nvim",
		cond = condition.incline,
		event = "BufReadPost",
		opts = {
			hide = {
				only_win = true,
				cursorline = true,
			},
			window = {
				zindex = 20,
				margin = {
					horizontal = 0,
					vertical = 0,
				},
			},
		},
	},
	{ -- (mini.tabline) Tabline and bufferline *
		"echasnovski/mini.tabline",
		version = false,

		opts = {
			show_icons = false,
		},
		cond = require("core.variables").ui_features.tabline,
		init = function(_, opts)
			augroup("loadTabline", {
				{ "BufReadPre" },
				{
					pattern = "*",
					desc = "Lazy load tabline",
					callback = function()
						if vim.bo.filetype ~= "ministarter" and vim.o.showtabline == 0 then
							vim.o.showtabline = 2
							require("mini.tabline").setup(opts)
							vim.api.nvim_set_hl(0, "MiniTablineFill", { link = "TablineFill" })
						end
					end,
				},
			})
		end,
	},
	{ -- (mini.indentscope) Indent lines *
		"echasnovski/mini.indentscope",
		version = false,
		keys = {
			{
				"<C-M>ii",
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
			symbol = "┃",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			if opts then
				require("mini.indentscope").setup(opts)
				vim.g.miniindentscope_disable = not condition.indent_lines
			end
		end,
		init = function()
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
			augroup("indentLinesDisable", {
				{ "Filetype" },
				{
					pattern = {
						"fzf",
						"toggleterm",
						"ministarter",
						"lazy",
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
	{ -- (mini.animate) Animations *
		"echasnovski/mini.animate",
		keys = {
			{
				"<C-M>aa",
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
			{ "gg" },
			{ "G" },
			{ "H" },
			{ "L" },
			{ "M" },
			{ "<C-D>" },
			{ "<C-U>" },
			{ "<C-F>" },
			{ "<C-P>" },
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
					timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
				},
				resize = {
					timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
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
		config = function(_, opts)
			if opts then
				require("mini.animate").setup(opts)
				vim.g.minianimate_disable = not condition.animate
			end
		end,
	},
	{ -- (mini.starter) Minimalist start screen *
		"echasnovski/mini.starter",
		init = function()
			vim.o.laststatus = 0
		end,
		cond = function()
			if condition.starter then
				if vim.tbl_contains(vim.v.argv, "-R") then
					return false
				end
				return true
			else
				return false
			end
		end,
		priority = 100,
		version = false,
		opts = function()
			local starter = require("mini.starter")
			local quick = function()
				return function()
					local quick_tbl = {
						{ action = "Lazy show", name = "Plugins", section = "Quick actions" },
					}
					if require("core.variables").syntax_features.org then
						local org_agenda = function()
							require("orgmode").action("agenda.prompt")
						end
						table.insert(quick_tbl, { action = org_agenda, name = "Agenda", section = "Quick actions" })
					end
					return quick_tbl
				end
			end
			local greetings = function()
				local hour = tonumber(vim.fn.strftime("%H"))
				-- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
				local part_id = math.floor((hour + 4) / 8) + 1
				local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
				---@diagnostic disable-next-line: undefined-field
				local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

				return ("Good %s, %s."):format(day_part, username)
			end
			return {
				items = {
					starter.sections.recent_files(3, true, false),
					starter.sections.recent_files(3, false, false),
					starter.sections.sessions(8),
					quick(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				footer = "",
				header = require("core.variables").starter_ascii .. greetings(),
			}
		end,
		config = function(_, opts)
			if opts then
				require("mini.starter").setup(opts)
			end
		end,
	},
	{ -- (visual-whitespace.nvim) Whitespace shows on visual selection
		"mcauley-penney/visual-whitespace.nvim",
		event = { "ModeChanged" },
		config = function(_, opts)
			local fg = vim.api.nvim_get_hl(0, { name = "NonText" }).fg
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
