local augroup = require("core.utils").augroup

-- Plugins which add additional ways to use nvim
return {
	{
		-- Navigation and fuzzy pickers
		"ibhagwan/fzf-lua",
		keys = {
			{
				"<leader>h",
				"<cmd>FzfLua oldfiles<cr>",
				desc = "Browse history",
			},
			{
				"<leader>l",
				"<cmd>FzfLua resume<cr>",
				desc = "Last picker (resume)",
			},
			{
				"<leader>i",
				"<cmd>FzfLua builtin<cr>",
				desc = "Installed pickers",
			},
			{
				"<leader>b",
				"<cmd>FzfLua buffers path_shorten=true<cr>",
				desc = "Buffer list",
			},
			{
				"<leader>f",
				"<cmd>FzfLua files<cr>",
				desc = "Find files",
			},
			{
				"<leader>z",
				"<cmd>lua require('fzf.zoxide').exec()<cr>",
				desc = "Zoxide",
			},
			{
				"<leader>c",
				"<cmd>FzfLua lsp_document_symbols<cr>",
				desc = "Code symbols (document)",
			},
			{
				"<leader>w",
				"<cmd>FzfLua lsp_workspace_diagnostics path_shorten=true<cr>",
				desc = "Workspace diagnostics",
			},
			{
				"<leader>gC",
				"<cmd>FzfLua git_bcommits<cr>",
				desc = "Git commits (buffer)",
			},
			{
				"<leader>gb",
				"<cmd>FzfLua git_branches<cr>",
				desc = "Git branches",
			},
			{
				"<leader>gc",
				"<cmd>FzfLua git_commits<cr>",
				desc = "Git commits",
			},
			{
				"<leader>gs",
				"<cmd>FzfLua git_status<cr>",
				desc = "Git status",
			},
			{
				"<leader>/",
				"<cmd>FzfLua live_grep path_shorten=true<cr>",
				desc = "Grep workspace",
			},
			{
				"<leader><bslash>",
				"<cmd>FzfLua lgrep_curbuf<cr>",
				desc = "Grep buffer",
			},
			{
				"gr",
				"<cmd>FzfLua lsp_references path_shorten=true<cr>",
				desc = "Symbol references",
			},
			{
				"gI",
				"<cmd>FzfLua lsp_implementations path_shorten=true<cr>",
				desc = "Symbol implementation",
			},
		},
		opts = function()
			return {
				"default-title",
				defaults = {
					git_icons = false,
					file_icons = false,
				},
				fzf_opts = { ["--margin"] = "0,0", ["--info"] = "inline-right" },
				winopts = {
					col = 0.5,
					row = 0.35,
					width = 0.65,
					height = 0.70,
					preview = {
						hidden = "nohidden",
						vertical = "up:45%",
						horizontal = "right:55%",
						layout = "flex",
						flip_columns = 120,
					},
					border = "single",
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
					cursorline = "TelescopePreviewLine",
					cursorlinenr = "TelescopePreviewLine",
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
				},
				fzf_colors = {
					["fg"] = { "fg", "TelescopeNormal" },
					["bg"] = { "bg", "TelescopeNormal" },
					["info"] = { "fg", "TelescopeNormal" },
					["border"] = { "fg", "TelescopeBorder" },
					["gutter"] = { "bg", "TelescopeNormal" },
				},
				keymap = {
					builtin = {
						-- neovim `:tmap` mappings for the fzf win
						["<C-F>"] = "toggle-fullscreen",
						["?"] = "toggle-preview",
						-- Rotate preview clockwise/counter-clockwise
						["<F1>"] = "toggle-preview-ccw",
						["<F2>"] = "toggle-preview-cw",
						["<C-P>"] = "preview-page-down",
						["<C-N>"] = "preview-page-up",
						["<S-left>"] = "preview-page-reset",
					},
					fzf = {
						["ctrl-c"] = "abort",
						["ctrl-u"] = "unix-line-discard",
						["ctrl-a"] = "beginning-of-line",
						["ctrl-e"] = "end-of-line",
						["alt-a"] = "toggle-all",
						["?"] = "toggle-preview",
						["ctrl-p"] = "preview-page-down",
						["ctrl-n"] = "preview-page-up",
					},
				},
				-- Custom pickers
				files = {
					fzf_opts = { ["--ansi"] = false },
				},
				commands = { sort_lastused = true },
				manpages = { previewer = "man_native" },
				helptags = { previewer = "help_native" },
				diagnostics = {
					winopts = {
						width = 0.3,
						height = 0.5,
						vertical = "up:80%",
						preview = { layout = "vertical" },
					},
				},
				lsp = {
					winopts = {
						width = 0.3,
						height = 0.5,
						vertical = "up:80%",
						preview = { layout = "vertical" },
					},
				},
				tabs = {
					winopts = {
						width = 0.3,
						height = 0.3,
						preview = { hidden = "hidden" },
					},
				},
				buffers = {
					sort_lastused = true,
					winopts = {
						width = 0.3,
						height = 0.3,
						preview = { hidden = "hidden" },
					},
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("fzf-lua").setup(opts)
			end
		end,
	},
	{
		-- Distraction-free editing mode
		"folke/zen-mode.nvim",
		keys = {
			{
				"<C-M>z",
				function()
					vim.cmd("ZenMode")
				end,
				desc = "Toggle Zen Mode",
			},
		},
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 0,
				width = 0.9,
				height = 0.9,
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
					cursorcolumn = false,
					list = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
					laststatus = 0,
				},
				twilight = { enabled = false },
				kitty = {
					enabled = true,
					font = "+4",
				},
				wezterm = {
					enabled = true,
					font = "+4",
				},
				alacritty = {
					enabled = true,
					font = "16",
				},
			},
			on_open = function(_)
				vim.api.nvim_set_hl(0, "ZenBg", { link = "Normal" })
				vim.g.zen_indent_cache = vim.b.miniindentscope_disable
				vim.g.zen_notify_cache = vim.b.mininotify_disable
				vim.b.miniindentscope_disable = true
				vim.b.mininotify_disable = true
				vim.g.zen_foldcolumn_cache = vim.g.foldcolumn
				vim.g.foldcolumn = false
			end,
			on_close = function(_)
				vim.b.mininotify_disable = vim.g.zen_notify_cache
				vim.b.miniindentscope_disable = vim.g.zen_indent_cache
				vim.g.foldcolumn = vim.g.zen_foldcolumn_cache
			end,
		},
	},
	{
		-- Utility to align text by delimiters
		"echasnovski/mini.align",
		keys = {
			{ "gaa", mode = "v" },
			{ "gA",  mode = "v" },
		},
		version = false,

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
				{ "size",       highlight = "Special" },
				{ "mtime",      highlight = "Number" },
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
			keymaps_help = {
				border = "single",
			},
			ssh = {
				border = "single",
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
		cond = true,
		event = "BufReadPre",
		keys = {
			{
				"<C-M>k",
				"<cmd>WhichKey<cr>",
				desc = "List all keymaps",
			},
		},
		opts = function()
			return {
				presets = {
					operators = false,
					motions = false,
				},
				key_labels = {
					["<space>"] = "␣",
					["<cr>"] = "↵",
					["<tab>"] = "↹",
					["<Left>"] = "←",
					["<Right>"] = "→",
					["<Up>"] = "↑",
					["<Down>"] = "↓",
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
			}
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.register({
				["<leader>"] = { name = "Leader commands (pickers & LSP)" },
				["<leader>g"] = { name = "Git commands" },
				["<C-M>"] = { name = "Toggle components" },
				["<C-S>"] = { name = "Split windows" },
				["["] = { name = "Previous" },
				["]"] = { name = "Next" },
				["z"] = { name = "Folds, spelling & align" },
				["g"] = { name = "LSP, comment, case & navigation" },
				["gs"] = { name = "Surround" },
			})
			if opts then
				wk.setup(opts)
			end
		end,
	},
	{
		-- Minimalist start screen
		"echasnovski/mini.starter",
		init = function()
			vim.o.laststatus = 0
		end,
		cond = function()
			if vim.tbl_contains(vim.v.argv, "-R") then
				return false
			end
			return true
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
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		keys = {
			{
				"<leader>gg",
				"<cmd>Neogit kind=auto<cr>",
				desc = "Neogit",
			},
		},
		opts = function()
			return {
				commit_editor = {
					kind = "vsplit",
				},
				signs = {
					hunk = { "", "" },
					item = { "▸", "▾" },
					section = { "▸", "▾" },
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("neogit").setup(opts)
			end
			augroup("neogitDisable", {
				{ "Filetype" },
				{
					pattern = "Neogit*",
					callback = function()
						vim.b.miniindentscope_disable = true
						vim.wo.statuscolumn = "%!v:lua.get_statuscol()"
						vim.wo.number = false
						vim.wo.relativenumber = false
						vim.g.foldcolumn = false
						vim.wo.cursorline = false
					end,
				},
			})
		end,
	},
	{
		-- Discard inactive buffers
		"chrisgrieser/nvim-early-retirement",
		event = "BufReadPre",
		opts = {
			notificationOnAutoClose = true,
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
		-- Git signs and diffs
		"echasnovski/mini.diff",
		version = false,
		event = "BufReadPre",
		keys = {
			{
				"<C-M>gs",
				function()
					vim.g.minidiff_disable = not vim.g.minipairs_disable
					if vim.g.minidiff_disable then
						vim.notify("Disabled auto-pairs", vim.log.levels.INFO)
					else
						vim.notify("Enabled auto-pairs", vim.log.levels.INFO)
					end
				end,
				desc = "Toggle diff sigsn",
			},
			{
				"[g",
				desc = "Previous hunk",
			},
			{
				"]g",
				desc = "Next hunk",
			},
			{
				"<C-M>gh",
				function()
					require("mini.diff").toggle_overlay()
				end,
				desc = "Preview git hunks inline",
			},
			{
				"gh",
				desc = "Stage hunk",
			},
			{
				"gH",
				desc = "Reset hunk",
			},
		},
		init = function()
			vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { link = "DiffFGAdd" })
			vim.api.nvim_set_hl(0, "MiniDiffSignChange", { link = "DiffFGChange" })
			vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { link = "DiffFGRemove" })
		end,
		opts = function()
			return {
				view = {
					style = "sign",
					signs = { add = "▎", change = "▎", delete = "▎" },
				},
				delay = {
					text_change = 100,
				},
				mappings = {
					-- Apply hunks inside a visual/operator region
					apply = "gh",
					reset = "gH",
					textobject = "gh",
					goto_first = "[G",
					goto_prev = "[g",
					goto_next = "]g",
					goto_last = "]G",
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("mini.diff").setup(opts)
			end
		end,
	},
	{
		-- Global manage session
		"echasnovski/mini.sessions",
		version = false,
		event = "VimEnter",
		keys = {
			{
				"<leader>s",
				function()
					vim.ui.input({ prompot = "Session name:" }, function(name)
						if name == nil then
							return
						end
						name = name or vim.fn.getcwd():gsub("/", "-")
						require("mini.sessions").write(name)
						vim.notify("Saved session: " .. name, vim.log.levels.INFO)
					end)
				end,
				desc = "Save session",
			},
		},
		build = {
			"mkdir -p ~/.cache/nvim/sessions",
		},
		opts = {
			directory = "~/.cache/nvim/sessions",
		},
	},
}
