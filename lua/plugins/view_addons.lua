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
			local Terminal = require("toggleterm.terminal").Terminal

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
				},
				direction = "vertical",
			})
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "single",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
			})
			function _lazygit_toggle()
				lazygit:toggle()
			end
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
		event = "VeryLazy",
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
				"permissions",
				"size",
			},
			delete_to_trash = true,
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
			ignore_missing = true,
			icons = {
				breadcrumb = "▸",
				separator = "⟫",
			},
			triggers_blacklist = {
				i = { "j", "k" },
				v = { "j", "k" },
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
			local plugins_gen = io.popen('echo "$(find ~/.local/share/nvim/lazy -maxdepth 1 -type d | wc -l) - 1" | bc')
			local plugins = plugins_gen:read("*a")
			plugins_gen:close()
			local org_agenda = function()
				require("orgmode").action("agenda.prompt")
			end
			local telescope = function()
				return function()
					return {
						{ action = org_agenda, name = "Agenda",      section = "Quick actions" },
						{ action = "WhichKey", name = "Keymappings", section = "Quick actions" },
					}
				end
			end
			local plugin_actions = function()
				return function()
					return {
						{ action = "Lazy show",   name = "Overview", section = "Plugins" },
						{ action = "Lazy check",  name = "Fetch",    section = "Plugins" },
						{ action = "Lazy update", name = "Update",   section = "Plugins" },
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
					telescope(),
					plugin_actions(),
					starter.sections.builtin_actions(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				footer = "Total number of plugins: " .. plugins,
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
					["ui-select"] = {
						layout_strategy = "center",
					},
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
			telescope.load_extension("dap")
			telescope.load_extension("lazy")
			telescope.load_extension("ui-select")
			telescope.load_extension("aerial")
		end,
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"tsakirist/telescope-lazy.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"jvgrootveld/telescope-zoxide",
			{
				"rudism/telescope-dict.nvim",
				ft = { "markdown", "tex" },
			},
			{
				"nvim-telescope/telescope-frecency.nvim",
				commit = "fbda5d91d6e787f5977787fa4a81da5c8e22160a",
			},
		},
	},
}
