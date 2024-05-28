local augroup = require("core.utils").augroup
local cond = require("core.variables").ui_features

-- Plugins that modify UI
return {
	{
		-- Colorscheme building
		"rktjmp/shipwright.nvim",
		cmd = "Shipwright",
		dependencies = {
			"rktjmp/lush.nvim",
			-- Lush colorschemes to extend/modify
			"mstcl/dmg",
			"mstcl/ivory",
		},
	},
	{
		-- Add nice input dialogs to prompt
		"stevearc/dressing.nvim",
		init = function()
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
		-- Highlight color blocks
		"brenoprata10/nvim-highlight-colors",
		event = { "BufRead" },
		cmd = { "HighlightColors" },
		keys = {
			{
				"<C-M>hh",
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
		-- Tabline and bufferline
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
				vim.g.miniindentscope_disable = not cond.indent_lines
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
						"starter",
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
		config = function(_, opts)
			if opts then
				require("mini.animate").setup(opts)
				vim.g.minianimate_disable = not cond.animate
			end
		end,
	},
}
