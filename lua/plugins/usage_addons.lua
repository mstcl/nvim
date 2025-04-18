local augroup = require("core.utils").augroup
local border = require("core.variables").border
local conf = require("core.variables")

-- Plugins which add additional ways to use nvim
return {
	{
		-- Minimalist start screen
		"echasnovski/mini.starter",
		init = function()
			vim.o.laststatus = 0
		end,
		cond = function()
			if conf.ui_features.starter then
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
				"<cmd>FzfLua buffers<cr>",
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
				"g0",
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
				"<cmd>FzfLua live_grep path_shorten=true multiline=2<cr>",
				desc = "Grep workspace",
			},
			{
				"<leader><bslash>",
				"<cmd>FzfLua lgrep_curbuf<cr>",
				desc = "Grep buffer",
			},
			{
				"grr",
				"<cmd>FzfLua lsp_references path_shorten=true ignore_current_line=true<cr>",
				desc = "Symbol references",
			},
			{
				"gri",
				"<cmd>FzfLua lsp_implementations path_shorten=true ignore_current_line=true<cr>",
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
					backdrop = 100,
					col = 0.5,
					row = 0.35,
					width = 0.65,
					height = 0.70,
					preview = {
						hidden = "nohidden",
						vertical = "up:45%",
						horizontal = "right:55%",
						layout = "flex",
						flip_columns = 100,
					},
					border = border,
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
					scrollbar = "NonText",
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
						["<C-P>"] = "preview-page-down",
						["<C-N>"] = "preview-page-up",
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
				-- Custom pickers
				files = {
					fzf_opts = { ["--ansi"] = false },
				},
				oldfiles = {
					include_current_session = true,
				},
				commands = { sort_lastused = true },
				manpages = { previewer = "man_native" },
				helptags = { previewer = "help_native" },
				lsp = {
					symbol_fmt = function(s)
						return s:lower() .. "\t"
					end,
					child_prefix = false,
				},
				tabs = {
					winopts = {
						width = 0.5,
						height = 0.5,
						preview = { hidden = "hidden" },
					},
				},
				buffers = {
					sort_lastused = true,
					winopts = {
						width = 0.5,
						height = 0.5,
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
			-- Open oil when running nvim on a directory
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
			},
			columns = {
				{
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
				{ "permissions", highlight = "Number" },
			},
			float = {
				padding = 0,
				border = border,
				max_width = math.floor(vim.api.nvim_win_get_width(0) * 0.4),
				max_height = math.floor(vim.api.nvim_win_get_height(0) * 0.4),
				override = function(conf)
					conf.style = "minimal"
					return conf
				end,
			},
			preview = {
				border = border,
			},
			progress = {
				border = border,
			},
			win_options = {
				number = false,
				relativenumber = false,
				signcolumn = "no",
				foldcolumn = "0",
				statuscolumn = "",
			},
			keymaps_help = {
				border = border,
			},
			ssh = {
				border = border,
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
				function()
					require("which-key").show()
				end,
				desc = "List all keymaps",
			},
		},
		opts = function()
			return {
				delay = 400,
				icons = {
					separator = "▸",
					breadcrumb = "»",
					colors = false,
					rules = false,
				},
				layout = {
					height = { min = 1 },
				},
				sort = { "alphanum" },
			}
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.add({
				{ "<leader>",  group = "Leader commands (pickers & LSP)" },
				{ "<leader>g", group = "Git commands" },
				{ "<C-M>",     group = "Toggle components" },
				{ "<C-S>",     group = "Split windows" },
				{ "[",         group = "Previous" },
				{ "]",         group = "Next" },
				{ "z",         group = "Folds, spelling & align" },
				{ "g",         group = "LSP, comment, case & navigation" },
				{ "gs",        group = "Surround" },
				{ "<leader>n", group = "Notes (zk) commands",            cond = conf.syntax_features.markdown },
				{ "m",         group = "Molten operations",              cond = conf.syntax_features.quarto },
				{ "<leader>d", group = "DAP commands",                   cond = conf.dap_enabled },
				{ "go",        group = "Otter (code block) symbols",     cond = conf.lsp_enabled },
			})
			if opts then
				wk.setup(opts)
			end
		end,
	},
	{
		"FabijanZulj/blame.nvim",
		cmd = "BlameToggle",
		keys = {
			{
				"<C-M>b",
				function()
					vim.cmd("BlameToggle window")
					vim.notify("Toggled blame", vim.log.levels.INFO)
				end,
				desc = "Blame split",
			},
		},
		opts = {
			blame_options = { "-w" },
			focus_blame = false,
			colors = {

				"#7c4034",
				"#464c3a",
				"#543227",
				"#545468",
				"#735057",
				"#673d58",
				"#493f37",
			},
		},
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
				disable_context_highlighting = true,
				graph_style = "ascii",
				disable_hint = true,
				fetch_after_checkout = true,
				disable_line_numbers = true,
				disable_relative_line_numbers = true,
				commit_editor = {
					kind = "vsplit",
				},
				integrations = {
					fzf_lua = true,
				},
				disable_signs = true,
				signs = {
					hunk = { " ", " " },
					item = { "▸", "▾" },
					section = { " ", " " },
				},
				auto_show_console_on = "error",
				console_timeout = 6000,
				sections = {
					recent = {
						folded = false,
					},
				},
				status = {
					show_head_commit_hash = true,
					recent_commit_count = 15,
					HEAD_padding = 10,
					HEAD_folded = false,
					mode_padding = 3,
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
				border = border,
				win_opts = {
					winblend = 0,
				},
			},
			confirm = {
				border = border,
				win_opts = {
					winblend = 0,
				},
			},
			task_win = {
				border = border,
				win_opts = {
					winblend = 0,
				},
			},
			help_win = {
				border = border,
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
}
