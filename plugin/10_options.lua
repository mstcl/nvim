-- Configure builtin vim options
local g = vim.g
local o = vim.opt
local config = _G.config

g.mapleader = ","
g.maplocalleader = ",."

-- Disable plugins
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_netrw = 1
g.loaded_netrw_nogx = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_tar = 1
g.loaded_matchparen = 1
g.loaded_tarPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimballPlugin = 1
---@diagnostic disable-next-line: assign-type-mismatch
g.loaded_2html_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_matchit = 1
g.loaded_tutor = 1
g.loaded_tohtml = 1

-- Disable providers
g.loaded_python_provider = false
g.loaded_ruby_provider = false
g.loaded_node_provider = false
g.loaded_perl_provider = false

-- Use filetype.lua
g.do_filetype_lua = true

-- Vim syntax options
g["vimsyn_embed"] = "l"
g["tex_flavor"] = "latex"
g["tex_fold_enabled"] = "1"
g["tex_conceal"] = "abdgms"
g.markdown_enable_mappings = 1
g.markdown_enable_insert_mode_leader_mappings = 0
g.markdown_enable_insert_mode_mappings = 0
g.markdown_mapping_switch_status = "<C-space>"
g.markdown_enable_conceal = 1
g.markdown_enable_folding = 0

-- Files
o.autowriteall = true
o.autochdir = false
o.autoread = true
o.swapfile = false
o.path = o.path + "**"
o.history = 1000
o.undofile = true
o.undolevels = 500 -- save a lot of undo steps
o.encoding = "utf-8"
o.modeline = true
o.modelines = 1
o.shada = "'100,<50,s10,:1000,/100,@100,h" -- limit shada file

-- Ticks
o.updatetime = 180
o.timeoutlen = 400 -- generous enough for ssh sessions
o.ttimeout = true
o.ttimeoutlen = 10

-- Cursorline
o.cursorline = true
o.cursorlineopt = "number"

-- UI components
o.report = 1000000000
o.hidden = true
o.showmode = false
o.showcmd = false
o.showcmdloc = "statusline"
o.laststatus = 3
o.cmdheight = 0
o.ruler = true
o.showtabline = 1

-- Rendering
o.lazyredraw = false
o.ttyfast = true
o.conceallevel = 2
o.winblend = 0
o.termguicolors = true
o.guicursor =
	"n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"
o.synmaxcol = 400
o.winborder = config.border

-- Pum
o.pumblend = 0
o.pumheight = 15
o.pumwidth = 15

-- Hacks
---@diagnostic disable: undefined-field
o.iskeyword:append("-")
o.nrformats:append("unsigned")
o.nrformats:remove("bin", "hex")

-- Editing
o.virtualedit = "onemore"
o.mouse = "a"
o.backspace = { "indent", "eol", "start" }
o.virtualedit = "block"
o.selection = "old"
o.formatoptions = "rqnl1j" -- improve comment editing
o.iskeyword = "@,48-57,_,192-255,-" -- treat dash as `word` textobject part
o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]] -- Pattern for a start of numbered list (used in `gw`). This reads as

-- Folding (foldtext is set in 53_foldtext.lua)
o.foldcolumn = "auto"
o.foldmethod = "expr"
o.foldlevel = 99

-- number/sign/status column
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.shortmess = o.shortmess + "OosatTcCFSW"

-- Window
g.health = { style = "float" }
o.splitkeep = "screen" -- less jarring splitting
o.splitbelow = true
o.splitright = true
o.jumpoptions = "stack,view"
o.viewoptions = "folds,cursor,unix,curdir"
o.tabclose = "left"
o.switchbuf = "usetab" -- use already opened buffers when switching

-- Scrolling
o.scrolljump = 1
o.sidescrolloff = 5
o.scrolloff = 3

-- Wrap & textwidth
o.wrap = false
o.whichwrap = o.whichwrap + "<>[]hl"
o.wrapmargin = 0
o.textwidth = 88
o.colorcolumn = "88"
o.linebreak = true

