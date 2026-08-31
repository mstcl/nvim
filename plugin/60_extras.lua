-- External plugins
local _plugin_path = vim.fn.stdpath("data") .. "/site/pack/deps/opt"
local now = _G.helpers.now
local later = _G.helpers.later
local now_if_args = _G.helpers.now_if_args
local new_autocmd = _G.helpers.new_autocmd
local register_toggle = _G.helpers.register_toggle
local config = _G.config

later(function() vim.cmd("packadd nvim.undotree") end)

-- (statuscol.nvim) custom statuscolumn
now(function()
	vim.pack.add({ "https://github.com/luukvbaal/statuscol.nvim" })
	local builtin = require("statuscol.builtin")
	require("statuscol").setup({
		ft_ignore = {
			"codediff-explorer",
			"codediff-history",
		},
		relculright = true,
		clickhandlers = { Lnum = builtin.gitsigns_click },
		segments = {
			{
				text = { " " },
				colwidth = 1,
			},
			{
				sign = {
					name = { ".*" },
					namespace = { ".*" },
					maxwidth = 1,
					colwidth = 2,
					auto = false,
					wrap = true,
				},
			},
			{
				text = { builtin.lnumfunc, " " },
				colwidth = 1,
				click = "v:lua.ScLa",
			},
			{
				sign = {
					name = { "GitSigns*" },
					namespace = { "gitsigns" },
					colwidth = 1,
					fillchar = " ",
					fillcharhl = "Nrline",
				},
				click = "v:lua.ScSa",
			},
			{
				text = { builtin.foldfunc, " " },
				hl = "FoldColumn",
				wrap = true,
				colwidth = 1,
				click = "v:lua.ScFa",
			},
		},
	})
end)

-- (mini.icons) UI icons for filetypes etc.
now(function() require("mini.icons").setup() end)
later(function() require("mini.icons").mock_nvim_web_devicons() end)

