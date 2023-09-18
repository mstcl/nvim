local present, telescope = pcall(require, "telescope")
if not present then
	return
end

local flex_layout = {
	horizontal = {
		prompt_position = "top",
		preview_width = 0.55,
	},
	vertical = {
		prompt_position = "top",
		mirror = false,
	},
	cursor = { prompt_position = "top" },
	center = { prompt_position = "top" },
	bottom_pane = { prompt_position = "top" },
	width = 0.87,
	height = 0.80,
	flip_lines = 55,
	flip_columns = 150,
}

telescope.setup({
	defaults = {
		use_less = false,
		initial_mode = "insert",
		selection_strategy = "reset",
		mappings = {
			n = {
				["<C-P>"] = require("telescope.actions.layout").toggle_preview,
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
			find_command = {
				"fd",
				"--type",
				"file",
				"--strip-cwd-prefix",
				"--follow",
				"--exclude",
				"*.png*",
				"--exclude",
				"*.PNG",
				"--exclude",
				"*.pdf",
				"--exclude",
				"*.jpeg",
				"--exclude",
				"*.jpg",
				"--exclude",
				"*.svg",
				"--exclude",
				"*.pm",
				"--exclude",
				"pictures",
			},
		},
		oldfiles = {
			layout_strategy = "flex",
			disable_devicons = true,
			layout_config = flex_layout,
			previewer = false,
		},
		colorscheme = {
			layout_strategy = "flex",
			layout_config = flex_layout,
			previewer = false,
		},
		highlights = {
			layout_strategy = "flex",
			layout_config = flex_layout,
		},
		live_grep = {
			layout_strategy = "flex",
			disable_devicons = true,
			layout_config = flex_layout,
		},
		git_commits = {
			layout_strategy = "flex",
			layout_config = flex_layout,
		},
		git_bcommits = {
			layout_strategy = "flex",
			layout_config = flex_layout,
		},
		git_branches = {
			layout_strategy = "flex",
			layout_config = flex_layout,
		},
		git_status = {
			layout_strategy = "flex",
			disable_devicons = true,
			layout_config = flex_layout,
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
		file_browser = {
			layout_strategy = "flex",
			disable_devicons = true,
			layout_config = flex_layout,
			dir_icon = "",
			git_status = true,
			respect_gitignore = false,
			initial_mode = "normal",
			hijack_netrw = false,
			auto_depth = true,
			hidden = true,
			cwd_to_path = true,
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
			workspaces = {
				["conf"] = "/home/lckdscl/.config",
				["scripts"] = "/home/lckdscl/scripts",
				["dot"] = "/home/lckdscl/dotfiles",
				["zsh"] = "/home/lckdscl/.config/zsh",
				["nvim"] = "/home/lckdscl/.config/nvim",
				["projects"] = "/home/lckdscl/projects",
				["go"] = "/home/lckdscl/projects/go",
				["bimbox"] = "/home/lckdscl/bimbox",
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("file_browser")
telescope.load_extension("frecency")
telescope.load_extension("undo")
telescope.load_extension("dap")
telescope.load_extension("lazy")
telescope.load_extension("ui-select")
