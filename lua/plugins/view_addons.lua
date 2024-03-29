local autocmd = vim.api.nvim_create_autocmd
local groupid = vim.api.nvim_create_augroup
local opt_local = vim.opt_local
local wo = vim.wo
---@param group string
---@vararg { [1]: string|string[], [2]: vim.api.keyset.create_autocmd }
---@return nil
local function augroup(group, ...)
	local id = groupid(group, { clear = true })
	for _, a in ipairs({ ... }) do
		a[2].group = id
		autocmd(unpack(a))
	end
end

-- Plugins which add additional ways to use nvim
return {
	{
		-- Navigation and fuzzy pickers
		"ibhagwan/fzf-lua",
		lazy = true,
		keys = {
			{
				"<leader>h",
				"<cmd>FzfLua oldfiles<cr>",
				desc = "Browse history",
			},
			{
				"<leader>l",
				"<cmd>FzfLua resume<cr>",
				desc = "Resume last picker",
			},
			{
				"<leader>t",
				"<cmd>FzfLua builtin<cr>",
				desc = "FzfLua Builtin",
			},
			{
				"<leader>b",
				"<cmd>FzfLua buffers<cr>",
				desc = "Buffers",
			},
			{
				"<leader>f",
				"<cmd>FzfLua files<cr>",
				desc = "Find files",
			},
			{
				"<leader>z",
				"<cmd>lua require('fzf.fzf_zoxide').exec()<cr>",
				desc = "Zoxide",
			},
			{
				"<leader>c",
				"<cmd>FzfLua lsp_document_symbols<cr>",
				desc = "Document code symbols",
			},
			{
				"<leader>w",
				"<cmd>FzfLua lsp_workspace_diagnostics<cr>",
				desc = "Workspace diagnostics",
			},
			{
				"<leader>gC",
				"<cmd>FzfLua git_bcommits<cr>",
				desc = "Buffer git commits",
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
				"<cmd>FzfLua live_grep_native<cr>",
				desc = "Grep workspace",
			},
			{
				"<leader><bslash>",
				"<cmd>FzfLua lgrep_curbuf<cr>",
				desc = "Grep buffer",
			},
			{
				"<leader>qd",
				"<cmd>FzfLua lsp_definitions<cr>",
				desc = "Symbol definitions",
			},
			{
				"<leader>qr",
				"<cmd>FzfLua lsp_references<cr>",
				desc = "Symbol references",
			},
			{
				"<leader>qi",
				"<cmd>FzfLua implementations<cr>",
				desc = "Symbol implementation",
			},
			{
				"<leader>qt",
				"<cmd>FzfLua type_defs<cr>",
				desc = "Symbol type definitions",
			},
			{
				"<leader>qD",
				"<cmd>FzfLua declarations<cr>",
				desc = "Symbol declarations",
			},
		},
		opts = function()
			local function picker_opts(str)
				return {
					prompt = " ➤ ",
					winopts = {
						title = " " .. str .. " ",
						title_pos = "center",
					},
				}
			end
			return {
				commands = { sort_lastused = true },
				manpages = { previewer = "man_native" },
				helptags = { previewer = "help_native" },
				defaults = {
					git_icons = false,
					file_icons = false,
				},
				fzf_opts = { ["--margin"] = "0,0", ["--info"] = "inline-right" },
				winopts = {
					width = 0.87,
					height = 0.80,
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
					tab_marker = "Directory",
					tab_title = "Directory",
					buf_name = "Character",
					buf_nr = "Character",
					buf_flag_cur = "Boolean",
					buf_flag_alt = "Constant",
					live_sym = "Boolean",
				},
				fzf_colors = {
					["fg"] = { "fg", "TelescopeNormal" },
					["bg"] = { "bg", "TelescopeNormal" },
					["hl"] = { "fg", "TelescopeMatching" },
					["fg+"] = { "fg", "TelescopeSelection" },
					["bg+"] = { "bg", "TelescopeSelection" },
					["hl+"] = { "fg", "TelescopeMatching" },
					["info"] = { "fg", "TelescopeNormal" },
					["border"] = { "fg", "TelescopeBorder" },
					["gutter"] = { "bg", "TelescopeNormal" },
					["prompt"] = { "fg", "TelescopePromptPrefix" },
					["pointer"] = { "fg", "TelescopeSelectionCaret" },
					["marker"] = { "fg", "Directory" },
					["header"] = { "fg", "Boolean" },
				},
				files = {
					fzf_opts = { ["--ansi"] = false },
					winopts = {
						title = " Find files ",
						title_pos = "center",
					},
				},
				git = {
					files = picker_opts("Git files"),
					status = picker_opts("Git status"),
					commits = picker_opts("Git commits"),
					bcommits = picker_opts("Git buffer commits"),
					branches = picker_opts("Git branches"),
					tags = picker_opts("Git tags"),
					stash = picker_opts("Git stash"),
				},
				grep = picker_opts("Live grep"),
				args = picker_opts("Argument list"),
			}
		end,
		config = function(_, opts)
			require("fzf-lua").setup(opts)
		end,
	},
	{
		-- Terminal panel
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = "ToggleTerm",
		keys = {
			{
				"<C-Bslash>",
				function()
					local exec = vim.api.nvim_command
					if vim.api.nvim_win_get_width(0) >= 150 then
						exec("ToggleTerm direction=vertical")
					else
						exec("ToggleTerm direction=horizontal")
					end
				end,
				desc = "Terminal",
			},
		},
		opts = {
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
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			augroup("toggleterm", {
				{ "TermOpen" },
				{
					pattern = "term://*",
					callback = function()
						local opts_b = { silent = true, buffer = 0 }
						vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts_b)
						vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts_b)
						vim.keymap.set("t", "<C-Bslash>", [[<C-\><C-n>:ToggleTerm<CR>]], opts_b)
					end,
				},
			})
		end,
	},
	{
		-- Distraction-free editing mode
		"folke/zen-mode.nvim",
		lazy = true,
		keys = {
			{
				"<C-M>z",
				"<cmd>ZenMode<cr>",
				desc = "Toggle Zen Mode",
			},
		},
		cmd = "ZenMode",
		dependencies = { "twilight.nvim", lazy = true, cmd = "Twilight" },
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
		event = "BufReadPre",
		keys = {
			{
				"<C-P>",
				"<cmd>WhichKey<cr>",
				desc = "List all keymaps",
			},
		},
		opts = {
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
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.register({
				["<leader>"] = { name = "Leader commands (pickers & LSP)" },
				["<space>"] = { ":", "Command", mode = { "n", "v" } },
				["<leader>o"] = { name = "Org mode actions" },
				["<leader>g"] = { name = "Git commands" },
				["<leader>d"] = { name = "DAP commands" },
				["<leader>q"] = { name = "LSP commands" },
				["<C-M>"] = { name = "Toggle components" },
				["<C-S>"] = { name = "Split windows" },
				["["] = { name = "Previous" },
				["]"] = { name = "Next" },
				["z"] = { name = "Folds, spelling & align" },
				["g"] = { name = "Comment, case & navigation" },
			})
			wk.setup(opts)
		end,
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
		opts = function()
			local starter_ok, starter = pcall(require, "mini.starter")
			if not starter_ok then
				return
			end
			local org_agenda = function()
				require("orgmode").action("agenda.prompt")
			end
			local quick = function()
				return function()
					local quick_tbl = {
						{ action = "Lazy show", name = "Plugins", section = "Quick actions" },
					}
					if require("user_configs").syntax_features.org then
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
				local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

				return ("Good %s, %s."):format(day_part, username)
			end
			local footer = function()
				local stats = require("lazy").stats()
				return "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins"
			end
			local version = function()
				local versioninfo = vim.version() or {}
				local major = versioninfo.major or ""
				local minor = versioninfo.minor or ""
				local patch = versioninfo.patch or ""
				local prerelease = versioninfo.api_prerelease and "-dev" or ""
				local version = ("NVIM v%s.%s.%s%s"):format(major, minor, patch, prerelease)
				return version
			end
			return {
				items = {
					starter.sections.recent_files(5, true, false),
					starter.sections.recent_files(3, false, false),
					quick(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				footer = "",
				header = require("user_configs").starter_ascii .. greetings(),
			}
		end,
		config = function(_, opts)
			require("mini.starter").setup(opts)
		end,
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		keys = {
			{
				"<leader>gg",
				"<cmd>Neogit kind=auto<cr>",
				desc = "Neogit",
			},
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
		config = function(_, opts)
			require("neogit").setup(opts)
			augroup("neogit", {
				{ "Filetype" },
				{
					pattern = "Neogit*",
					callback = function()
						opt_local.list = false
						wo.foldcolumn = "0"
						wo.relativenumber = true
					end,
				},
			})
		end,
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
		event = "BufReadPre",
		opts = {
			notificationOnAutoClose = true,
		},
	},
	{
		-- Disable features on big files
		"pteroctopus/faster.nvim",
	},
}
