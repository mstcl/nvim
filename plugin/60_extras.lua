local _plugin_path = vim.fn.stdpath("data") .. "/site/pack/deps/opt"

-- (nvim-web-devicons) Icons
MiniDeps.now(function() MiniDeps.add("nvim-tree/nvim-web-devicons") end)

-- Colorschemes
MiniDeps.now(function()
	MiniDeps.add("rktjmp/lush.nvim")
	MiniDeps.add("mstcl/tavern.nvim")
	MiniDeps.add("mstcl/ivory.nvim")
end)

MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.files")

	require("mini.files").setup({
		options = {
			permanent_delete = false,
			use_as_default_explorer = true,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>e",
		function() require("mini.files").open() end,
		{ desc = "Explorer (mini)", noremap = false, silent = true }
	)
end)

-- (mini.notify) Popup notifications
MiniDeps.now(function()
	MiniDeps.add("nvim-mini/mini.notify")

	require("mini.notify").setup({
		content = {
			format = function(notif)
				return " " .. "[" .. notif.level .. "]" .. " " .. notif.msg .. " "
			end,
		},
		lsp_progress = { enable = false },
		window = {
			max_width_share = 1,
			winblend = 0,
			config = { border = _G.config.border },
		},
	})

	local vim_notify_opts = {
		ERROR = { duration = 5000, hl_group = "DiagnosticOk" },
		WARN = { duration = 5000, hl_group = "DiagnosticOk" },
		INFO = { duration = 2000, hl_group = "DiagnosticOk" },
		DEBUG = { duration = 0, hl_group = "DiagnosticOk" },
		TRACE = { duration = 0, hl_group = "DiagnosticOk" },
		OFF = { duration = 0, hl_group = "DiagnosticSignOk" },
	}

	vim.notify = require("mini.notify").make_notify(vim_notify_opts)

	vim.keymap.set(
		"n",
		"<leader>N",
		function() require("mini.notify").show_history() end,
		{ desc = "Notification history", noremap = false, silent = true }
	)
end)

-- (mini.clue) Mapping helper
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.clue")

	require("mini.clue").setup({
		window = {
			delay = 200,
			config = {
				width = 50,
			},
		},

		triggers = {
			-- leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },

			-- brackets
			{ mode = "n", keys = "]" },
			{ mode = "n", keys = "[" },
			{ mode = "x", keys = "[" },
			{ mode = "x", keys = "]" },

			-- conflict
			{ mode = "n", keys = "c" },
		},

		clues = {
			require("mini.clue").gen_clues.g(),
			require("mini.clue").gen_clues.marks(),
			require("mini.clue").gen_clues.registers(),
			require("mini.clue").gen_clues.square_brackets(),
			require("mini.clue").gen_clues.z(),
			require("mini.clue").gen_clues.windows({ submode_resize = true }),

			{ mode = "n", keys = "<leader>g", desc = "Git [+]" },
			{ mode = "n", keys = "<leader>G", desc = "Hunks [+]" },
			{ mode = "n", keys = "<leader>t", desc = "Tab [+]" },
			{ mode = "n", keys = "<leader>p", desc = "Pair Mode [+]" },
			{ mode = "n", keys = "<leader>w", desc = "Workspace [+]" },
			{ mode = "n", keys = "<leader>d", desc = "Diff [+]" },
			{ mode = "n", keys = "<leader>D", desc = "Document [+]" },
			{ mode = "n", keys = "<leader>n", desc = "Notes [+]" },
			{ mode = "n", keys = "gs", desc = "Surround [+]" },
			{ mode = "x", keys = "gs", desc = "Surround [+]" },
			{ mode = "n", keys = "gr", desc = "Symbol [+]" },
			{ mode = "x", keys = "gr", desc = "Symbol [+]" },
			{ mode = "x", keys = "c", desc = "Conflicts [+]" },
		},
	})
end)

-- (mini.align) Utility to align text by delimiters
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.align")

	require("mini.align").setup()
end)

-- (mini.jump) Super f/F/t/T
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.jump")

	require("mini.jump").setup()
end)

-- (mini.move) Move lines in visual
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.move")

	require("mini.move").setup()
end)

-- (mini.bracketed) Bracketed motions for prev and next
MiniDeps.later(function()
	MiniDeps.add("echasnovski/mini.bracketed")
	require("mini.bracketed").setup({
		buffer = { suffix = "" },
		diagnostic = { suffix = "" },
		conflict = { suffix = "" },
		file = { suffix = "" },
		indent = { suffix = "" },
		undo = { suffix = "" },
		window = { suffix = "" },
		yank = { suffix = "" },
		treesitter = { suffix = "" },
		oldfile = { suffix = "" },
		comment = { suffix = "" },
	})
end)

-- (mini.indentscope) Indent lines
MiniDeps.later(function()
	local indentscope_disable_filetypes = {
		"fzf",
		"toggleterm",
		"ministarter",
		"gitsigns-*",
		"help",
		"lazy",
		"Neogit*",
		"markdown",
		"Diffview*",
		"vscode-diff-*",
		"aerial",
		"qf",
		"mason",
		"NvimTree",
		"Overseer*",
	}

	MiniDeps.add("nvim-mini/mini.indentscope")

	_G.augroup("mini_indentscope", {
		{ "Filetype" },
		{
			pattern = indentscope_disable_filetypes,
			desc = "disable indentscope",
			callback = function() vim.b.miniindentscope_disable = true end,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>I",
		function() vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable end,
		{ desc = "Indentscope (toggle)", noremap = false, silent = true }
	)

	require("mini.indentscope").setup({
		draw = {
			delay = 0,
			animation = require("mini.indentscope").gen_animation.none(),
		},
		symbol = "┃",
		options = { try_as_border = true },
	})
end)

-- (mini.keymap) Supercharged keymapping
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.keymap")

	require("mini.keymap").setup()

	local tab_steps = {
		"increase_indent",
		"blink_next",
		"vimsnippet_next",
		"jump_after_tsnode",
		"jump_after_close",
	}

	local stab_steps = {
		"decrease_indent",
		"blink_prev",
		"vimsnippet_prev",
		"jump_before_tsnode",
		"jump_before_open",
	}

	local cr_steps = {
		"blink_accept",
		"minipairs_cr",
	}

	local bs_steps = {
		"minipairs_bs",
	}

	-- super tab/shift-tab/enter
	require("mini.keymap").map_multistep("i", "<Tab>", tab_steps)
	require("mini.keymap").map_multistep("i", "<S-Tab>", stab_steps)
	require("mini.keymap").map_multistep("i", "<CR>", cr_steps)
	require("mini.keymap").map_multistep("i", "<BS>", bs_steps)

	-- escape
	require("mini.keymap").map_combo({ "i", "c", "x", "s" }, "jk", "<BS><BS><Esc>")
	require("mini.keymap").map_combo({ "i", "c", "x", "s" }, "kj", "<BS><BS><Esc>")

	require("mini.keymap").map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
	require("mini.keymap").map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

	-- fix spelling
	require("mini.keymap").map_combo("i", "kk", "<BS><BS><Esc>[s1z=gi<Right>")
end)

-- (mini.pairs) Auto pairs
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.pairs")

	vim.keymap.set(
		"n",
		"<leader>A",
		function() vim.g.minipairs_disable = not vim.g.minipairs_disable end,
		{ desc = "Autopairs (toggle)", noremap = false, silent = true }
	)

	require("mini.pairs").setup({
		modes = { insert = true, command = true, terminal = false },
		mappings = {
			["`"] = {
				action = "closeopen",
				pair = "``",
				neigh_pattern = "[^\\`].",
				register = { cr = false },
			},
		},
	})
end)

