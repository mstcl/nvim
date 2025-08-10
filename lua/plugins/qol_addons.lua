local augroup = require("core.utils").augroup
local border = require("core.variables").border
local conf = require("core.variables")
local condition = require("core.variables").ui_features
local LSP_SIGNS = require("core.variables").lsp_signs

-- Plugins which add additional ways to use nvim
return {
	{ -- (fzf-lua) Navigation and fuzzy pickers
		"ibhagwan/fzf-lua",
		lazy = false,
		keys = {
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
				"<leader>z",
				"<cmd>lua require('fzf.zoxide').exec()<cr>",
				desc = "Zoxide",
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
		},
		opts = function()
			return {
				"default-title",
				defaults = {
					git_icons = false,
					file_icons = false,
					formatter = "path.filename_first",
				},
				fzf_opts = { ["--margin"] = "0,0", ["--info"] = "inline-right" },
				winopts = {
					backdrop = 100,
					col = 0.5,
					row = 0.4,
					width = 0.65,
					height = 0.75,
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
				oldfiles = { include_current_session = true },
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
			if opts then
				require("fzf-lua").setup(opts)
			end
		end,
	},
	{ -- (fzf-lua-frecency.nvim) Frecency plugin for fzf-lua
		"elanmed/fzf-lua-frecency.nvim",
		lazy = false,
		keys = {
			{
				"<leader>h",
				"<cmd>FzfLua frecency<cr>",
				desc = "Browse history",
			},
			{
				"<leader>f",
				"<cmd>FzfLua frecency cwd_only=true<cr>",
				desc = "Find files",
			},
		},
		opts = {
			display_score = false,
		},
	},
	{ -- (mini.align) Utility to align text by delimiters
		"echasnovski/mini.align",
		keys = {
			{ "gaa", mode = "v" },
			{ "gA", mode = "v" },
		},
		version = false,
		opts = {},
	},
	{ -- (oil.nvim) Buffer-like file browser
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
	{ -- (which-key.nvim) Keymapping cheatsheet
		"folke/which-key.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<C-M>k",
				function()
					require("which-key").show()
				end,
				desc = "Toggle which-key",
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
				{ "<leader>", group = "Leader commands (pickers & LSP)" },
				{ "<leader>g", group = "Git commands" },
				{ "<C-M>", group = "Toggle components" },
				{ "<C-M>a", group = "Toggle animate/autopairs" },
				{ "<C-M>g", group = "Toggle git components" },
				{ "<C-M>c", group = "Toggle cursorcolumn/line" },
				{ "<C-M>i", group = "Toggle inlayhints/indentscope" },
				{ "<C-M>s", group = "Toggle sidescrolloff/spellcheck" },
				{ "<C-M>v", group = "Toggle virtual-text/lines" },
				{ "<C-S>", group = "Split windows" },
				{ "[", group = "Previous" },
				{ "]", group = "Next" },
				{ "z", group = "Folds, spelling & align" },
				{ "g", group = "LSP, comment, case & navigation" },
				{ "gs", group = "Surround" },
				{ "gr", group = "LSP symbol actions" },
				{ "<leader>n", group = "Notes (zk) commands", cond = conf.syntax_features.markdown },
				{ "m", group = "Molten operations", cond = conf.syntax_features.quarto },
				{ "<leader>d", group = "DAP commands", cond = conf.dap_enabled },
				{ "go", group = "Otter (code block) symbols", cond = conf.lsp_enabled },
			})
			if opts then
				wk.setup(opts)
			end
		end,
	},
	{ -- (blame.nvim) Git blame sidebar
		"FabijanZulj/blame.nvim",
		cmd = "BlameToggle",
		keys = {
			{
				"<C-M>b",
				function()
					vim.cmd("BlameToggle window")
					vim.notify("Toggled blame", vim.log.levels.INFO)
				end,
				desc = "Toggle blame split",
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
	{ -- (neogit) magit clone
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
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
	{ -- (grug-far.nvim) Search and replace
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
	{ -- (quicker.nvim) Quickfix list QOL
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {
			type_icons = {
				E = LSP_SIGNS.Error,
				W = LSP_SIGNS.Warn,
				I = LSP_SIGNS.Info,
				N = LSP_SIGNS.Info,
				H = LSP_SIGNS.Hint,
			},
			keys = {
				{
					">",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
		},
	},
	{ -- (overseer.nvim) Code runner
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
		opts = function()
			local default_win_opts = {
				border = border,
				win_opts = {
					winblend = 0,
				},
			}

			return {
				form = default_win_opts,
				confirm = default_win_opts,
				task_win = default_win_opts,
				help_win = default_win_opts,
			}
		end,
		config = function(_, opts)
			if opts then
				require("overseer").setup(opts)
			end
		end,
	},
	{ -- (mini.diff) Git signs and diffs
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
	{ -- (git-conflict.nvim) Git conflicts helper
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre",
		keys = {
			{
				"co",
				"<Plug>(git-conflict-ours)",
				desc = "Choose ours (conflict)",
			},
			{
				"ct",
				"<Plug>(git-conflict-theirs)",
				desc = "Choose theirs (conflict)",
			},
			{
				"cb",
				"<Plug>(git-conflict-both)",
				desc = "Choose both (conflict)",
			},
			{
				"cn",
				"<Plug>(git-conflict-none)",
				desc = "Choose none (conflict)",
			},
			{
				"]x",
				"<Plug>(git-conflict-next-conflict)",
				desc = "Next conflict",
			},
			{
				"[x",
				"<Plug>(git-conflict-prev-conflict)",
				desc = "Previous conflict",
			},
		},
		opts = function()
			return {
				default_mappings = false,
				disable_diagnostics = true,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
					ancestor = "DiffChange",
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("git-conflict").setup(opts)
			end
		end,
	},
	{ -- (section-wordcount.nvim) Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		ft = { "markdown", "quarto" },
		cond = conf.syntax_features.markdown,
		opts = {
			highlight = "NonText",
			virt_text_pos = "eol",
		},
		config = function(_, opts)
			if opts then
				require("section-wordcount").setup(opts)
			end
			require("section-wordcount").wordcounter({})
		end,
	},
}