-- Colorschemes
now(function()
	vim.pack.add({
		"https://github.com/rktjmp/lush.nvim",
		"https://github.com/mstcl/tavern.nvim",
		"https://github.com/mstcl/ivory.nvim",
		"https://github.com/mstcl/orng.nvim",
	})

	new_autocmd("toggletheme", {
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

-- (mini.jump) clever-f in lua
later(function()
	require("mini.jump").setup({
		delay = {
			highlight = 80,
			idle_stop = 5000,
		},
	})
	vim.api.nvim_set_hl(0, "MiniJump", { link = "MatchParen" })
end)

-- (mini.clue) Mapping helper
later(function()
	require("mini.clue").setup({
		window = {
			delay = 200,
			-- show clue like which-key.nvim
			config = function(buf_id)
				local sep = "·"
				local sep_len = vim.fn.strdisplaywidth(sep) -- Returns 2
				local raw_lines = vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)
				local ns_id = vim.api.nvim_create_namespace("miniclue_cols")

				local entries = {}
				local max_key_len = 0
				local max_desc_len = 0

				for _, line in ipairs(raw_lines) do
					local key, desc = line:match("^%s*(.-)%s*│%s*(.-)%s*$")
					if key and desc then
						max_key_len =
							math.max(max_key_len, vim.fn.strdisplaywidth(key))
						max_desc_len =
							math.max(max_desc_len, vim.fn.strdisplaywidth(desc))
						table.insert(entries, { key = key, desc = desc })
					end
				end

				if #entries == 0 then
					return {
						relative = "msgarea",
						height = 1,
						width = vim.o.columns,
						row = 0,
						col = 0,
					}
				end

				-- 2. Calculate Dynamic Columns (accounting for left and right outer padding)
				local left_pad = " "
				local right_pad = " "
				local outer_padding_width = vim.fn.strdisplaywidth(left_pad)
					+ vim.fn.strdisplaywidth(right_pad)

				local key_col_width = max_key_len
				local desc_col_width = max_desc_len
				local entry_width = key_col_width
					+ 1
					+ sep_len
					+ 1
					+ desc_col_width
					+ 3

				-- Subtract outer padding from total columns so dynamic column count fits precisely
				local available_width = vim.o.columns - outer_padding_width
				local num_cols =
					math.max(1, math.floor(available_width / entry_width))
				local num_rows = math.ceil(#entries / num_cols)

				local chunked_lines = {}
				local highlights = {}

				for r = 1, num_rows do
					-- Start line with the left padding
					local line_str = left_pad

					for c = 0, num_cols - 1 do
						local idx = r + (c * num_rows)
						if entries[idx] then
							local item = entries[idx]

							local key_pad = string.rep(
								" ",
								key_col_width - vim.fn.strdisplaywidth(item.key)
							)
							local desc_pad = string.rep(
								" ",
								desc_col_width - vim.fn.strdisplaywidth(item.desc)
							)

							-- Key
							local key_start = #line_str
							line_str = line_str .. item.key
							local key_end = #line_str

							table.insert(highlights, {
								line = r - 1,
								group = "MiniClueNextKey",
								start_col = key_start,
								end_col = key_end,
							})

							line_str = line_str .. key_pad .. " "

							-- Separator
							local sep_start = #line_str
							line_str = line_str .. sep
							local sep_end = #line_str

							table.insert(highlights, {
								line = r - 1,
								group = "MiniClueSeparator",
								start_col = sep_start,
								end_col = sep_end,
							})

							line_str = line_str .. " "

							-- Desc
							local desc_start = #line_str
							line_str = line_str .. item.desc
							local desc_end = #line_str

							table.insert(highlights, {
								line = r - 1,
								group = "MiniClueDesc",
								start_col = desc_start,
								end_col = desc_end,
							})

							line_str = line_str .. desc_pad .. "   "
						end
					end

					-- Append the right padding to the end of the line
					line_str = line_str .. right_pad
					table.insert(chunked_lines, line_str)
				end

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, chunked_lines)

				for _, hl in ipairs(highlights) do
					vim.hl.range(
						buf_id,
						ns_id,
						hl.group,
						{ hl.line, hl.start_col },
						{ hl.line, hl.end_col }
					)
				end

				return {
					relative = "msgarea",
					height = #chunked_lines + 2,
					width = entry_width,
					border = config.border,
					row = 0,
					col = 0,
				}
			end,
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

			-- surround
			{ mode = "n", keys = "s" },
			{ mode = "x", keys = "s" },
		},

		clues = {
			require("mini.clue").gen_clues.g(),
			require("mini.clue").gen_clues.marks(),
			require("mini.clue").gen_clues.registers(),
			require("mini.clue").gen_clues.square_brackets(),
			require("mini.clue").gen_clues.z(),
			require("mini.clue").gen_clues.windows({
				submode_resize = true,
				submode_move = true,
			}),

			{
				mode = "n",
				keys = "<leader>q",
				desc = "Quick jump [+]",
			},
			{ mode = "n", keys = "<leader>c", desc = "Conflicts [+]" },
			{ mode = "n", keys = "<leader>j", desc = "Jupyter [+]" },
			{ mode = "n", keys = "gr", desc = "Symbol [+]" },
			{ mode = "x", keys = "gr", desc = "Symbol [+]" },
		},
	})
end)

-- (mini.align) Utility to align text by delimiters
later(function() require("mini.align").setup() end)

-- (mini.move) Move lines in visual
later(function() require("mini.move").setup() end)

-- (mini.keymap) Supercharged keymapping
later(function()
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

	-- escape terminal
	require("mini.keymap").map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
	require("mini.keymap").map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

	-- fix spelling
	require("mini.keymap").map_combo("i", "kk", "<BS><BS><Esc>[s1z=gi<Right>")
end)

-- (mini.pairs) Auto pairs
later(function()
	register_toggle("autopairs", { "pairs", "minipairs" }, function()
		vim.g.minipairs_disable = not vim.g.minipairs_disable
		vim.notify(
			"Autopairs " .. (vim.g.minipairs_disable and "disabled" or "enabled"),
			vim.log.levels.INFO
		)
	end)

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
later(
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
now(function()
	vim.pack.add({ "https://github.com/vladdoster/remember.nvim" })

	require("remember")
end)

-- (fzf-lua) Navigation and fuzzy pickers
later(function()
	vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

	-- default vim.ui.select configuration
	-- stolen from https://github.com/ibhagwan/fzf-lua/issues/793
	require("fzf-lua").register_ui_select(function(_, items)
		local min_h, max_h = 10, 12
		local h = #items + 3
		if h < min_h then
			h = min_h
		elseif h > max_h then
			h = max_h
		end

		return {
			fzf_opts = { ["--preview"] = "hidden" },
			prompt = " ",
			previewer = false,
			winopts = {
				relative = "msgarea",
				border = config.border,
				height = h,
				preview = { hidden = true },
			},
		}
	end)

	require("fzf-lua").setup({
		{ "default", "hide" },

		-- tweak fzf options a bit so it's a bit nicer with fzf-lua
		fzf_opts = {
			["--no-preview-label"] = "",
			["--margin"] = "0,0",
			["--info"] = "inline-right",
			["--no-bold"] = "",
			["--header-border"] = "bottom",
			["--no-header-first"] = "",
			["--border"] = "none",
		},

		-- configure highlights
		-- TODO: use native highlights
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

		-- tweak fzf colors to work nicer with fzf-lua
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

		-- keymaps and actions for both fzf and fzf-lua
		keymap = {
			builtin = {
				["<C-G>"] = "toggle-fullscreen",
				["?"] = "toggle-preview",
				["<C-N>"] = "preview-down",
				["<C-P>"] = "preview-up",
				["<M-N>"] = "preview-half-page-down",
				["<M-P>"] = "preview-half-page-up",

				["<M-Esc>"] = false,
				["<F1>"] = false,
				["<F2>"] = false,
				["<F3>"] = false,
				["<F4>"] = false,
				["<F5>"] = false,
				["<F6>"] = false,
				["<F7>"] = false,
				["<F8>"] = false,
				["<F9>"] = false,
				["<S-Left>"] = false,
				["<S-down>"] = false,
				["<S-up>"] = false,
				["<M-S-down>"] = false,
				["<M-S-up>"] = false,
			},
			fzf = {
				["ctrl-z"] = "jump",
				["ctrl-q"] = "toggle",
				["alt-q"] = "toggle-all",
				["ctrl-u"] = "unix-line-discard",
				["ctrl-f"] = "forward-word",
				["ctrl-b"] = "backward-word",
				["ctrl-a"] = "beginning-of-line",
				["ctrl-e"] = "end-of-line",
				["alt-a"] = false,
				["alt-g"] = false,
				["alt-G"] = false,
				["f3"] = false,
				["f4"] = false,
				["shift-down"] = false,
				["shift-up"] = false,
			},
		},
		actions = {
			files = {
				["enter"] = require("fzf-lua").actions.file_edit_or_qf,
				["ctrl-s"] = require("fzf-lua").actions.file_split,
				["ctrl-v"] = require("fzf-lua").actions.file_vsplit,
				["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
				["alt-i"] = require("fzf-lua").actions.toggle_ignore,
				["alt-h"] = require("fzf-lua").actions.toggle_hidden,
				["alt-w"] = require("fzf-lua").actions.toggle_follow,
			},
		},

		winopts = {
			title_flags = false,
			border = config.border,
			backdrop = 100,
			preview = {
				border = config.border,
			},
		},

		-- builtin picker configuration
		-- global defaults; will override picker defaults unless defined below
		defaults = {
			formatter = "path.filename_first",
			winopts = { relative = "msgarea" },
		},

		args = { previewer = "bat" },
		buffers = { previewer = "bat" },
		builtin = {
			previewer = false,
			winopts = { preview = { hidden = false } },
		},
		files = {
			previewer = "bat",
			cwd_prompt = false,
			cwd_header = true,
			hidden = true,
			follow = true,
			no_ignore = false,
		},
		git = {
			files = { previewer = "bat" },
			hunks = { previewer = "bat" },
		},
		grep = { previewer = "bat" },
		highlights = {
			winopts = {
				preview = {
					title = false,
				},
			},
		},
		quickfix = { previewer = "bat" },
		loclist = { previewer = "bat" },
		lines = { previewer = "bat" },
		treesitter = { previewer = "bat" },
		spellcheck = { previewer = "bat" },
		profiles = { previewer = "bat" },
		tagstack = { previewer = "bat" },
		breakpoint = { previewer = "bat" },
		complete_file = { previewer = "bat" },
		undotree = { previewer = "undotree_native" },
		manpages = { previewer = "man_native" },
		helptags = { previewer = "help_native" },
		oldfiles = { previewer = "bat", include_current_session = true },
		commands = { sort_lastused = true },
		lsp = {
			previewer = "bat",
			-- symbol_fmt = function(s) return s:lower() .. "\t" end,
			child_prefix = false,
			symbols = { previewer = "bat" },
			finder = { previewer = "bat" },
			code_actions = { previewer = "codeaction_native" },
		},
		tabs = { previewer = "bat", tab_marker = "◀" },
		diagnostics = { previewer = "bat" },
	})

	vim.keymap.set(
		"n",
		"<leader>r",
		function() vim.cmd("FzfLua resume") end,
		{ desc = "Resume", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>p",
		function() vim.cmd("FzfLua builtin") end,
		{ desc = "Pickers", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>t",
		function() vim.cmd("FzfLua tabs") end,
		{ desc = "Tabs", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>h",
		function() vim.cmd("FzfLua oldfiles") end,
		{ desc = "History", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>b",
		function() vim.cmd("FzfLua buffers") end,
		{ desc = "Buffers", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>s",
		function() vim.cmd("FzfLua live_grep multiline=2") end,
		{ desc = "Search", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>w",
		function() vim.cmd("FzfLua grep_cword") end,
		{ desc = "Word", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>m",
		function() vim.cmd("FzfLua lsp_document_symbols") end,
		{ desc = "Symbols", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>M",
		function() vim.cmd("FzfLua lsp_workspace_symbols") end,
		{ desc = "Symbols [ws]", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>n",
		function() vim.cmd("FzfLua lsp_document_diagnostics") end,
		{ desc = "Diagnostics", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>N",
		function() vim.cmd("FzfLua lsp_workspace_diagnostics") end,
		{ desc = "Diganostics [ws]", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>F",
		function() vim.cmd("FzfLua files cwd=~/projects") end,
		{ desc = "Files [projects]", noremap = false, silent = true }
	)

	vim.keymap.set(
		"n",
		"<leader>f",
		function() vim.cmd("FzfLua files") end,
		{ desc = "Files", noremap = false, silent = true }
	)
end)

-- (gitsigns.nvim) Blame and diff for git
later(function()
	vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

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
				noremap = true,
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
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>G", gitsigns.preview_hunk, {
				desc = "Git [hunk]",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set(
				"n",
				"<leader>B",
				function() gitsigns.blame_line({ full = true }) end,
				{
					desc = "Blame",
					noremap = false,
					silent = true,
					buffer = bufnr,
				}
			)

			vim.keymap.set("n", "<leader>S", gitsigns.stage_hunk, {
				desc = "Stage",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>U", gitsigns.undo_stage_hunk, {
				desc = "Unstage",
				noremap = false,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>X", gitsigns.reset_hunk, {
				desc = "Reset",
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
					desc = "Stage",
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
					desc = "Unstage",
					noremap = false,
					silent = true,
					buffer = bufnr,
				}
			)

			vim.keymap.set(
				"v",
				"<leader>X",
				function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				{
					desc = "Reset",
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

	new_autocmd("gitsigns_refresh", {
		"BufEnter",
		{
			callback = function() pcall(vim.cmd, "Gitsigns refresh") end,
			desc = "Refresh gitsigns after external staging",
		},
	})
end)

-- (neogit) Magit for neovim
later(function()
	vim.pack.add({
		"https://github.com/NeogitOrg/neogit",
		"https://github.com/nvim-lua/plenary.nvim",
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
		disable_context_highlighting = true,
		disable_hint = true,
		graph_style = "unicode",
		auto_show_console_on = "error",
		console_timeout = 6000,
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		commit_editor = { kind = "vsplit" },
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		integrations = { fzf_lua = false }, -- purposefully turn this off to work with fzf in msgarea, so it doesn't do weird previewers
		diff_viewer = "codediff",
		signs = {
			hunk = { " ", " " },
			item = { config.signs.close, config.signs.open },
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

	new_autocmd("neogit", {
		{ "BufEnter", "ColorScheme" },
		{
			pattern = "Neogit*",
			desc = "disable neogit",
			callback = function()
				vim.api.nvim_set_hl(0, "NeogitWinSeparator", { link = "VertSplit" })
				vim.b.miniindentscope_disable = true
				vim.b.indent_guide = false
				vim.wo.statuscolumn = ""
				vim.opt_local.foldcolumn = "0"
				vim.wo.colorcolumn = ""
			end,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>g",
		function() vim.cmd("Neogit") end,
		{ desc = "Git", noremap = false, silent = true }
	)
end)

-- (blink.indent) Indent lines
later(function()
	vim.pack.add({ "https://github.com/saghen/blink.indent" })

	require("blink.indent").setup({
		--- @module 'blink.indent'
		--- @type blink.indent.Config
		blocked = {
			-- default: 'terminal', 'quickfix', 'nofile', 'prompt'
			buftypes = { include_defaults = true },
			filetypes = {
				"lspinfo",
				"checkhealth",
				"man",
				"",
				"fzf",
				"toggleterm",
				"ministarter",
				"gitsigns-blame",
				"help",
				"NeogitDiffView",
				"NeogitLogView",
				"gitcommit",
				"markdown",
				"codediff-history",
				"codediff-explorer",
				"aerial",
				"qf",
				"NvimTree",
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

	register_toggle(
		"indent",
		{ "ident" },
		function()
			require("blink.indent").enable(not require("blink.indent").is_enabled())
		end
	)
end)

-- (gitlinker.nvim) Get git remote url for code position
later(function()
	vim.pack.add({ "https://github.com/linrongbin16/gitlinker.nvim" })

	require("gitlinker").setup()

	vim.keymap.set(
		{ "n", "v" },
		"<leader>k",
		function()
			require("gitlinker").link({
				action = require("gitlinker.actions").system,
			})
		end,
		{ silent = true, noremap = true, desc = "Link" }
	)
end)

-- (blink.cmp) Auto completion
later(function()
	vim.pack.add({
		"https://github.com/saghen/blink.lib",
		"https://github.com/saghen/blink.cmp",
		"https://github.com/rafamadriz/friendly-snippets",
	})

	require("blink.cmp").build():pwait()

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
		cmdline = {
			enabled = false,
		},
		completion = {
			list = {
				-- don't insert selected items
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
			menu = {
				border = "none",
				-- what the completion menu looks like
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
				auto_show_delay_ms = 100,
				window = {
					max_width = 120,
					max_height = math.floor(vim.o.lines * 0.3),
				},
			},
			ghost_text = {
				enabled = true,
				show_without_selection = false,
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true, -- WARN: will be deprecated
			kind_icons = config.signs.kinds,
		},
		sources = {
			default = {
				"lsp",
				"buffer",
				"path",
				"snippets",
				"dadbod_grip",
			},
			providers = {
				dadbod_grip = {
					name = "Grip SQL",
					module = "dadbod-grip.completion.blink",
				},
				lsp = { name = "L", score_offset = 3, fallbacks = {} },
				buffer = {
					name = "B",
					max_items = 3,
					score_offset = 2,
					min_keyword_length = 2,
				},
				path = {
					name = "P",
					opts = { trailing_slash = false },
				},
				snippets = {
					name = "S",
					score_offset = 4,
					min_keyword_length = 1,
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
later(function()
	vim.pack.add({ "https://github.com/monaqa/dial.nvim" })

	local augend = require("dial.augend")

	local sql_augents = {
		-- like / not like
		augend.constant.new({
			elements = { "like", "not like" },
			word = true,
			cyclic = true,
		}),

		-- true / false
		augend.constant.new({
			elements = { "TRUE", "FALSE" },
			word = true,
			cyclic = true,
		}),

		-- join types
		augend.constant.new({
			elements = { "inner join", "left join", "right join", "full join" },
			cyclic = true,
		}),

		-- asc / desc
		augend.constant.new({
			elements = { "asc", "desc" },
			word = true,
			cyclic = true,
		}),

		-- null / not null
		augend.constant.new({
			elements = { "null", "not null" },
			word = true,
			cyclic = true,
		}),

		-- = / <>
		augend.constant.new({
			elements = { "=", "<>" },
			word = false,
			cyclic = true,
		}),
	}

	local default_augends = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.integer.alias.binary,
		augend.integer.alias.octal,
		augend.semver.alias.semver,
		augend.constant.alias.bool,
		augend.constant.alias.Bool,
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%H:%M:%S"],
		augend.constant.alias.en_weekday_full,
		augend.constant.alias.en_weekday,

		-- and / or
		augend.constant.new({
			elements = { "==", "!=" },
			word = false,
			cyclic = true,
		}),
		augend.constant.new({
			elements = { "&&", "||" },
			word = false,
			cyclic = true,
		}),
	}

	local shell_augents = {
		-- numeric test operators (the big one)
		augend.constant.new({
			elements = { "-eq", "-ne", "-gt", "-lt" },
			word = false,
			cyclic = true,
		}),
		-- string is-non-empty / is-empty
		augend.constant.new({
			elements = { "-n", "-z" },
			word = false,
			cyclic = true,
		}),
		-- [[ ]] / [ ] comparisons
		augend.constant.new({
			elements = { "==", "!=" },
			word = false,
			cyclic = true,
		}),
	}

	local function extend_augends(defaults, additions)
		local merged = vim.deepcopy(defaults)
		vim.list_extend(merged, additions)
		return merged
	end

	require("dial.config").augends:register_group({
		default = default_augends,
	})

	require("dial.config").augends:on_filetype({
		bash = extend_augends(default_augends, shell_augents),
		zsh = extend_augends(default_augends, shell_augents),
		sql = extend_augends(default_augends, sql_augents),
		["jinja.sql"] = extend_augends(default_augends, sql_augents),
		python = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "==", "!=" },
				word = false,
				cyclic = true,
			}),
		}),
		lua = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "==", "~=" },
				word = false,
				cyclic = true,
			}),
		}),
		go = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "==", "!=" },
				word = false,
				cyclic = true,
			}),
			augend.constant.new({
				elements = { "=", ":=" },
				word = false,
				cyclic = true,
			}),
		}),
		markdown = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "#", "##", "###" },
				word = false,
				cyclic = true,
			}),
		}),
		yaml = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "yes", "no" },
				word = true,
				cyclic = true,
			}),
		}),
		cpp = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "==", "!=" },
				word = false,
				cyclic = true,
			}),
		}),
		terraform = extend_augends(default_augends, {
			augend.constant.new({
				elements = { "==", "!=" },
				word = false,
				cyclic = true,
			}),
			-- version constraint operators
			augend.constant.new({
				elements = { "~>", ">=", "<=", "=", "!=" },
				word = false,
				cyclic = true,
			}),
		}),
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

-- (nvim-treesitter/nvim-treesitter-textobjects/nvim-treesitter-context) Treesitter engine and more
now_if_args(function()
	local ts_update = function() vim.cmd("TSUpdate") end
	_G.helpers.on_packchanged(
		"nvim-treesitter",
		{ "update" },
		ts_update,
		":TSUpdate"
	)

	vim.pack.add({
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		"https://github.com/nvim-treesitter/nvim-treesitter-context",
	})

	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end
	local to_install = vim.tbl_filter(isnt_installed, config.treesitter.grammars)
	if #to_install > 0 then require("nvim-treesitter").install(to_install) end
	require("nvim-treesitter").install({ "markdown_inline", "printf" })

	local filetypes = { "gitconfig" }
	for _, lang in ipairs(config.treesitter.grammars) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end

	local treesitter_start = function(ev)
		-- start treesitter only for non huge files and if not disabled for this filetype
		local filetype = vim.bo[ev.buf].filetype
		if not _G.helpers.is_big_file(vim.fn.expand("%")) then
			if
				not vim.tbl_contains(config.treesitter.disabled_filetypes, filetype)
			then
				vim.treesitter.start(ev.buf)
			end

			vim.wo.foldexpr = vim.treesitter.foldexpr
			vim.wo.foldmethod = "expr"
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end

	new_autocmd("treesitter", {
		{ "FileType" },
		{
			pattern = filetypes,
			callback = treesitter_start,
			desc = "Start tree-sitter",
		},
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

	require("treesitter-context").setup({
		multiwindow = true,
		separator = "─",
	})
end)

-- (nvim-lspconfig) LSP server configurations
now_if_args(function()
	vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

	vim.lsp.config("*", {
		capabilities = _G.helpers.lsp.setup_capabilities(),
		---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
		flags = { debounce_text_changes = 150 },
	})
	vim.lsp.enable(config.lsp.servers)
end)

-- (garbage-day.nvim) Kill idle/inactive language servers
later(function() vim.pack.add({ "https://github.com/Zeioth/garbage-day.nvim" }) end)

-- (nvim-lint) Async linter engine
later(function()
	vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

	require("lint").linters_by_ft = {
		lua = { "selene" },
		sh = { "shellcheck" },
		bash = { "shellcheck" },
		dockerfile = { "hadolint", "trivy" },
		terraform = { "trivy", "terraform_validate" },
		["yaml.ansible"] = { "ansible_lint" },
		yaml = { "yamllint" },
		rust = { "clippy" },
	}

	new_autocmd("nvim-lint", {
		{ "BufWritePost" },
		{
			desc = "lint file",
			callback = function(_) require("lint").try_lint() end,
		},
	})
end)

-- (otter.nvim) LSP completion in code blocks
later(function()
	vim.pack.add({ "https://github.com/jmbuhr/otter.nvim" })

	require("otter").setup({
		lsp = { hover = { border = config.border } },
		buffers = { set_filetype = true },
	})

	new_autocmd("otter", {
		{ "BufNewFile", "BufRead" },
		{
			desc = "activate otter",
			pattern = { "*.md", "*.qmd" },
			callback = function() require("otter").activate() end,
		},
	})
end)

-- (conform.nvim) Formatter
now_if_args(function()
	vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

	require("conform").setup({
		---@module "conform"
		---@type conform.setupOpts
		quiet = true,
		default_format_opts = { lsp_format = "fallback" },
		formatters_by_ft = {
			html = { "biome" },
			css = { "biome" },
			scss = { "biome" },
			lua = { "stylua" },
			markdown = { "mdformat", "injected" },
			quarto = { "mdformat", "injected" },
			yaml = { "yamlfmt" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			go = { "goimports", "gofumpt", "gofmt", "golines", "gci" },
			terraform = { "terraform_fmt" },
			hcl = { "hcl" },
			python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
			json = { "biome" },
			jsonc = { "biome" },
			rust = { "rustfmt" },
			["*"] = { "trim_whitespace" },
		},
		format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
		formatters = {
			mdformat = {
				prepend_args = function()
					return {
						"--number",
					}
				end,
			},
			injected = {
				options = {
					ignore_errors = true,
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

	vim.api.nvim_create_user_command(
		"Format",
		function() require("conform").format() end,
		{}
	)

	vim.api.nvim_create_user_command(
		"F",
		function() require("conform").format() end,
		{}
	)
end)

-- (nvim-highlight-colors) Highlight color blocks
later(function()
	vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" })

	require("nvim-highlight-colors").setup({
		render = "virtual",
		virtual_symbol = " ■",
		enable_named_colors = false,
		exclude_filetypes = { "Neogit*" },
		exclude_buftypes = { "nofile" },
	})

	register_toggle(
		"colors",
		{ "highlight_colors", "color" },
		function() vim.cmd("HighlightColors Toggle") end
	)
end)

-- (grug-far.nvim) Search and replace
later(function()
	vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

	require("grug-far").setup({
		disableBufferLineNumbers = true,
		resultsSeparatorLineChar = "─",
		spinnerStates = config.signs.spinner,
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
		{ desc = "Replace", noremap = false, silent = true }
	)

	new_autocmd("grugfar", {
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

-- (nvim-spider) use the w, e, b motions like a spider.
later(function()
	vim.pack.add({ "https://github.com/chrisgrieser/nvim-spider" })

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

-- (tiny-inline-diagnostic.nvim) Better virtual diagnostic
later(function()
	vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

	require("tiny-inline-diagnostic").setup({
		preset = "simple",
		transparent_cursorline = true,
		options = {
			show_source = {
				enabled = true,
				if_many = true,
			},
			overwrite_events = { "DiagnosticChanged" },
			use_icons_from_diagnostic = false,
			override_open_float = true,
			break_line = { enabled = true },
		},
		hi = {
			background = "None",
			arrow = "Conceal",
		},
	})

	register_toggle(
		"virtual_diagnostics",
		{ "virt", "virtual", "diag", "diagnostics", "inline_diag" },
		function() vim.cmd("TinyInlineDiag toggle") end
	)
end)

-- (codediff.nvim) Side-by-side diffs
now(function()
	vim.pack.add({
		"https://github.com/esmuellert/codediff.nvim",
		"https://github.com/MunifTanjim/nui.nvim",
	})

	require("codediff").setup({
		diff = {
			hide_merge_artifacts = true,
			original_position = "left",
			conflict_ours_position = "right",
			conflict_result_position = "bottom",
			jump_to_first_change = false,
			compute_moves = true,
		},
		explorer = {
			icons = {
				folder_closed = "",
				folder_open = "",
			},
			view_mode = "list",
			width = 35,
			initial_focus = "modified",
			focus_on_select = true,
			auto_open_on_cursor = false,
			status_right_margin = 2,
		},
		history = {
			position = "bottom",
			height = 8,
			initial_focus = "history",
			view_mode = "list",
		},
		keymaps = {
			view = {
				quit = "q",
				toggle_explorer = "<localleader>e",
				focus_explorer = "<localleader>f",
				next_hunk = "]g",
				prev_hunk = "[g",
				next_file = "]f",
				prev_file = "[f",
				diff_get = "do",
				diff_put = "dp",
				open_in_prev_tab = "gf",
				close_on_open_in_prev_tab = false,
				toggle_stage = "-",
				stage_hunk = "<localleader>s",
				unstage_hunk = "<localleader>u",
				discard_hunk = "<localleader>x",
				hunk_textobject = "ih",
				show_help = "g?",
				align_move = "gm",
				toggle_layout = "<localleader>t",
				toggle_compact = "<localleader>c",
			},
			explorer = {
				select = "<CR>",
				hover = "K",
				refresh = "R",
				toggle_view_mode = "i",
				stage_all = "S",
				unstage_all = "U",
				restore = "X",
				toggle_changes = "u",
				toggle_staged = "s",
				fold_toggle = "<S-Tab>",
			},
			history = {
				select = "<CR>",
				toggle_view_mode = "i",
				refresh = "R",
				fold_toggle = "<S-Tab>",
			},
			conflict = {
				accept_incoming = "<leader>ct", -- Accept incoming (theirs/left) change
				accept_current = "<leader>co", -- Accept current (ours/right) change
				accept_both = "<leader>cb", -- Accept both changes (incoming first)
				discard = "<leader>cx", -- Discard both, keep base
				accept_all_incoming = "<leader>cT", -- Accept ALL incoming changes
				accept_all_current = "<leader>cO", -- Accept ALL current changes
				accept_all_both = "<leader>cB", -- Accept ALL both changes
				discard_all = "<leader>cX", -- Discard ALL, reset to base
				next_conflict = "]x", -- Jump to next conflict
				prev_conflict = "[x", -- Jump to previous conflict
				diffget_incoming = "<leader>cdt", -- Get hunk from incoming (left/theirs) buffer
				diffget_current = "<leader>cdo", -- Get hunk from current (right/ours) buffer
			},
		},
	})

	vim.keymap.set(
		"n",
		"<leader>d",
		function() vim.cmd("CodeDiff") end,
		{ desc = "Diff", noremap = false, silent = true }
	)

	new_autocmd("codediff", {
		{ "BufEnter", "ColorScheme" },
		{
			desc = "set highlights for history panel",
			pattern = "*",
			callback = function()
				local filetypes = { "codediff-history" }
				local current_ft = vim.bo.filetype
				if vim.tbl_contains(filetypes, current_ft) then
					vim.wo.winhighlight =
						"DiagnosticError:DiffDelete,DiagnosticOk:DiffAdd,NonText:Operator"
				end
			end,
		},
	}, {
		{ "BufWinEnter", "BufReadPre", "BufEnter", "ColorScheme" },
		{
			desc = "set background for alt windows",
			pattern = "*",
			callback = function()
				local filetypes = { "codediff-explorer" }
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
				local filetypes = {
					"codediff-explorer",
					"codediff-history",
				}
				local current_ft = vim.bo.filetype
				if vim.tbl_contains(filetypes, current_ft) then
					vim.cmd("Mode minimal")
				end
			end,
		},
	})
end)

-- (opencode.nvim) Opencode integration
later(function()
	vim.pack.add({
		"https://github.com/nickjvandyke/opencode.nvim",
	})

	---@type opencode.Opts
	vim.g.opencode_opts = {
		server = {
			start = function()
				vim.notify(
					"No OpenCode server found. Start one manually with `opencode --port`.",
					vim.log.levels.WARN
				)
			end,
		},
	}

	vim.keymap.set(
		{ "n", "x" },
		"<leader>a",
		function() require("opencode").ask("@this: ") end,
		{ desc = "Ask" }
	)
	vim.keymap.set(
		{ "n", "x" },
		"<leader>o",
		function() require("opencode").select() end,
		{ desc = "OpenCode" }
	)
	vim.keymap.set(
		"n",
		"<leader>A",
		function() require("opencode").command("session.interrupt") end,
		{ desc = "Interrupt", noremap = false, silent = true }
	)

	vim.keymap.set(
		{ "n", "x" },
		"go",
		function() return require("opencode").operator("@this ") end,
		{ desc = "Add range to OpenCode", expr = true }
	)
	vim.keymap.set(
		"n",
		"gA",
		function() return require("opencode").operator("@this ") .. "_" end,
		{ desc = "Add line to OpenCode", expr = true }
	)
end)

-- (vim-illuminate) Highlight word under cursor
later(function()
	vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })
	require("illuminate").configure({
		providers = { "lsp" },
		modes_allowlist = { "n" },
		under_cursor = false,
	})
end)

-- (fyler.nvim) File tree with editor buffer
later(function()
	vim.pack.add({ "https://github.com/A7Lavinraj/fyler.nvim" })

	require("fyler").setup({
		win_opts = {
			list = false,
			relativenumber = false,
			signcolumn = "no",
			foldcolumn = "0",
			statuscolumn = "",
			colorcolumn = "",
			winhighlight = "Normal:ColorColumn,CursorLine:CursorLine",
		},
		extensions = {
			git = { enabled = true, inline = true },
			trash = { enabled = true },
			watcher = { enabled = true },
		},
		integrations = {
			icon = "nvim_web_devicons",
		},
		kind = "split_left_most",
		kind_presets = {
			split_left_most = {
				width = "14%",
				win_opts = {
					winfixwidth = true,
				},
			},
		},
		mappings = {
			n = {
				["<C-S>v"] = {
					action = "select",
					args = { vsplit = true },
					desc = "Open in vertical split",
				},
				["<C-S>h"] = {
					action = "select",
					args = { split = true },
					desc = "Open in horizontal split",
				},
				["<C-H>"] = {
					action = "toggle_ui",
					args = { "hidden_items" },
					desc = "Toggle hidden files",
				},
				["<C-V>"] = { disabled = true },
				["<C-S>"] = { disabled = true },
				["g."] = { disabled = true },
			},
		},
		ui = { indent_guides = true },
	})

	register_toggle(
		"tree",
		{ "filetree", "fyler" },
		function()
			require("fyler").toggle({
				kind = "split_left_most",
				root_path = vim.fn.getcwd(),
			})
		end
	)

	vim.api.nvim_create_user_command(
		"FileTreeOpen",
		function()
			require("fyler").open({
				kind = "split_left_most",
				root_path = vim.fn.getcwd(),
			})
		end,
		{}
	)

	vim.api.nvim_create_user_command(
		"FileTreeClose",
		function() require("fyler").close() end,
		{}
	)

	vim.keymap.set(
		"n",
		"<leader>E",
		function() vim.cmd("Toggle tree") end,
		{ desc = "Explorer [tree]", noremap = false, silent = true }
	)
end)

-- (oil.nvim) Buffer-like file browser
now_if_args(function()
	vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

	local detail = false
	local oil_columns = {
		icon = { "icon", directory = "+ ", add_padding = false },
		permissions = { "permissions", highlight = "Number" },
	}

	require("oil").setup({
		default_file_explorer = true,
		experimental_watch_for_changes = true,
		view_options = { show_hidden = true },
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
			border = config.border,
			max_width = math.floor(vim.api.nvim_win_get_width(0) * 0.7),
			max_height = math.floor(vim.api.nvim_win_get_height(0) * 0.6),
		},
		preview = { border = config.border },
		progress = { border = config.border },
		win_options = {
			number = true,
			relativenumber = true,
			signcolumn = "no",
			foldcolumn = "0",
			statuscolumn = "",
			colorcolumn = "",
		},
		keymaps_help = { border = config.border },
		ssh = { border = config.border },
		cleanup_delay_ms = false,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		prompt_save_on_select_new_entry = true,
	})

	-- Replaces the old explorer
	vim.api.nvim_create_user_command("E", "Oil", {})
	vim.api.nvim_create_user_command("Ex", "Oil", {})
	vim.api.nvim_create_user_command("Explore", "Oil", {})

	vim.keymap.set(
		"n",
		"<leader>e",
		function() vim.cmd("Oil") end,
		{ desc = "Explorer", noremap = false, silent = true }
	)
end)

-- (matchparen.nvim) Faster matchparen
later(function()
	vim.pack.add({ "https://github.com/monkoose/matchparen.nvim" })
	require("matchparen").setup()
end)

-- (jupynvim) Jupyter notebook in nvim
now(function()
	local plugin_dir = vim.fn.stdpath("data") .. "site/pack/core/opt/jupynvim/"
	local manifest = plugin_dir .. "/core/Cargo.toml"

	_G.helpers.on_packchanged(
		"jupynvim",
		{ "update" },
		vim.fn.system({ "cargo", "build", "--release", "--manifest-path", manifest }),
		":JupynvimUpdate"
	)

	vim.pack.add({ "https://github.com/sheng-tse/jupynvim" })

	require("jupynvim").setup({
		log_level = "info",
		image_renderer = "chafa",
		explorer_keys = {}, -- remote file tree
		explorer_cwd_keys = {},
		terminal_keys = {}, -- toggle a remote PTY
		pick_keys = {
			files = {},
			grep = {},
		},
	})
end)

-- (dadbod-griop) DB client and UI
later(function()
	vim.pack.add({ "https://github.com/joryeugene/dadbod-grip.nvim" })

	require("dadbod-grip").setup({
		ai = false,
		keymaps = {
			table_picker = "go",
			table_picker_alt = false, -- table picker (alternate)
			qpad_ai = false,
			tab_4 = false, -- disable the `4` mapping
			er_diagram = false, -- disable the `gG` mapping and palette entry
			tab_5 = false, -- `5`, per-column aggregate statistics
			grid_col_stats = false, -- `gS`, statistics for the column under cursor
			grid_profile = false, -- `gR`, table profile/distribution queries
		},
		completion = false,
	})

	vim.keymap.set(
		"n",
		"<leader>D",
		function() vim.cmd("GripToggle") end,
		{ desc = "Databases", noremap = false, silent = true }
	)
end)

-- (msgarea.nvim)
now(function()
	vim.pack.add({ "https://github.com/edisj/msgarea.nvim" })
	require("msgarea").setup({
		view = { max_height = 0.5 },
		-- Cmdline completion options
		cmdline = {
			enable = true,
			dynamic_height = true,
		},
	})

	vim.keymap.set(
		"n",
		"<leader>i",
		function() require("msgarea").close_all() end,
		{ desc = "MsgArea [close]", noremap = false, silent = true }
	)
end)

-- (zk-nvim) Markdown note taking assistant
later(function()
	vim.pack.add({ "https://github.com/zk-org/zk-nvim" })

	require("zk").setup({
		picker = "fzf_lua",
		auto_attach = {
			enabled = true,
			filetypes = { "markdown" },
		},
		lsp = {},
	})
end)

-- (render-markdown.nvim) Nice markdown rendering
later(function()
	vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

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