-- (mini.surround) Add motions to surround objects with brackets etc.
MiniDeps.later(function()
	MiniDeps.add("nvim-mini/mini.surround")

	require("mini.surround").setup({
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "gsr",
			update_n_lines = "gsn",
		},
	})
end)

-- (remember.nvim) Remember last place
MiniDeps.now(function()
	MiniDeps.add("vladdoster/remember.nvim")

	require("remember")
end)

-- (oil.nvim) Buffer-like file browser
_G.now_if_args(function()
	MiniDeps.add({
		source = "stevearc/oil.nvim",
		depends = { "nvim-tree/nvim-web-devicons" },
	})

	_G.augroup("oil", {
		"BufWinEnter",
		{
			nested = true,
			desc = "start oil when opened with dir arg",
			callback = function(info)
				local path = info.file
				if path == "" then return end
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
		},
	})

	local detail = false
	local oil_columns = {
		types = {
			"type",
			icons = {
				directory = "+",
				fifo = "p",
				file = "·",
				link = "l",
				socket = "s",
			},
			highlight = "Special",
		},
		icon = { "icon" },
		permissions = { "permissions", highlight = "Number" },
	}

	require("oil").setup({
		default_file_explorer = true,
		experimental_watch_for_changes = true,
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
			["gd"] = {
				desc = "Toggle file detail view",
				callback = function()
					detail = not detail
					if detail then
						require("oil").set_columns({
							oil_columns.types,
							oil_columns.permissions,
							oil_columns.icon,
						})
					else
						require("oil").set_columns({ oil_columns.icon })
					end
				end,
			},
		},
		columns = { oil_columns.icon },
		float = {
			padding = 2,
			border = _G.config.border,
			max_width = math.floor(vim.api.nvim_win_get_width(0) * 0.7),
			max_height = math.floor(vim.api.nvim_win_get_height(0) * 0.6),
		},
		preview = { border = _G.config.border },
		progress = { border = _G.config.border },
		win_options = {
			number = false,
			relativenumber = true,
			signcolumn = "no",
			foldcolumn = "0",
			statuscolumn = "",
			colorcolumn = "",
		},
		keymaps_help = { border = _G.config.border },
		ssh = { border = _G.config.border },
		cleanup_delay_ms = false,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		prompt_save_on_select_new_entry = true,
	})

	vim.keymap.set(
		"n",
		"<leader>E",
		function() require("oil").open() end,
		{ desc = "Explorer (oil)", noremap = false, silent = true }
	)
end)

-- (fzf-lua-frecency.nvim) Frecency plugin for fzf-lua
MiniDeps.later(function()
	MiniDeps.add({
		source = "elanmed/fzf-lua-frecency.nvim",
		depends = { "ibhagwan/fzf-lua" },
	})
	require("fzf-lua-frecency").setup({
		display_score = false,
		cwd_prompt = true,
		winopts = {
			preview = { hidden = "nohidden" },
		},
	})

	vim.keymap.set(
		"n",
		"<leader>f",
		function() vim.cmd("FzfLua frecency cwd_only=true") end,
		{ desc = "Files by frecency (picker)", noremap = false, silent = true }
	)
end)

