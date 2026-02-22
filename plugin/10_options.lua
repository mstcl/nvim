vim.g.mapleader = ","
vim.g.maplocalleader = ",."

-- Disable plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrw_nogx = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimballPlugin = 1
---@diagnostic disable-next-line: assign-type-mismatch
vim.g.loaded_2html_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_tutor = 1
vim.g.loaded_tohtml = 1

-- Disable providers
vim.g.loaded_python_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_node_provider = false
vim.g.loaded_perl_provider = false

-- Use filetype.lua
vim.g.do_filetype_lua = true

-- Vim syntax options
vim.g["vimsyn_embed"] = "l"
vim.g["tex_flavor"] = "latex"
vim.g["tex_fold_enabled"] = "1"
vim.g["tex_conceal"] = "abdgms"
vim.g.markdown_enable_mappings = 1
vim.g.markdown_enable_insert_mode_leader_mappings = 0
vim.g.markdown_enable_insert_mode_mappings = 0
vim.g.markdown_mapping_switch_status = "<C-space>"
vim.g.markdown_enable_conceal = 1
vim.g.markdown_enable_folding = 0

-- Files
vim.opt.autochdir = false
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.path = vim.opt.path + "**"
vim.opt.history = 1000
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.encoding = "utf-8"
vim.opt.modeline = true
vim.opt.modelines = 1
vim.opt.shada = "'100,<50,s10,:1000,/100,@100,h" -- limit shada file

-- Ticks
vim.opt.updatetime = 180
vim.opt.timeoutlen = 400
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10

-- Cursorline
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- UI components
vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.showcmdloc = "statusline"
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.ruler = true
vim.opt.showtabline = 1

-- Rendering
vim.opt.lazyredraw = false
vim.opt.ttyfast = true
vim.opt.conceallevel = 2
vim.opt.winblend = 0
vim.opt.termguicolors = true
vim.opt.guicursor =
	"n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"
vim.opt.synmaxcol = 400
vim.opt.winborder = _G.config.border

-- Pum
vim.opt.pumblend = 0
vim.opt.pumheight = 15
vim.opt.pumwidth = 15

-- Hacks
---@diagnostic disable: undefined-field
vim.opt.iskeyword:append("-")
vim.opt.nrformats:append("unsigned")
vim.opt.nrformats:remove("bin", "hex")

-- Editing
vim.opt.mouse = "a"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.virtualedit = "block"
vim.opt.selection = "old"
vim.opt.formatoptions = "rqnl1j" -- improve comment editing
vim.opt.iskeyword = "@,48-57,_,192-255,-" -- treat dash as `word` textobject part
vim.opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]] -- Pattern for a start of numbered list (used in `gw`). This reads as

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99

-- number/sign/status column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.shortmess = vim.opt.shortmess + "OosatTcCFSW"

-- Window
vim.opt.splitkeep = "screen" -- less jarring splitting
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.jumpoptions = "stack,view"
vim.opt.viewoptions = "folds,cursor,unix,curdir"
vim.go.tabclose = "left"
vim.opt.switchbuf = "usetab" -- use already opened buffers when switching

-- Scrolling
vim.opt.scrolljump = 1
vim.opt.sidescrolloff = 5
vim.opt.scrolloff = 3

-- Wrap & textwidth
vim.opt.wrap = false
vim.opt.whichwrap = vim.opt.whichwrap + "<>[]hl"
vim.opt.wrapmargin = 0
vim.opt.textwidth = 0
vim.opt.colorcolumn = "88"
vim.opt.linebreak = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"

-- Searching
vim.opt.inccommand = "split" -- split when s/find/replace
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.matchtime = 1

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.shiftround = true
vim.opt.smartindent = false
vim.opt.breakindent = true
vim.opt.breakindentopt = "list:-1"
vim.opt.copyindent = true

-- Spell
vim.opt.spelllang = "en_gb"
vim.opt.spell = false
vim.opt.spelloptions = "camel"

-- Special characters
vim.opt.list = true
vim.opt.showbreak = "↪"
vim.opt.fillchars = {
	eob = " ",
	vert = "│",
	foldclose = _G.config.signs.close,
	foldopen = _G.config.signs.open,
	foldsep = "│",
	fold = "·",
	diff = "╱",
}
vim.opt.listchars = {
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
vim.diagnostic.config({
	---@type vim.diagnostic.Opts
	virtual_lines = false,
	virtual_text = false,
	underline = false,
	update_in_insert = false,
	severity_sort = true,

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},

	status = {
		text = {
			[vim.diagnostic.severity.ERROR] = _G.config.signs.lsp.Error,
			[vim.diagnostic.severity.WARN] = _G.config.signs.lsp.Warn,
			[vim.diagnostic.severity.INFO] = _G.config.signs.lsp.Info,
			[vim.diagnostic.severity.HINT] = _G.config.signs.lsp.Hint,
		},
	},

	float = {
		close_events = {
			"BufLeave",
			"CursorMoved",
			"InsertEnter",
			"FocusLost",
		},
		border = _G.config.border,
		source = "always",
		focus = false,
	},
})
