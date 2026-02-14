local _plugin_path = vim.fn.stdpath("data") .. "/site/pack/deps/opt"
-- (nvim-web-devicons) Icons
MiniDeps.now(function() MiniDeps.add("nvim-tree/nvim-web-devicons") end)

-- Colorschemes
MiniDeps.now(function()
	MiniDeps.add("rktjmp/lush.nvim")
	MiniDeps.add("mstcl/tavern.nvim")
	MiniDeps.add("mstcl/ivory.nvim")

	_G.augroup("toggletheme", {
		"Signal",
		{
			pattern = "SIGUSR1",
			callback = function()
				package.loaded.theme = nil
				if vim.g.colors_name == "tavern" then
					vim.cmd.colorscheme("ivory")
				else
					vim.cmd.colorscheme("tavern")
				end
				vim.schedule(function() vim.cmd("redraw!") end)
			end,
			nested = true,
		},
	})
end)

-- (mini.notify) Popup notifications
MiniDeps.now(function()
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
			{ mode = "n", keys = "<leader>t", desc = "Tab [+]" },
			{ mode = "n", keys = "gr", desc = "Symbol [+]" },
			{ mode = "x", keys = "gr", desc = "Symbol [+]" },
		},
	})
end)

-- (mini.align) Utility to align text by delimiters
MiniDeps.later(function() require("mini.align").setup() end)

-- (mini.jump) Super f/F/t/T
MiniDeps.later(function() require("mini.jump").setup() end)

-- (mini.move) Move lines in visual
MiniDeps.later(function() require("mini.move").setup() end)