-- (fzf-lua) Navigation and fuzzy pickers
MiniDeps.later(function()
	MiniDeps.add({
		source = "ibhagwan/fzf-lua",
		depends = {
			"nvim-tree/nvim-web-devicons",
		},
	})

	require("fzf-lua").register_ui_select(function(_, items)
		local min_h, max_h = 0.15, 0.70
		local h = (#items + 4) / vim.o.lines
		if h < min_h then
			h = min_h
		elseif h > max_h then
			h = max_h
		end
		return { winopts = { height = h, width = 0.60, row = 0.40 } }
	end)

	require("fzf-lua").setup({
		"default-title",
		defaults = {
			git_icons = false,
			file_icons = true,
			formatter = "path.filename_first",
		},
		fzf_opts = {
			["--margin"] = "0,0",
			["--info"] = "inline-right",
			["--no-bold"] = "",
		},
		winopts = {
			backdrop = 100,
			preview = {
				hidden = true,
				vertical = "up:45%",
				horizontal = "right:55%",
			},
			border = _G.config.border,
		},
		hls = {
			normal = "TelescopeNormal",
			border = "TelescopeBorder",
			title = "TelescopeTitle",
			help_normal = "TelescopeNormal",
			help_border = "TelescopeBorder",
			preview_normal = "TelescopePreviewNormal",
			preview_border = "TelescopePreviewBorder",
			preview_title = "TelescopePreviewTitle",
			cursor = "Cursor",
			cursorline = "TelescopeSelection",
			cursorlinenr = "TelescopeSelection",
			search = "IncSearch",
			header_bind = "Directory",
			header_text = "Boolean",
			path_linenr = "Comment",
			path_colnr = "Comment",
			buf_name = "Character",
			buf_nr = "Character",
			buf_flag_cur = "Boolean",
			buf_flag_alt = "Constant",
			tab_title = "Directory",
			tab_marker = "Directory",
			live_sym = "Boolean",
			scrollbar = "CursorLine",
		},
		fzf_colors = {
			["fg"] = { "fg", "TelescopeNormal" },
			["fg+"] = { "fg", "TelescopeSelection" },
			["bg"] = { "bg", "TelescopeNormal" },
			["bg+"] = { "bg", "TelescopeSelection" },
			["info"] = { "fg", "TelescopeNormal" },
			["border"] = { "fg", "TelescopeBorder" },
			["gutter"] = { "bg", "TelescopeNormal" },
			["preview-bg"] = { "bg", "TelescopePreviewNormal" },
			["preview-border"] = { "bg", "TelescopePreviewBorder" },
		},
		keymap = {
			builtin = {
				["<C-F>"] = "toggle-fullscreen",
				["?"] = "toggle-preview",
				["<F1>"] = "toggle-preview-ccw",
				["<F2>"] = "toggle-preview-cw",
				["<C-N>"] = "preview-page-down",
				["<C-P>"] = "preview-page-up",
				["<S-left>"] = "preview-page-reset",
			},
			fzf = {
				["ctrl-c"] = "abort",
				["ctrl-q"] = "select-all+accept",
				["ctrl-u"] = "unix-line-discard",
				["ctrl-a"] = "beginning-of-line",
				["ctrl-e"] = "end-of-line",
				["alt-a"] = "toggle-all",
				["?"] = "toggle-preview",
				["ctrl-p"] = "preview-page-down",
				["ctrl-n"] = "preview-page-up",
			},
		},
		oldfiles = {
			winopts = { preview = { hidden = false } },
			include_current_session = true,
		},
		grep = {
			winopts = {
				fullscreen = true,
				preview = { hidden = false },
			},
		},
		commands = { sort_lastused = true },
		manpages = { previewer = "man_native" },
		helptags = { previewer = "help_native" },
		zoxide = { formatter = "path.dirname_first" },
		lsp = {
			symbol_fmt = function(s) return s:lower() .. "\t" end,
			child_prefix = false,
		},
		tabs = {
			tab_marker = "◀",
			cwd_prompt = true,
		},
		buffers = {
			cwd_prompt = true,
			sort_lastused = true,
		},
	})

	local zoxide_picker = function()
		require("fzf-lua").fzf_exec("zoxide query -l", {
			winopts = {
				title = " Zoxide ",
				title_pos = "center",
			},
			fzf_opts = {
				["--no-multi"] = "",
			},
			actions = {
				["ctrl-o"] = {
					fn = function(selected) require("oil").open(selected[1]) end,
					desc = "open-oil",
					header = "open oil in selected directory",
				},
				["ctrl-s"] = {
					fn = function(selected)
						require("fzf-lua").files({ cwd = selected[1] })
					end,
					desc = "search-files",
					header = "search files in selected directory",
				},
				["default"] = function(selected) vim.cmd("cd " .. selected[1]) end,
			},
		})
	end

	vim.keymap.set(
		"n",
		"<leader>r",
		function() vim.cmd("FzfLua resume") end,
		{ desc = "Resume picker", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>P",
		function() vim.cmd("FzfLua builtin") end,
		{ desc = "Pickers", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>tt",
		function() vim.cmd("FzfLua tabs") end,
		{ desc = "Tabs (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>h",
		function() vim.cmd("FzfLua oldfiles") end,
		{ desc = "History (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>B",
		function() vim.cmd("FzfLua buffers") end,
		{ desc = "Buffers (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>b",
		function() vim.cmd("FzfLua buffers cwd_only=true") end,
		{ desc = "Buffers cwd (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>z",
		function() zoxide_picker() end,
		{ desc = "Zoxide (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>gC",
		function() vim.cmd("FzfLua git_bcommits") end,
		{ desc = "Git buffer commits (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>s",
		function()
			vim.cmd("FzfLua live_grep path_shorten=true multiline=2 resume=true")
		end,
		{ desc = "Search workspace (buffer)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>S",
		function() vim.cmd("FzfLua lgrep_curbuf") end,
		{ desc = "search buffer (buffer)", noremap = false, silent = true }
	)
end)

-- (nvim-lspconfig) LSP server configurations
_G.now_if_args(function()
	MiniDeps.add("neovim/nvim-lspconfig")

	vim.lsp.config("*", {
		capabilities = _G.config.capabilities(),
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		flags = { debounce_text_changes = 150 },
	})
	local get_lsp_sources = function(source_map)
		local sources = {}
		for k, _ in pairs(source_map) do
			table.insert(sources, k)
		end

		return sources
	end

	vim.lsp.enable(get_lsp_sources(_G.config.sources.lsp))
end)

-- (gitsigns.nvim) Blame and diff for git
MiniDeps.later(function()
	MiniDeps.add("lewis6991/gitsigns.nvim")

	require("gitsigns").setup({
		signs = {
			change = { text = "┋" },
			delete = { text = "~" },
		},
		signs_staged = {
			change = { text = "┋" },
			delete = { text = "~" },
		},
		current_line_blame_formatter = "    <summary> • <author> • <author_time:%R> • <abbrev_sha>",
		current_line_blame_opts = {
			delay = 100,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>gs",
		function() vim.cmd("Gitsigns toggle_signs") end,
		{ desc = "Git signs (toggle)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"[g",
		function() vim.cmd("Gitsigns prev_hunk") end,
		{ desc = "Previous git hunk", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"]g",
		function() vim.cmd("Gitsigns next_hunk") end,
		{ desc = "Next git hunk", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>GG",
		function() vim.cmd("Gitsigns preview_hunk_inline") end,
		{ desc = "Preview hunk inline", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>GS",
		function() vim.cmd("Gitsigns stage_hunk") end,
		{ desc = "Stage hunk", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>GU",
		function() vim.cmd("Gitsigns undo_stage_hunk") end,
		{ desc = "Undo stage hunk", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>GR",
		function() vim.cmd("Gitsigns reset_hunk") end,
		{ desc = "Reset hunk", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>gm",
		function() vim.cmd("Gitsigns toggle_current_line_blame") end,
		{ desc = "Blame virtual (toggle)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>gM",
		function() vim.cmd("Gitsigns blame") end,
		{ desc = "Blame window open", noremap = false, silent = true }
	)
end)

-- (neogit) Magit for neovim
MiniDeps.later(function()
	MiniDeps.add({
		source = "NeogitOrg/neogit",
		depends = {
			"nvim-lua/plenary.nvim",
		},
	})

	require("neogit").setup({
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		git_services = {
			["g.beee.ps"] = {
				pull_request = "https://g.beee.ps/${owner}/${repository}/compare/master...${branch_name}?expand=1",
				commit = "https://g.beee.ps/${owner}/${repository}/commit/${oid}",
				tree = "https://g.beee.ps/${owner}/${repository}/src/branch/${branch_name}",
			},
			["git@g.beee.ps"] = {
				pull_request = "https://g.beee.ps/${owner}/${repository}/compare/master...${branch_name}?expand=1",
				commit = "https://g.beee.ps/${owner}/${repository}/commit/${oid}",
				tree = "https://g.beee.ps/${owner}/${repository}/src/branch/${branch_name}",
			},
			["codeberg.org"] = {
				pull_request = "https://codeberg.org/${owner}/${repository}/compare/master...${branch_name}?expand=1",
				commit = "https://codeberg.org/${owner}/${repository}/commit/${oid}",
				tree = "https://codeberg.org/${owner}/${repository}/src/branch/${branch_name}",
			},
			["git@codeberg.org"] = {
				pull_request = "https://codeberg.org/${owner}/${repository}/compare/master...${branch_name}?expand=1",
				commit = "https://codeberg.org/${owner}/${repository}/commit/${oid}",
				tree = "https://codeberg.org/${owner}/${repository}/src/branch/${branch_name}",
			},
		},
		disable_insert_on_commit = false,
		disable_context_highlighting = true,
		disable_line_numbers = true,
		disable_relative_line_numbers = true,
		disable_signs = false,
		disable_hint = true,
		graph_style = "unicode",
		fetch_after_checkout = true,
		auto_show_console_on = "error",
		console_timeout = 6000,
		-- log_pager = {
		-- 	"delta",
		-- 	"--width",
		-- 	"120",
		-- 	"--file-style",
		-- 	"omit",
		-- 	"--hunk-header-style",
		-- 	"omit",
		-- },
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		commit_view = { kind = "replace" },
		commit_editor = { kind = "vsplit", staged_diff_split_kind = "vsplit" },
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		integrations = { fzf_lua = true, diffview = false },
		signs = {
			hunk = { " ", " " },
			item = { "▸", "▾" },
			section = { " ", " " },
		},
		---@diagnostic disable-next-line:  assign-type-mismatch
		sections = {
			recent = { folded = false },
			untracked = { folded = true },
		},
		status = {
			show_head_commit_hash = true,
			recent_commit_count = 15,
			HEAD_padding = 10,
			HEAD_folded = false,
			mode_padding = 3,
		},
	})

	_G.augroup("neogit", {
		{ "Filetype" },
		{
			pattern = "Neogit*",
			desc = "disable neogit",
			callback = function()
				vim.b.miniindentscope_disable = true
				vim.wo.statuscolumn = ""
				vim.wo.cursorline = false
				vim.wo.colorcolumn = ""
			end,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>gl",
		function() vim.cmd("Neogit log kind=tab") end,
		{ desc = "Neogit logs", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>gb",
		function() vim.cmd("Neogit branch") end,
		{ desc = "Neogit branches", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>gg",
		function() vim.cmd("Neogit kind=vsplit") end,
		{ desc = "Neogit (split)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>gG",
		function() vim.cmd("Neogit kind=tab") end,
		{ desc = "Neogit (tab)", noremap = false, silent = true }
	)
end)

-- (blink.cmp) Auto completion
MiniDeps.later(function()
	MiniDeps.add({
		source = "saghen/blink.cmp",
		depends = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
		},
		checkout = "v1.7.0",
	})

	---@diagnostic disable-next-line: undefined-field
	require("blink.cmp").setup({
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		keymap = {
			preset = "none",
			-- toggle completion menu
			["<C-e>"] = { "hide", "show", "fallback" },
			-- toggle documentation
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			-- toggle signature
			["<C-K>"] = { "show_signature", "hide_signature", "fallback" },
			-- accept first result
			["<C-CR>"] = { "select_and_accept" },
			-- scroll documentation
			["<C-P>"] = { "scroll_documentation_up", "fallback_to_mappings" },
			["<C-N>"] = { "scroll_documentation_down", "fallback_to_mappings" },
			-- disable
			["<C-y>"] = {},
			["<C-b>"] = {},
			["<C-f>"] = {},
			["<Up>"] = {},
			["<Down>"] = {},
		},
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
			menu = {
				border = "none",
				draw = {
					treesitter = { "lsp" }, -- WARN: performance issues
					padding = { 0, 2 },
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								return " " .. ctx.kind_icon .. " " .. ctx.icon_gap
							end,
							highlight = function(ctx) return ctx.kind_hl end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				window = {
					max_width = 120,
					max_height = math.floor(vim.o.lines * 0.3),
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:FloatBorder,EndOfBuffer:BlinkCmpDoc",
				},
			},
			ghost_text = { enabled = true },
		},
		appearance = {
			use_nvim_cmp_as_default = true, -- WARN: will be deprecated
			kind_icons = _G.config.signs.kinds,
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"ripgrep",
			},
			providers = {
				ripgrep = {
					name = "R",
					module = "blink-ripgrep",
					score_offset = 4,
					max_items = 3,
					min_keyword_length = 3,
				},
				lsp = { name = "L", score_offset = 2 },
				path = {
					name = "P",
					opts = { trailing_slash = false },
				},
				snippets = {
					name = "S",
					max_items = 3,
					min_keyword_length = 0,
				},
			},
		},
		signature = {
			enabled = true,
			window = { direction_priority = { "s", "n" } },
		},
	})
end)

-- (dial.nvim) Toggling booleans and more
MiniDeps.later(function()
	MiniDeps.add("monaqa/dial.nvim")

	local augend = require("dial.augend")

	require("dial.config").augends:register_group({
		default = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.semver.alias.semver,
			augend.constant.alias.bool,
			augend.date.alias["%Y/%m/%d"],
		},
	})

	vim.keymap.set(
		"n",
		"<C-a>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("increment", "normal") end
	)

	vim.keymap.set(
		"n",
		"<C-x>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("decrement", "normal") end
	)

	vim.keymap.set(
		"n",
		"g<C-a>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("increment", "gnormal") end
	)

	vim.keymap.set(
		"n",
		"g<C-x>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("decrement", "gnormal") end
	)

	vim.keymap.set(
		"x",
		"<C-a>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("increment", "visual") end
	)

	vim.keymap.set(
		"x",
		"<C-x>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("decrement", "visual") end
	)

	vim.keymap.set(
		"x",
		"g<C-a>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("increment", "gvisual") end
	)

	vim.keymap.set(
		"x",
		"g<C-x>",
		---@diagnostic disable-next-line: param-type-not-match
		function() require("dial.map").manipulate("decrement", "gvisual") end
	)
end)

-- (nvim-treesitter) Treesitter engine
_G.now_if_args(function()
	MiniDeps.add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function() vim.cmd("TSUpdate") end,
		},
	})
	MiniDeps.add({
		source = "nvim-treesitter/nvim-treesitter-textobjects",
		checkout = "main",
	})

	require("nvim-treesitter").setup({
		install_dir = vim.fn.stdpath("data") .. "/site",
	})

	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end
	local to_install = vim.tbl_filter(isnt_installed, _G.config.sources.treesitter)
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
		require("nvim-treesitter").install({ "markdown_inline", "printf" })
	end

	-- enable tree-sitter after opening a file for a target language
	local filetypes = {}
	for _, lang in ipairs(_G.config.sources.treesitter) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end
	local treesitter_start = function(ev)
		-- start treesitter only for huge files
		if not _G.big(vim.fn.expand("%")) then
			vim.treesitter.start(ev.buf)
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end

	_G.augroup("treesitter", {
		"FileType",
		{
			desc = "start tree-sitter",
			pattern = filetypes,
			callback = treesitter_start,
		},
	})

	require("nvim-treesitter-textobjects").setup({
		select = { lookahead = true },
	})

	-- globally map Tree-sitter text object binds
	local function textobj_map(key, query)
		local outer = "@" .. query .. ".outer"
		local inner = "@" .. query .. ".inner"
		function get_opts(type)
			return {
				desc = type .. " " .. query,
				silent = true,
			}
		end
		vim.keymap.set(
			"x",
			"i" .. key,
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					inner,
					"textobjects"
				)
			end,
			get_opts("Inner")
		)
		vim.keymap.set(
			"x",
			"a" .. key,
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					outer,
					"textobjects"
				)
			end,
			get_opts("Outer")
		)
		vim.keymap.set(
			"o",
			"i" .. key,
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					inner,
					"textobjects"
				)
			end,
			get_opts("Inner")
		)
		vim.keymap.set(
			"o",
			"a" .. key,
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					outer,
					"textobjects"
				)
			end,
			get_opts("Outer")
		)
	end

	textobj_map("f", "function")
	textobj_map("c", "conditional")
	textobj_map("l", "loop")

	vim.keymap.set(
		"n",
		">A",
		function()
			require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
		end
	)
	vim.keymap.set(
		"n",
		"<A",
		function()
			require("nvim-treesitter-textobjects.swap").swap_previous(
				"@parameter.inner"
			)
		end
	)
end)

-- (nvim-treesitter-context) Treesitter context in-buffer
MiniDeps.later(function()
	MiniDeps.add("nvim-treesitter/nvim-treesitter-context")

	require("treesitter-context").setup()
end)

-- (mason.nvim) Code tools forge
MiniDeps.later(function()
	MiniDeps.add("mason-org/mason.nvim")

	require("mason").setup({
		log_level = vim.log.levels.ERROR,
		ui = {
			backdrop = 100,
			height = 0.8,
			icons = {
				package_installed = "●",
				package_pending = "○",
				package_uninstalled = "○",
			},
		},
	})
end)

-- (mason-tool-installer.nvim) Mason tool install
_G.now_if_args(function()
	MiniDeps.add({
		source = "WhoIsSethDaniel/mason-tool-installer.nvim",
		depends = { "mason-org/mason.nvim" },
	})

	local get_mason_sources = function(source_map)
		local sources = {}
		for _, v in pairs(source_map) do
			if v ~= "" then table.insert(sources, v) end
		end

		return sources
	end

	local mason_sources = {}

	for _, value in ipairs(_G.config.sources.tools) do
		table.insert(mason_sources, value)
	end
	for _, value in ipairs(get_mason_sources(_G.config.sources.lsp)) do
		table.insert(mason_sources, value)
	end

	require("mason-tool-installer").setup({
		ensure_installed = mason_sources,
	})
end)

-- (nvim-lint) Async linter engine
MiniDeps.later(function()
	MiniDeps.add("mfussenegger/nvim-lint")

	require("lint").linters_by_ft = {
		lua = { "selene" },
		dockerfile = { "hadolint", "trivy" },
		terraform = { "trivy", "terraform_validate" },
		ansible = { "ansible_lint" },
		go = { "golangcilint" },
	}
end)

-- (otter.nvim) LSP completion in code blocks
MiniDeps.later(function()
	MiniDeps.add("jmbuhr/otter.nvim")

	require("otter").setup({
		lsp = { hover = { border = _G.config.border } },
		buffers = { set_filetype = true },
	})

	_G.augroup("otter", {
		{ "BufNewFile", "BufRead" },
		{
			desc = "activate otter",
			pattern = { "*.md", "*.qmd" },
			callback = function() require("otter").activate() end,
		},
	})
end)

-- (conform.nvim) Formatter
_G.now_if_args(function()
	MiniDeps.add("stevearc/conform.nvim")

	require("conform").setup({
		---@module "conform"
		---@type conform.setupOpts
		quiet = true,
		default_format_opts = { lsp_format = "fallback" },
		formatters_by_ft = {
			typescript = { "biome" },
			typescriptreact = { "biome" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			html = { "biome" },
			css = { "biome" },
			scss = { "biome" },
			lua = { "stylua", lsp_format = "prefer" },
			markdown = { "mdformat", "injected" },
			quarto = { "mdformat", "injected" },
			yaml = { "yamlfmt" },
			graphql = { "biome" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			go = { "goimports", "gofumpt", "gofmt", "golines", "gci" },
			terraform = { "terraform_fmt" },
			hcl = { "hcl" },
			python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
			opa = { "opa_fmt" },
			json = { "biome" },
			jsonc = { "biome" },
		},
		format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
		formatters = {
			injected = {
				options = {
					ignore_errors = false,
					lang_to_ext = {
						bash = "sh",
						shell = "sh",
						c_sharp = "cs",
						elixir = "exs",
						javascript = "js",
						julia = "jl",
						latex = "tex",
						markdown = "md",
						python = "py",
						ruby = "rb",
						rust = "rs",
						teal = "tl",
						r = "r",
						typescript = "ts",
						terraform = "tf",
					},
					lang_to_formatters = {},
				},
			},
		},
	})

	_G.augroup("conform", {
		"LspAttach",
		{
			desc = "on attach for LSP for conform",
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

				if client.server_capabilities.documentFormattingProvider then
					vim.keymap.set(
						{ "n", "v" },
						"<leader>F",
						require("conform").format,
						{
							desc = "Format code",
							noremap = true,
							silent = true,
							buffer = bufnr,
						}
					)
				end
			end,
		},
	})
end)

-- (gitsigns.nvim) Blame and diff for git
MiniDeps.later(function()
	MiniDeps.add("mfussenegger/nvim-lint")

	require("lint").linters_by_ft = {
		lua = { "selene" },
		dockerfile = { "hadolint", "trivy" },
		terraform = { "trivy", "terraform_validate" },
		ansible = { "ansible_lint" },
		go = { "golangcilint" },
	}
end)

-- (incline.nvim) Current file status
MiniDeps.later(function()
	MiniDeps.add({
		source = "b0o/incline.nvim",
		depends = { "nvim-tree/nvim-web-devicons" },
	})
	require("incline").setup({
		hide = {
			cursorline = true,
		},
		render = function(props)
			local bufname = vim.api.nvim_buf_get_name(props.buf)
			local filename = vim.fn.fnamemodify(bufname, ":t")
			local extension = vim.fn.fnamemodify(filename, ":e")
			local icon, _ = require("nvim-web-devicons").get_icon(
				filename,
				extension,
				{ default = true }
			)
			local modified = ""

			if icon ~= "" then icon = icon .. " " end

			if filename == "" then filename = "[No Name]" end

			if vim.api.nvim_get_option_value("modified", { buf = props.buf }) then
				modified = " [+]"
			end

			return {
				icon,
				filename,
				modified,
			}
		end,
	})
end)

-- (nvim-highlight-colors) Highlight color blocks
MiniDeps.later(function()
	MiniDeps.add("brenoprata10/nvim-highlight-colors")

	require("nvim-highlight-colors").setup({
		render = "virtual",
		virtual_symbol = " ■",
		enable_named_colors = false,
		exclude_filetypes = { "Neogit*" },
		exclude_buftypes = { "nofile" },
	})

	vim.keymap.set(
		"n",
		"<leader>H",
		function() vim.cmd("HighlightColors Toggle") end,
		{ desc = "Highlight colors (toggle)", noremap = false, silent = true }
	)
end)

-- (zk-nvim) Markdown note taking assistant
MiniDeps.later(function()
	MiniDeps.add("zk-org/zk-nvim")

	require("zk").setup({
		picker = "fzf_lua",
		auto_attach = {
			enabled = true,
			filetypes = { "markdown" },
		},
		lsp = {},
	})

	vim.keymap.set(
		"n",
		"<leader>ne",
		function() vim.cmd("ZkNotes") end,
		{ desc = "Note entries", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>nl",
		function() vim.cmd("ZkLinks") end,
		{ desc = "Note links", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>nb",
		function() vim.cmd("ZkBacklinks") end,
		{ desc = "Note backlinks", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>nt",
		function() vim.cmd("ZkTags") end,
		{ desc = "Note tags", noremap = false, silent = true }
	)

	vim.keymap.set(
		"v",
		"<leader>n",
		":'<,'>ZkNewFromTitleSelection<cr>",
		{ desc = "New note from selection", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>ni",
		function() vim.cmd("ZkIndex") end,
		{ desc = "Index notes", noremap = true, silent = true }
	)
end)

-- (render-markdown.nvim) Nice markdown rendering
MiniDeps.later(function()
	MiniDeps.add({
		source = "MeanderingProgrammer/render-markdown.nvim",
		depends = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	})

	require("render-markdown").setup({
		---@module 'render-markdown'
		---@type render.md.UserConfig
		completions = { lsp = { enabled = true } },
		anti_conceal = { enabled = true },
		latex = { enabled = false },
		heading = {
			width = "block",
			left_pad = 0,
			right_pad = 1,
			left_margin = 0,
			position = "inline",
			icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
		},
		sign = { enabled = false },
		code = {
			sign = false,
			language_pad = 1,
			left_pad = 1,
			right_pad = 1,
			width = "block",
			inline_pad = 1,
			min_width = 50,
			border = "thin",
		},
		checkbox = {
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰄲 " },
			custom = {
				todo = {
					raw = "[-]",
					rendered = "󰡖 ",
					highlight = "RenderMarkdownTodo",
					scope_highlight = nil,
				},
			},
		},
		link = {
			footnote = {
				superscript = false,
				prefix = "[",
				suffix = "]",
			},
			image = "󰋩 ",
			email = "󰇮 ",
			hyperlink = "󰌷 ",
			highlight = "RenderMarkdownLink",
			wiki = {
				icon = "󱗖 ",
				highlight = "RenderMarkdownWikiLink",
			},
			custom = {
				web = { pattern = "^http", icon = "󰖟 " },
				discord = { pattern = "discord%.com", icon = "󰙯 " },
				github = { pattern = "github%.com", icon = "󰊤 " },
				gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
				gitea = { pattern = "g%.beee%.ps", icon = " " },
				google = { pattern = "google%.com", icon = "󰊭 " },
				neovim = { pattern = "neovim%.io", icon = " " },
				reddit = { pattern = "reddit%.com", icon = "󰑍 " },
				stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
				wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
				youtube = { pattern = "youtube%.com", icon = "󰗃 " },
			},
		},
		win_options = {
			conceallevel = {
				default = vim.o.conceallevel,
				rendered = 3,
			},
			concealcursor = {
				default = vim.o.concealcursor,
				rendered = "",
			},
		},
		bullet = {
			icons = { "•", "◦", "•", "◦" },
		},
		yaml = { enabled = false },
	})
end)

-- (grug-far.nvim) Search and replace
MiniDeps.later(function()
	MiniDeps.add("MagicDuck/grug-far.nvim")

	require("grug-far").setup({
		disableBufferLineNumbers = true,
		resultsSeparatorLineChar = "─",
		spinnerStates = _G.config.signs.spinner,
		showInputsTopPadding = false,
		showInputsBottomPadding = false,
		helpLine = {
			enabled = false,
		},
		icons = {
			enabled = true,
			searchInput = "",
			replaceInput = "",
			filesFilterInput = "",
			flagsInput = "",
			pathsInput = "",
			resultsStatusReady = "",
			resultsStatusError = "",
			resultsStatusSuccess = "",
			resultsActionMessage = "",
			resultsEngineLeft = "[",
			resultsEngineRight = "]",
			resultsChangeIndicator = "",
			resultsAddedIndicator = "",
			resultsRemovedIndicator = "",
			resultsDiffSeparatorIndicator = "┊",
			historyTitle = "",
			helpTitle = "",
			lineNumbersEllipsis = " ",
		},
	})

	vim.keymap.set(
		"n",
		"<leader>R",
		function() vim.cmd("GrugFar") end,
		{ desc = "Replace (GrugFar)", noremap = false, silent = true }
	)

	_G.augroup("grugfar", {
		{ "Filetype" },
		{
			pattern = "grug-far",
			callback = function()
				vim.b.miniindentscope_disable = true
				vim.wo.statuscolumn = ""
				vim.wo.cursorline = false
				vim.wo.colorcolumn = ""
			end,
		},
	})
end)

-- (quicker.nvim) Quickfix list QOL
MiniDeps.later(function()
	MiniDeps.add("stevearc/quicker.nvim")

	require("quicker").setup({
		---@module "quicker"
		---@type quicker.SetupOptions
		type_icons = {
			E = _G.config.signs.lsp.Error,
			W = _G.config.signs.lsp.Warn,
			I = _G.config.signs.lsp.Info,
			N = _G.config.signs.lsp.Info,
			H = _G.config.signs.lsp.Hint,
		},
		borders = {
			vert = " ┋ ",
			strong_header = "━",
			strong_cross = "━╋━",
			strong_end = "━┫ ",
			soft_header = "╌",
			soft_cross = "╌╂╌",
			soft_end = "╌┨ ",
		},
		opts = {
			colorcolumn = "",
			buflisted = false,
			number = false,
			relativenumber = false,
			signcolumn = "auto",
			winfixheight = true,
			wrap = false,
		},
		keys = {
			{
				">",
				function()
					require("quicker").expand({
						before = 2,
						after = 2,
						add_to_existing = true,
					})
				end,
				desc = "expand quickfix context",
			},
			{
				"<",
				function() require("quicker").collapse() end,
				desc = "collapse quickfix context",
			},
		},
	})

	vim.keymap.set(
		"n",
		"<leader>q",
		function() require("quicker").toggle() end,
		{ desc = "Quickfix (toggle)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>l",
		function() require("quicker").toggle({ loclist = true }) end,
		{ desc = "Location list (toggle)", noremap = false, silent = true }
	)
end)

-- (overseer.nvim) Code runner
MiniDeps.later(function()
	MiniDeps.add({
		source = "stevearc/overseer.nvim",
		depends = { "ibhagwan/fzf-lua" },
		checkout = "v1.6.0",
	})

	local default_win_opts = {
		border = _G.config.border,
		win_opts = {
			winblend = 0,
		},
	}

	require("overseer").setup({
		form = default_win_opts,
		confirm = default_win_opts,
		task_win = default_win_opts,
		help_win = default_win_opts,
	})

	vim.keymap.set(
		"n",
		"<leader>O",
		function() vim.cmd("OverseerToggle") end,
		{ desc = "Overseer (toggle)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>o",
		function() vim.cmd("OverseerRun") end,
		{ desc = "Overseer run", noremap = false, silent = true }
	)

	_G.augroup("fzf_lua", {
		"LspAttach",
		{
			desc = "on attach for LSP for fzf-lua",
			callback = function(args)
				local bufnr = args.buf

				vim.keymap.set(
					"n",
					"grR",
					function() vim.cmd("FzfLua lsp_references") end,
					{
						desc = "References (picker)",
						noremap = false,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"<leader>Dd",
					function() vim.cmd("FzfLua lsp_document_diagnostics") end,
					{
						desc = "Document diagnostics (picker)",
						noremap = false,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"<leader>DS",
					function() vim.cmd("FzfLua lsp_document_symbols") end,
					{
						desc = "Document symbols (picker)",
						noremap = false,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"<leader>wD",
					function() vim.cmd("FzfLua lsp_workspace_diagnostics") end,
					{
						desc = "Workspace diagnostics (picker)",
						noremap = false,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"<leader>ws",
					function() vim.cmd("FzfLua lsp_workspace_symbols") end,
					{
						desc = "Workspace symbols (picker)",
						noremap = false,
						silent = true,
						buffer = bufnr,
					}
				)
			end,
		},
	})
end)

-- (aerial.nvim) Code outline
MiniDeps.later(function()
	MiniDeps.add("stevearc/aerial.nvim")

	require("aerial").setup({
		icons = _G.config.signs.kinds_padded,
		guides = {
			nested_top = " │ ",
			mid_item = " ├─",
			last_item = " └─",
			whitespace = "   ",
		},
		ignore = {
			unlisted_buffers = false,
			diff_windows = true,
			buftypes = "special",
			wintypes = "special",
		},
		close_automatic_events = {
			"unfocus",
			"switch_buffer",
			"unsupported",
		},
		show_guides = true,
		layout = {
			placement = "edge",
			close_on_select = false,
			max_width = 28,
			min_width = 28,
		},
	})

	vim.keymap.set(
		"n",
		"}",
		function() vim.cmd("AerialNext") end,
		{ desc = "Next symbol", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"{",
		function() vim.cmd("AerialPrev") end,
		{ desc = "Previous symbol", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>a",
		function() vim.cmd("AerialToggle") end,
		{ desc = "Aerial (toggle)", noremap = false, silent = true }
	)

	_G.augroup("aerial", {
		{ "Filetype" },
		{
			pattern = "aerial",
			callback = function()
				vim.b.miniindentscope_disable = true
				vim.wo.statuscolumn = ""
				vim.wo.cursorline = false
				vim.wo.colorcolumn = ""
				vim.wo.winhighlight = "Normal:ColorColumn"
			end,
		},
	})
end)

-- (git-conflict.nvim) Git conflicts helper
MiniDeps.later(function()
	MiniDeps.add("akinsho/git-conflict.nvim")

	require("git-conflict").setup({
		default_mappings = false,
		disable_diagnostics = true,
		highlights = {
			incoming = "DiffAdd",
			current = "DiffText",
			ancestor = "DiffChange",
		},
	})

	vim.keymap.set(
		"n",
		"co",
		"<Plug>(git-conflict-ours)",
		{ desc = "Choose ours", noremap = false, silent = true }
	)
	vim.keymap.set(
		"n",
		"ct",
		"<Plug>(git-conflict-theirs)",
		{ desc = "Choose theirs", noremap = false, silent = true }
	)
	vim.keymap.set(
		"n",
		"cb",
		"<Plug>(git-conflict-both)",
		{ desc = "Choose both", noremap = false, silent = true }
	)
	vim.keymap.set(
		"n",
		"cn",
		"<Plug>(git-conflict-none)",
		{ desc = "Choose none", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"[x",
		"<Plug>(git-conflict-next-conflict)",
		{ desc = "Next conflict", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"]x",
		"<Plug>(git-conflict-prev-conflict)",
		{ desc = "Previous conflict", noremap = false, silent = true }
	)
end)

-- (nvim-spider) use the w, e, b motions like a spider.
MiniDeps.later(function()
	MiniDeps.add("chrisgrieser/nvim-spider")

	require("spider").setup()

	vim.keymap.set(
		{ "n", "o", "x" },
		"w",
		"<cmd>lua require('spider').motion('w')<CR>"
	)
	vim.keymap.set(
		{ "n", "o", "x" },
		"e",
		"<cmd>lua require('spider').motion('e')<CR>"
	)
	vim.keymap.set(
		{ "n", "o", "x" },
		"b",
		"<cmd>lua require('spider').motion('b')<CR>"
	)
end)

-- (atone) Modern undotree
MiniDeps.later(function()
	MiniDeps.add("XXiaoA/atone.nvim")
	require("atone").setup()

	vim.keymap.set(
		"n",
		"<leader>u",
		function() vim.cmd("Atone (toggle)") end,
		{ desc = "Undotree (toggle)", noremap = false, silent = true }
	)
end)

-- (nvim-tree) Tree file
MiniDeps.later(function()
	MiniDeps.add({
		source = "nvim-tree/nvim-tree.lua",
		depends = { "nvim-tree/nvim-web-devicons" },
	})

	require("nvim-tree").setup({
		hijack_directories = { enable = false, auto_open = false },
		sync_root_with_cwd = true,
		reload_on_bufenter = true,
		respect_buf_cwd = true,
		git = { enable = true },
		filters = {
			dotfiles = true,
			git_ignored = false,
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		view = { width = 35 },
		renderer = {
			root_folder_label = ":~:s?$??",
			icons = {
				symlink_arrow = " » ",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
					hidden = false,
					diagnostics = false,
					bookmarks = false,
				},
				git_placement = "after",
				glyphs = {
					git = {
						unstaged = "M",
						staged = "S",
						unmerged = "U",
						renamed = "R",
						untracked = "U",
						deleted = "D",
						ignored = "I",
					},
				},
			},
		},
	})

	_G.augroup("nvim_tree", {
		{ "QuitPre" },
		{
			callback = function()
				local tree_wins = {}
				local floating_wins = {}
				local wins = vim.api.nvim_list_wins()
				for _, w in ipairs(wins) do
					local bufname =
						vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
					if bufname:match("NvimTree_") ~= nil then
						table.insert(tree_wins, w)
					end
					if vim.api.nvim_win_get_config(w).relative ~= "" then
						table.insert(floating_wins, w)
					end
				end
				if 1 == #wins - #floating_wins - #tree_wins then
					-- Should quit, so we close all invalid windows.
					for _, w in ipairs(tree_wins) do
						vim.api.nvim_win_close(w, true)
					end
				end
			end,
		},
	})

	_G.augroup("nvimtree", {
		{ "BufWinEnter", "BufReadPre", "BufEnter", "ColorScheme" },
		{
			desc = "set background for alt windows",
			pattern = "*",
			callback = function()
				local filetypes = { "NvimTree" }
				local current_ft = vim.bo.filetype
				if vim.tbl_contains(filetypes, current_ft) then
					vim.wo.winhighlight = "Normal:ColorColumn,CursorLine:CursorLine"
				end
			end,
		},
	})

	require("nvim-tree.view").View.winopts.foldcolumn = "0"
	require("nvim-tree.view").View.winopts.cursorline = true
	require("nvim-tree.view").View.winopts.statuscolumn = ""
	require("nvim-tree.view").View.winopts.colorcolumn = ""
	require("nvim-tree.view").View.winopts.signcolumn = "no"
	require("nvim-tree.view").View.winopts.winhighlight =
		"Normal:ColorColumn,CursorLine:CursorLine"

	vim.keymap.set("n", "<leader>T", function()
		vim.cmd("NvimTreeToggle")
		vim.cmd("wincmd p")
	end, { desc = "Tree (toggle)", noremap = false, silent = true })
end)

-- (tiny-inline-diagnostic.nvim) Better virtual diagnostic
MiniDeps.later(function()
	MiniDeps.add("rachartier/tiny-inline-diagnostic.nvim")

	require("tiny-inline-diagnostic").setup({
		preset = "simple",
		transparent_cursorline = true,
		options = {
			show_source = {
				enabled = true,
				if_many = true,
			},
			use_icons_from_diagnostic = true,
			override_open_float = true,
			break_line = { enabled = true },
		},
		hi = {
			background = "None",
			arrow = "Conceal",
		},
	})

	vim.keymap.set(
		"n",
		"<leader>v",
		function() vim.cmd("TinyInlineDiag (toggle)") end,
		{ desc = "Virtual text (toggle)", noremap = false, silent = true }
	)
end)

-- (vscode-diff.nvim) Side-by-side diffs
MiniDeps.later(function()
	MiniDeps.add({
		source = "esmuellert/vscode-diff.nvim",
		depends = { "MunifTanjim/nui.nvim" },
	})

	require("vscode-diff").setup({
		keymaps = {
			view = {
				toggle_explorer = "<leader>de",
			},
		},
		explorer = {
			view_mode = "tree",
			width = 35,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>dd",
		function() vim.cmd("CodeDiff") end,
		{ desc = "Diff (toggle)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>df",
		function() vim.cmd("CodeDiff file HEAD") end,
		{ desc = "Diff file with HEAD", noremap = false, silent = true }
	)

	_G.augroup("vscode-diff", {
		{ "BufEnter", "ColorScheme" },
		{
			desc = "set background for alt windows",
			pattern = "*",
			callback = function()
				local filetypes = { "vscode-diff-explorer" }
				local current_ft = vim.bo.filetype
				if vim.tbl_contains(filetypes, current_ft) then
					vim.wo.winhighlight = "Normal:ColorColumn"
				end
			end,
		},
	}, {
		"BufEnter",
		{
			desc = "minimal mode in codediff",
			pattern = "*",
			callback = function()
				local filetypes = { "vscode-diff-explorer" }
				local current_ft = vim.bo.filetype
				if vim.tbl_contains(filetypes, current_ft) then
					vim.cmd("MinimalMode")
				end
			end,
		},
	})
end)