-- Completion
o.completeopt = "menu,menuone,noselect,noinsert"
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildoptions = "pum"

-- Searching
o.inccommand = "split" -- split when s/find/replace
o.hlsearch = true
o.ignorecase = true
o.infercase = true
o.incsearch = true
o.smartcase = true
o.showmatch = true
o.matchtime = 1

-- Indentation
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = false
o.smarttab = true
o.autoindent = true
o.shiftround = true
o.smartindent = false
o.breakindent = true
o.breakindentopt = "list:-1"
o.copyindent = true

-- Spell
o.spelllang = "en_gb"
o.spell = false
o.spelloptions = "camel"

-- Special characters
o.list = true
o.showbreak = "" -- we have fancy wrapped status column so don't need this
o.fillchars = {
	eob = " ",
	vert = "│",
	foldclose = config.signs.close,
	foldopen = config.signs.open,
	foldsep = " ",
	foldinner = " ",
	fold = " ",
	diff = "╱",
}
o.listchars = {
	tab = "  »",
	extends = "›",
	precedes = "‹",
	nbsp = "∩",
	eol = "¬",
	trail = "×",
	lead = " ",
	space = "·",
	multispace = "···+",
}

---@diagnostic disable-next-line: param-type-not-match
-- Configure builtin diagnostics
local lsp_status_signs = {
	[vim.diagnostic.severity.ERROR] = config.signs.lsp.Error,
	[vim.diagnostic.severity.WARN] = config.signs.lsp.Warn,
	[vim.diagnostic.severity.INFO] = config.signs.lsp.Info,
	[vim.diagnostic.severity.HINT] = config.signs.lsp.Hint,
}

local lsp_status_hl_map = {
	[vim.diagnostic.severity.ERROR] = "DiagnosticError",
	[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
	[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
	[vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

vim.diagnostic.config({
	---@type vim.diagnostic.Opts
	virtual_lines = false,
	virtual_text = false,
	underline = false,
	update_in_insert = false,
	severity_sort = true,

	signs = {},

	status = {
		format = function(severity_counts)
			local items = {}
			for severity in ipairs(vim.diagnostic.severity) do
				local count = severity_counts[severity] or 0
				if count ~= 0 then
					table.insert(
						items,
						("%%#%s#%s:%s"):format(
							lsp_status_hl_map[severity],
							lsp_status_signs[severity],
							count
						)
					)
				end
			end
			return table.concat(items, " ")
		end,
	},

	float = {
		close_events = {
			"BufLeave",
			"CursorMoved",
			"InsertEnter",
			"FocusLost",
		},
		border = config.border,
		source = "always",
		focus = false,
	},
})

-- Test the new experimental UI2
_G.helpers.now(function()
	if vim.version.ge(vim.version(), { 0, 12, 0 }) then
		require("vim._core.ui2").enable({
			enable = true,
			msg = {
				targets = {
					[""] = "msg",
					empty = "msg",
					bufwrite = "msg",
					echo = "msg",
					echomsg = "msg",
					shell_ret = "msg",
					undo = "msg",
					wmsg = "msg",
					completion = "msg",
					confirm = "dialog",
					confirm_sub = "dialog",
					echoerr = "msg",
					emsg = "msg",
					list_cmd = "pager",
					lua_error = "msg",
					lua_print = "msg",
					progress = "msg",
					quickfix = "msg",
					rpc_error = "msg",
					search_cmd = "msg",
					search_count = "msg",
					shell_cmd = "msg",
					shell_err = "msg",
					shell_out = "msg",
					typed_cmd = "msg",
					verbose = "pager",
					wildlist = "msg",
				},
				cmd = { height = 0.5 },
				dialog = { height = 0.5 },
				msg = { height = 0.5, timeout = 2000 },
				pager = { height = 0.8 },
			},
		})
	end
end)