-- (mini.keymap) Supercharged keymapping
MiniDeps.later(function()
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
MiniDeps.later(
	function()
		require("mini.surround").setup({
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				update_n_lines = "sn",
			},
		})
	end
)

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
		icon = { "icon", directory = "+ ", add_padding = false },
		permissions = { "permissions", highlight = "Number" },
	}

	require("oil").setup({
		default_file_explorer = true,
		experimental_watch_for_changes = true,
		view_options = {
			show_hidden = true,
		},
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
			number = true,
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
			cwd_header = true,
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
		},
		buffers = {
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
		{ desc = "Resume (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>p",
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
		"<leader>s",
		function() vim.cmd("FzfLua live_grep multiline=2") end,
		{ desc = "Search workspace (picker)", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>C",
		function() vim.cmd("FzfLua commands") end,
		{ desc = "Commands (picker)", noremap = false, silent = true }
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
			add = { text = "│" },
			change = { text = "┆" },
			delete = { text = "~" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "│" },
			change = { text = "┆" },
			delete = { text = "~" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		current_line_blame_formatter = "    <summary> • <author> • <author_time:%R> • <abbrev_sha>",
		current_line_blame_opts = {
			delay = 100,
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			vim.keymap.set("n", "[g", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, {
				desc = "Previous git hunk",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "]g", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, {
				desc = "Next git hunk",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>G", gitsigns.preview_hunk, {
				desc = "Git diff peek",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set(
				"n",
				"<leader>M",
				function() gitsigns.blame_line({ full = true }) end,
				{
					desc = "Blame line",
					noremap = false,
					silent = true,
					buffer = bufnr,
				}
			)

			vim.keymap.set("n", "<leader>S", gitsigns.stage_hunk, {
				desc = "Stage hunk",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>U", gitsigns.undo_stage_hunk, {
				desc = "Unstage hunk",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set(
				"v",
				"<leader>S",
				function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				{
					desc = "Stage hunk",
					noremap = false,
					silent = true,
					buffer = bufnr,
				}
			)

			vim.keymap.set(
				"v",
				"<leader>U",
				function()
					gitsigns.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				{
					desc = "Unstage hunk",
					noremap = false,
					silent = true,
					buffer = bufnr,
				}
			)

			vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, {
				desc = "Select hunk textobject",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})
		end,
	})
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
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		commit_view = { kind = "replace" },
		commit_editor = { kind = "vsplit", staged_diff_split_kind = "vsplit" },
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		integrations = { fzf_lua = true, diffview = false },
		signs = {
			hunk = { " ", " " },
			item = { _G.config.signs.close, _G.config.signs.open },
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
				vim.b.indent_guide = false
				vim.wo.statuscolumn = ""
				vim.wo.cursorline = false
				vim.wo.colorcolumn = ""
			end,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>g",
		function() vim.cmd("Neogit kind=vsplit") end,
		{ desc = "Neogit", noremap = false, silent = true }
	)
end)

-- (blink.indent) Indent lines
MiniDeps.later(function()
	MiniDeps.add("saghen/blink.indent")

	require("blink.indent").setup({
		--- @module 'blink.indent'
		--- @type blink.indent.Config
		blocked = {
			-- default: 'terminal', 'quickfix', 'nofile', 'prompt'
			buftypes = { include_defaults = true },
			filetypes = {
				"lspinfo",
				"packer",
				"checkhealth",
				"man",
				"",
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
				"git*",
			},
		},
		mappings = {
			goto_top = "",
			goto_bottom = "",
		},
		static = {
			char = "│",
			whitespace_char = " ",
		},
		scope = { enabled = false },
	})
end)

-- (blink.cmp) Auto completion
MiniDeps.later(function()
	MiniDeps.add({
		source = "saghen/blink.cmp",
		depends = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
		},
		checkout = "v1.8.0",
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
					padding = { 0, 1 },
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
					score_offset = 1,
					max_items = 3,
					min_keyword_length = 3,
				},
				lsp = { name = "L", score_offset = 4 },
				path = {
					name = "P",
					opts = { trailing_slash = false },
				},
				snippets = {
					name = "S",
					score_offset = 2,
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
		checkout = "main",
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
_G.now_if_args(function()
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

-- (nvim-lint) Linter engine
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
				vim.b.indent_guide = false
				vim.b.indent_guide = false
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
			vert = " ┆ ",
			strong_header = "─",
			strong_cross = "─┼─",
			strong_end = "─┤ ",
			soft_header = "╌",
			soft_cross = "╌┼╌",
			soft_end = "╌┤ ",
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
				vim.b.indent_guide = false
				vim.wo.statuscolumn = ""
				vim.wo.cursorline = false
				vim.wo.colorcolumn = ""
				vim.wo.winhighlight = "Normal:ColorColumn"
			end,
		},
	})
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
		view = {
			cursorline = false,
			width = 30,
			signcolumn = "no",
		},
		git = { enable = true },
		modified = { enable = true },
		filters = {
			dotfiles = true,
			git_ignored = false,
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		renderer = {
			root_folder_label = false,
			group_empty = true,
			highlight_hidden = "name",
			highlight_modified = "name",
			indent_width = 2,
			indent_markers = { enable = true },
			special_files = {
				"go.mod",
				"Cargo.toml",
				"Makefile",
				"Justfile",
				"README.md",
				"readme.md",
			},
			icons = {
				symlink_arrow = " » ",
				show = {
					file = true,
					folder = false,
					folder_arrow = true,
					git = true,
					modified = true,
					hidden = false,
					diagnostics = false,
					bookmarks = false,
				},
				git_placement = "right_align",
				glyphs = {
					modified = "[+]",
					folder = {
						arrow_closed = _G.config.signs.close,
						arrow_open = _G.config.signs.open,
					},
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
	require("nvim-tree.view").View.winopts.statuscolumn = ""
	require("nvim-tree.view").View.winopts.colorcolumn = ""
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

-- (codediff.nvim) Side-by-side diffs
MiniDeps.now(function()
	MiniDeps.add({
		source = "esmuellert/codediff.nvim",
		depends = { "MunifTanjim/nui.nvim" },
	})

	require("codediff").setup({
		keymaps = {
			view = {
				toggle_explorer = "<leader>de",
			},
		},
		explorer = {
			view_mode = "list",
			width = 35,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>d",
		function() vim.cmd("CodeDiff") end,
		{ desc = "Diff (toggle)", noremap = false, silent = true }
	)

	_G.augroup("vscode-diff", {
		{ "BufEnter", "ColorScheme" },
		{
			desc = "set background for alt windows",
			pattern = "*",
			callback = function()
				local filetypes = { "vscode-diff-explorer", "codediff-explorer" }
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
				local filetypes = { "vscode-diff-explorer", "codediff-explorer" }
				local current_ft = vim.bo.filetype
				if vim.tbl_contains(filetypes, current_ft) then
					vim.cmd("MinimalMode")
				end
			end,
		},
	})
end)

-- (context.nvim) Editor context for agents
MiniDeps.later(function()
	MiniDeps.add({
		source = "ahkohd/context.nvim",
		depends = { "ibhagwan/fzf-lua" },
	})

	require("context").setup({
		picker = require("context").pickers.vim_ui,
	})

	vim.keymap.set(
		"n",
		"<leader>X",
		function() require("context").pick() end,
		{ desc = "Context (picker)", noremap = false, silent = true }
	)
end)
