local augroup = require("core.utils").augroup
local conf = require("core.variables")
local LSP_SIGNS = conf.lsp_signs

-- Plugins which add additional ways to use nvim
return {
	{ -- (remember.nvim) jump to last place in a buffer
		"vladdoster/remember.nvim",
		lazy = false,
		config = true,
	},
	{ -- (lazy-patcher) lazy nvim plugin patcher
		"one-d-wide/lazy-patcher.nvim",
		ft = "lazy",
		config = true,
	},
	{ -- (nvim-web-devicons) Icons
		"nvim-tree/nvim-web-devicons",
		opts = {
			variant = "light",
		},
	},
	{ -- (fzf-lua) Navigation and fuzzy pickers
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"elanmed/fzf-lua-frecency.nvim",
		},
		keys = {
			{
				"grR",
				function()
					vim.cmd("FzfLua lsp_references")
				end,
				desc = "references (picker)",
			},
			{
				"<leader>xdD",
				function()
					vim.cmd("FzfLua lsp_document_diagnostics")
				end,
				desc = "document diagnostics (picker)",
			},
			{
				"<leader>xds",
				function()
					vim.cmd("FzfLua lsp_document_symbols")
				end,
				desc = "document symbols (picker)",
			},
			{
				"<leader>wD",
				function()
					vim.cmd("FzfLua lsp_workspace_diagnostics")
				end,
				desc = "workspace diagnostics (picker)",
			},
			{
				"<leader>ws",
				function()
					vim.cmd("FzfLua lsp_workspace_symbols")
				end,
				desc = "workspace symbols (picker)",
			},
			{
				"<leader>p",
				function()
					vim.cmd("FzfLua resume")
				end,
				desc = "last picker",
			},
			{
				"<leader>P",
				function()
					vim.cmd("FzfLua builtin")
				end,
				desc = "all pickers",
			},
			{
				"<leader>t",
				function()
					vim.cmd("FzfLua tabs")
				end,
				desc = "tabs (picker)",
			},
			{
				"<leader>h",
				function()
					vim.cmd("FzfLua oldfiles")
				end,
				desc = "history (picker)",
			},
			{
				"<leader>b",
				function()
					vim.cmd("FzfLua buffers cwd_only=true")
				end,
				desc = "buffers (picker)",
			},
			{
				"<leader>z",
				function()
					require("pickers.zoxide").zoxide()
				end,
				desc = "zoxide (picker)",
			},
			{
				"<leader>gC",
				function()
					vim.cmd("FzfLua git_bcommits")
				end,
				desc = "git buffer commits (picker)",
			},
			{
				"<leader>s",
				function()
					vim.cmd("FzfLua live_grep path_shorten=true multiline=2 resume=true")
				end,
				desc = "search workspace (buffer)",
			},
			{
				"<leader>S",
				function()
					vim.cmd("FzfLua lgrep_curbuf")
				end,
				desc = "search buffer (buffer)",
			},
		},
		opts = function()
			return {
				"default-title",
				defaults = {
					git_icons = false,
					file_icons = true,
					formatter = "path.filename_first",
				},
				fzf_opts = { ["--margin"] = "0,0", ["--info"] = "inline-right", ["--no-bold"] = "" },
				winopts = {
					backdrop = 100,
					preview = {
						hidden = true,
						vertical = "up:45%",
						horizontal = "right:55%",
					},
					border = conf.border,
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
					symbol_fmt = function(s)
						return s:lower() .. "\t"
					end,
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
		keys = {
			{
				"<leader>f",
				function()
					vim.cmd("FzfLua frecency cwd_only=true")
				end,
				desc = "files by frecency (picker)",
			},
		},
		opts = {
			display_score = false,
			cwd_prompt = true,
			winopts = {
				preview = { hidden = "nohidden" },
			},
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
		lazy = false,
		cmd = "Oil",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>e",
				function()
					require("oil").open()
				end,
				desc = "explorer (oil)",
			},
			{
				"<leader>E",
				function()
					require("oil").open_float()
				end,
				desc = "explorer float (oil)",
			},
		},
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
		opts = function()
			local detail = false
			return {
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
									conf.oil_columns.types,
									conf.oil_columns.permissions,
									conf.oil_columns.icon,
								})
							else
								require("oil").set_columns({ conf.oil_columns.icon })
							end
						end,
					},
				},
				columns = { conf.oil_columns.icon },
				float = {
					padding = 2,
					border = conf.border,
					max_width = math.floor(vim.api.nvim_win_get_width(0) * 0.7),
					max_height = math.floor(vim.api.nvim_win_get_height(0) * 0.6),
				},
				preview = { border = conf.border },
				progress = { border = conf.border },
				win_options = {
					number = false,
					relativenumber = true,
					signcolumn = "no",
					foldcolumn = "0",
					statuscolumn = "",
					colorcolumn = "",
				},
				keymaps_help = { border = conf.border },
				ssh = { border = conf.border },
				cleanup_delay_ms = false,
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				prompt_save_on_select_new_entry = true,
			}
		end,
		config = function(_, opts)
			require("oil").setup(opts)
		end,
	},
	{ -- (which-key.nvim) Keymapping cheatsheet
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>k",
				function()
					require("which-key").show()
				end,
				desc = "keymaps",
			},
		},
		opts = function()
			return {
				win = {
					border = conf.border,
					no_overlap = false,
					height = { min = 5, max = 25 },
				},
				delay = 400,
				icons = {
					separator = "▸",
					breadcrumb = "»",
					colors = false,
					mappings = false,
					rules = false,
				},
				show_help = false,
				sort = { "alphanum" },
			}
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.add({
				{ "<leader>", group = "leader commands" },
				{ "<leader>g", group = "git commands" },
				{ "<leader>gh", group = "git hunk actions" },
				{ "<leader>x", group = "extra commands" },
				{ "<leader>B", group = "blame window/line toggle" },
				{ "<leader>xd", group = "document symbols/diagnostics" },
				{ "<leader>w", group = "workspace symbols/diagnostics" },
				{ "<C-S>", group = "split windows" },
				{ "<C-W>", group = "windows" },
				{ "<C-T>", group = "tabpage new/close" },
				{ "[", group = "previous" },
				{ "]", group = "next" },
				{ "z", group = "folds, spelling & align" },
				{ "g", group = "symbol, comment, case & navigation" },
				{ "gs", group = "surround" },
				{ '"', group = "registers" },
				{ "`", group = "marks" },
				{ "'", group = "marks" },
				{ "gr", group = "symbol actions" },
				{ "<leader>d", group = "diffview commands" },
				{ "<leader>db", group = "DAP commands", cond = conf.dap_enabled },
				{ "<leader>n", group = "notes commands (zk)" },

				-- Rename of built-ins
				{ "<C-R>", desc = "redo" },
				{ "u", desc = "undo" },
				{ "P", desc = "paste above" },
				{ "p", desc = "paste below" },
			})
			if opts then
				wk.setup(opts)
			end
		end,
	},
	{ -- (gitsigns.nvim) blame and diff for git
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<leader>gs",
				function()
					vim.cmd("Gitsigns toggle_signs")
				end,
				desc = "gitdiff signs toggle",
			},
			{
				"[g",
				function()
					vim.cmd("Gitsigns prev_hunk")
				end,
				desc = "previous git hunk",
			},
			{
				"]g",
				function()
					vim.cmd("Gitsigns next_hunk")
				end,
				desc = "next git hunk",
			},
			{
				"<leader>ghp",
				function()
					vim.cmd("Gitsigns preview_hunk_inline")
				end,
				desc = "preview hunk inline",
			},
			{
				"<leader>ghs",
				function()
					vim.cmd("Gitsigns stage_hunk")
				end,
				desc = "stage hunk",
			},
			{
				"<leader>ghu",
				function()
					vim.cmd("Gitsigns undo_stage_hunk")
				end,
				desc = "undo stage hunk",
			},
			{
				"<leader>ghr",
				function()
					vim.cmd("Gitsigns reset_hunk")
				end,
				desc = "reset hunk",
			},
			{
				"<leader>Bl",
				function()
					vim.cmd("Gitsigns toggle_current_line_blame")
				end,
				desc = "blame virtual toggle",
			},
			{
				"<leader>Bw",
				function()
					vim.cmd("Gitsigns blame")
				end,
				desc = "blame window toggle",
			},
		},
		opts = function()
			return {
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
			}
		end,
		config = function(_, opts)
			if opts then
				require("gitsigns").setup(opts)
			end
		end,
	},
	{ -- (neogit) magit clone
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"m00qek/baleia.nvim",
				config = function()
					vim.g.baleia = require("baleia").setup({})
				end,
			},
		},
		keys = {
			{
				"<leader>gc",
				function()
					vim.cmd("Neogit commit kind=tab")
				end,
				desc = "neogit commits",
			},
			{
				"<leader>gl",
				function()
					vim.cmd("Neogit log kind=tab")
				end,
				desc = "neogit logs",
			},
			{
				"<leader>gb",
				function()
					vim.cmd("Neogit branch")
				end,
				desc = "neogit branches",
			},
			{
				"<leader>gg",
				function()
					vim.cmd("Neogit kind=tab")
				end,
				desc = "neogit",
			},
		},
		opts = function()
			return {
				git_services = {
					["g.beee.ps"] = "https://g.beee.ps/${owner}/${repository}/compare/master...${branch_name}?expand=1",
				},
				disable_context_highlighting = true,
				disable_line_numbers = true,
				disable_relative_line_numbers = true,
				disable_signs = false,
				disable_hint = true,
				graph_style = "unicode",
				fetch_after_checkout = true,
				auto_show_console_on = "error",
				console_timeout = 6000,
				log_pager = {
					"delta",
					"--width",
					"120",
					"--file-style",
					"omit",
					"--hunk-header-style",
					"omit",
				},
				commit_view = { kind = "replace" },
				commit_editor = { kind = "vsplit", staged_diff_split_kind = "vsplit" },
				integrations = { fzf_lua = true },
				signs = {
					hunk = { " ", " " },
					item = { "▸", "▾" },
					section = { " ", " " },
				},
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
		keys = {
			{
				"<leader>G",
				function()
					vim.cmd("GrugFar")
				end,
				desc = "grugfar",
			},
		},
		opts = {
			disableBufferLineNumbers = true,
			resultsSeparatorLineChar = "─",
			spinnerStates = conf.spinner,
			icons = {
				enabled = false,
			},
		},
	},
	{ -- (quicker.nvim) Quickfix list QOL
		"stevearc/quicker.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<leader>q",
				function()
					require("quicker").toggle()
				end,
				desc = "quickfix toggle",
			},
			{
				"<leader>l",
				function()
					require("quicker").toggle({ loclist = true })
				end,
				desc = "location list toggle",
			},
		},
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
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "collapse quickfix context",
				},
			},
		},
	},
	{ -- (overseer.nvim) Code runner
		"stevearc/overseer.nvim",
		dependencies = { "ibhagwan/fzf-lua" },
		keys = {
			{
				"<leader>O",
				function()
					vim.cmd("OverseerToggle")
				end,
				desc = "overseer toggle",
			},
			{
				"<leader>o",
				function()
					vim.cmd("OverseerRun")
				end,
				desc = "overseer run",
			},
		},
		opts = function()
			local default_win_opts = {
				border = conf.border,
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
	{ -- (aerial.nvim) code outline
		"stevearc/aerial.nvim",
		event = "BufReadPost",
		keys = {
			{
				"}",
				function()
					vim.cmd("AerialNext")
				end,
				desc = "next symbol",
			},
			{
				"{",
				function()
					vim.cmd("AerialPrev")
				end,
				desc = "previous symbol",
			},
			{
				"<leader>a",
				function()
					vim.cmd("AerialToggle")
				end,
				desc = "aerial toggle",
			},
		},
		opts = {
			icons = conf.lsp_kind_icons_padded,
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
			-- open_automatic = function(bufnr)
			-- 	local aerial = require("aerial")
			-- return vim.api.nvim_win_get_width(0) > 80
			-- 	and aerial.num_symbols(bufnr) > 6
			-- 	and not aerial.was_closed()
			-- 	and vim.api.nvim_buf_line_count(bufnr) > 80
			-- 	and not vim.g.pastemode
			-- end,
			show_guides = true,
			layout = {
				placement = "edge",
				close_on_select = false,
				max_width = 28,
				min_width = 28,
			},
		},
	},
	{ -- (diffview.nvim) Powerful diff and merge tool
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		keys = {
			{
				"<leader>dh",
				function()
					vim.cmd("DiffviewFileHistory")
				end,
				desc = "open diffview history",
			},
			{
				"<leader>dd",
				function()
					vim.cmd("DiffviewOpen")
				end,
				desc = "open diffview",
			},
			{
				"<leader>dc",
				function()
					vim.cmd("DiffviewClose")
				end,
				desc = "close diffview",
			},
		},
		opts = {
			signs = {
				fold_closed = "▸",
				fold_open = "▾",
				done = "✓",
			},
			file_panel = {
				listing_style = "list",
				win_config = {
					position = "left",
					width = 40,
					win_opts = {},
				},
			},
			use_icons = true,
			show_help_hints = false,
			enhanced_diff_hl = true,
		},
	},
	{ -- (git-conflict.nvim) Git conflicts helper
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre",
		keys = {
			{
				"co",
				"<Plug>(git-conflict-ours)",
				desc = "choose ours (conflict)",
			},
			{
				"ct",
				"<Plug>(git-conflict-theirs)",
				desc = "choose theirs (conflict)",
			},
			{
				"cb",
				"<Plug>(git-conflict-both)",
				desc = "choose both (conflict)",
			},
			{
				"cn",
				"<Plug>(git-conflict-none)",
				desc = "choose none (conflict)",
			},
			{
				"]x",
				"<Plug>(git-conflict-next-conflict)",
				desc = "next conflict",
			},
			{
				"[x",
				"<Plug>(git-conflict-prev-conflict)",
				desc = "previous conflict",
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
		opts = {
			highlight = "Comment",
			virt_text_pos = "eol",
		},
		config = function(_, opts)
			if opts then
				require("section-wordcount").setup(opts)
			end
			require("section-wordcount").wordcounter({})
		end,
	},
	{ -- (undotree) Undo tree plugins to make undotree friendlier
		"mbbill/undotree",
		keys = {
			{
				"<leader>u",
				function()
					vim.cmd("UndotreeToggle")
				end,
				desc = "undotree toggle",
			},
		},
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SplitWidth = 38
			vim.g.undotree_DiffpanelHeight = 6
			vim.g.undotree_DiffAutoOpen = 10
			vim.g.undotree_TreeVertShape = "┃"
		end,
	},
	{ -- (nvim-tree) Tree file
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = true,
		cmd = {
			"NvimTreeToggle",
		},
		keys = {
			{
				"<leader>T",
				function()
					vim.cmd("NvimTreeToggle")
				end,
				desc = "tree toggle",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
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
								unstaged = "N",
								staged = "S",
								unmerged = "U",
								renamed = "R",
								untracked = "U",
								deleted = "D",
								ignored = "I",
							},
						},
					},
					indent_markers = { enable = true },
				},
			})
			augroup("closeTreeOnExit", {
				{ "QuitPre" },
				{
					callback = function()
						local tree_wins = {}
						local floating_wins = {}
						local wins = vim.api.nvim_list_wins()
						for _, w in ipairs(wins) do
							local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
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
			require("nvim-tree.view").View.winopts.foldcolumn = "0"
			require("nvim-tree.view").View.winopts.cursorline = false
			require("nvim-tree.view").View.winopts.statuscolumn = ""
			require("nvim-tree.view").View.winopts.colorcolumn = ""
			require("nvim-tree.view").View.winopts.signcolumn = "no"
			require("nvim-tree.view").View.winopts.winhighlight = "Normal:CursorLine"
		end,
	},
}
