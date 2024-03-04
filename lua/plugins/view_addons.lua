-- Plugins which add additional ways to use nvim
return {
	{
		-- Terminal panel
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = "ToggleTerm",
		config = function()
			local term_ok, toggleterm = pcall(require, "toggleterm")
			if not term_ok then
				return
			end
			toggleterm.setup({
				winbar = {
					enabled = false,
				},
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				hide_numbers = true,
				shade_filetypes = {},
				autochdir = false,
				shade_terminals = false,
				shading_factor = "1",
				highlights = {
					Normal = {
						link = "Floaterm",
					},
					Statusline = {
						link = "Statusline",
					},
				},
				direction = "vertical",
			})
		end,
	},
	{
		-- Distraction-free editing mode
		"folke/zen-mode.nvim",
		lazy = true,
		dependencies = { "twilight.nvim", lazy = true, cmd = "Twilight" },
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 1,
				width = 90,
				options = {
					signcolumn = "yes",
					number = false,
					relativenumber = false,
					cursorline = false,
					cursorcolumn = false,
					foldcolumn = "0",
					list = false,
				},
			},
			plugins = {
				gitsigns = { enabled = true },
				kitty = {
					enabled = true,
					font = "+0",
				},
			},
		},
	},
	{
		-- Dim all but current paragraph object
		"folke/twilight.nvim",
		lazy = true,
		cmd = "Twilight",
		opts = {
			context = 5,
			exclude = {
				"markdown",
			},
		},
	},
	{
		-- Utility to align text by delimiters
		"echasnovski/mini.align",
		keys = {
			{ "ga", mode = "v" },
			{ "gA", mode = "v" },
		},
		version = false,
		lazy = true,
		opts = {},
	},
	{
		-- View git diff
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
		},
		opts = {},
	},
	{
		-- Buffer-like file browser
		"stevearc/oil.nvim",
		cmd = "Oil",
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.api.nvim_create_autocmd("BufWinEnter", {
				nested = true,
				callback = function(info)
					local path = info.file
					if path == "" then
						return
					end
					local stat = require("luv").fs_stat(path)
					if stat and stat.type == "directory" then
						vim.api.nvim_del_autocmd(info.id)
						require("oil")
						vim.cmd.edit({
							bang = true,
							mods = { keepjumps = true },
						})
						return true
					end
				end,
			})
		end,
		opts = {
			default_file_explorer = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>v"] = "actions.select_vsplit",
				["<C-s>h"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["q"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["<C-h>"] = "actions.toggle_hidden",
			},
			columns = {
				{
					"type",
					icons = {
						directory = "d",
						fifo = "p",
						file = "-",
						link = "l",
						socket = "s",
					},
				},
				{ "permissions" },
				{ "size", highlight = "Special" },
				{ "mtime", highlight = "Number" },
			},
			float = {
				padding = 4,
				border = "single",
			},
			preview = {
				border = "single",
			},
			progress = {
				border = "single",
			},
			win_options = {
				number = false,
				relativenumber = false,
				signcolumn = "no",
				foldcolumn = "0",
				statuscolumn = "",
			},
			cleanup_delay_ms = false,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
		},
	},
	{
		-- Keymapping cheatsheet
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			key_labels = {
				["<space>"] = "␣",
				["<cr>"] = "↵",
				["<tab>"] = "↹",
				["<Left>"] = "◀",
				["<Right>"] = "▶",
				["<Up>"] = "▲",
				["<Down>"] = "▼",
				["<leader>"] = ",",
				["<c-w>"] = "<C-W>",
			},
			ignore_missing = false,
			icons = {
				breadcrumb = "▸",
				separator = "⟫",
			},
			triggers_blacklist = {
				i = { "j", "k" },
				v = { "j", "k" },
				n = { "d", "y" },
			},
		},
	},
	{
		-- Minimalist start screen
		"echasnovski/mini.starter",
		cond = function()
			if vim.tbl_contains(vim.v.argv, "-R") then
				return false
			end
			return true
		end,
		priority = 100,
		version = false,
		config = function()
			local starter_ok, starter = pcall(require, "mini.starter")
			if not starter_ok then
				return
			end
			local org_agenda = function()
				require("orgmode").action("agenda.prompt")
			end
			local quick = function()
				return function()
					return {
						{ action = org_agenda, name = "Agenda", section = "Quick actions" },
						{ action = "Lazy check", name = "Fetch plugins", section = "Quick actions" },
					}
				end
			end
			local greetings = function()
				local hour = tonumber(vim.fn.strftime("%H"))
				-- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
				local part_id = math.floor((hour + 4) / 8) + 1
				local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
				local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

				return ("Good %s, %s."):format(day_part, username)
			end

			starter.setup({
				items = {
					starter.sections.recent_files(5, true, false),
					starter.sections.recent_files(3, false, false),
					quick(),
					starter.sections.builtin_actions(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				footer = "",
				header = require("user_configs").starter_ascii .. greetings(),
			})
		end,
	},
	{
		-- Multipurpose panel, mainly for navigation
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		init = function()
			require("utils.mappings.pickers")
		end,
		config = function()
			local telescope_ok, telescope = pcall(require, "telescope")
			if not telescope_ok then
				return
			end
			local flex_layout = require("utils.misc").telescope_flex_layout
			local picker_configs = require("utils.misc").telescope_picker_configs

			telescope.setup({
				defaults = {
					use_less = false,
					initial_mode = "insert",
					selection_strategy = "reset",
					mappings = {
						n = {
							["<C-p>"] = require("telescope.actions.layout").toggle_preview,
						},
					},
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim",
					},
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					prompt_prefix = " ➤ ",
					selection_caret = "  ",
					entry_prefix = "  ",
					results_title = "",
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
						vertical = {
							prompt_position = "top",
							mirror = false,
						},
						cursor = { prompt_position = "top" },
						center = { prompt_position = "top" },
						bottom_pane = { prompt_position = "top" },
					},
					path_display = { "truncate" },
					color_devicons = false,
					sorting_strategy = "ascending",
					winblend = 0,
				},
				pickers = {
					buffers = {
						layout_strategy = "center",
						sort_lastused = true,
						disable_devicons = true,
						previewer = false,
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
							},
							n = {
								["<c-d>"] = require("telescope.actions").delete_buffer,
							},
						},
					},
					find_files = {
						layout_strategy = "flex",
						disable_devicons = true,
						layout_config = flex_layout,
						find_command = require("user_configs").telescope_find_ignore,
					},
					oldfiles = picker_configs,
					colorscheme = picker_configs,
					highlights = picker_configs,
					live_grep = picker_configs,
					git_commits = picker_configs,
					git_bcommits = picker_configs,
					git_branches = picker_configs,
					git_status = {
						layout_strategy = "flex",
						layout_config = flex_layout,
						disable_devicons = true,
						git_icons = {
							added = "+",
							changed = "~",
							copied = ">",
							deleted = "-",
							renamed = "⇒",
							unmerged = "‡",
							untracked = "?",
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					undo = {
						use_delta = true,
						side_by_side = true,
						layout_strategy = "flex",
						layout_config = flex_layout,
					},
					zoxide = {
						prompt_title = "Zoxide",
					},
					frecency = {
						auto_validate = false,
						use_sqlite = false,
						layout_strategy = "flex",
						layout_config = flex_layout,
						disable_devicons = true,
						show_unindexed = true,
						show_scores = true,
						workspaces = require("user_configs").frecency_workspaces,
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("zoxide")
			telescope.load_extension("frecency")
			telescope.load_extension("undo")
			if require("user_configs").dap_enabled then
				telescope.load_extension("dap")
			end
			telescope.load_extension("lazy")
			telescope.load_extension("noice")
			if require("user_configs").lsp_enabled then
				telescope.load_extension("aerial")
			end
		end,
		dependencies = {
			{
				"nvim-telescope/telescope-dap.nvim",
				cond = require("user_configs").dap_enabled,
				lazy = true,
				event = "VeryLazy",
			},
			{ "tsakirist/telescope-lazy.nvim", lazy = true, event = "VeryLazy" },
			{ "debugloop/telescope-undo.nvim", lazy = true, event = "VeryLazy" },
			{ "nvim-lua/plenary.nvim", lazy = true, event = "VeryLazy" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = true,
				event = "VeryLazy",
			},
			{ "jvgrootveld/telescope-zoxide", lazy = true, event = "VeryLazy" },
			{
				"rudism/telescope-dict.nvim",
				ft = { "markdown", "tex" },
			},
			{
				"nvim-telescope/telescope-frecency.nvim",
				lazy = true,
				event = "VeryLazy",
			},
		},
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		dependencies = {
			{ "nvim-telescope/telescope.nvim", lazy = true, cmd = "Telescope" },
		},
		opts = {
			commit_editor = {
				kind = "vsplit",
			},
			signs = {
				hunk = { "", "" },
				item = { "▸", "▾" },
				section = { "▸", "▾" },
			},
		},
	},
	{
		-- Tips on launch
		"TobinPalmer/Tip.nvim",
		lazy = true,
		cond = require("user_configs").func_features.tip,
		event = "VimEnter",
		init = function()
			-- Default config
			--- @type Tip.config
			require("tip").setup({
				title = "Tip!",
				url = "https://vtip.43z.one",
			})
		end,
	},
	{
		-- Discard inactive buffers
		"chrisgrieser/nvim-early-retirement",
		lazy = true,
		event = "VeryLazy",
		opts = {
			notificationOnAutoClose = true,
		},
	},
	{
		-- Disable features on big files
		"pteroctopus/faster.nvim",
	},
}
