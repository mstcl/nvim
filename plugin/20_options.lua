vim.g.mapleader = ","
vim.g.maplocalleader = ",."

-- Providers for nvim
vim.g.loaded_python_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_node_provider = false
vim.g.loaded_perl_provider = false

-- Use filetype.lua
vim.g.do_filetype_lua = true

-- Globals
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
vim.opt.cmdheight = 0
vim.opt.ruler = true
vim.opt.showtabline = 0

-- Rendering
vim.opt.lazyredraw = false
vim.opt.ttyfast = true
vim.opt.conceallevel = 2
vim.opt.winblend = 0
vim.opt.termguicolors = true
vim.opt.synmaxcol = 400
vim.opt.virtualedit = "block"
vim.opt.selection = "old"
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

-- Keys
vim.opt.mouse = "a"
vim.opt.backspace = { "indent", "eol", "start" }

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 3
vim.opt.foldminlines = 1
vim.opt.foldnestmax = 4

-- Statuscolumn
vim.opt.laststatus = 3
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

-- Scrolling
vim.opt.scrolljump = 1
vim.opt.sidescrolloff = 5
vim.opt.scrolloff = 3

-- Wrap & textwidth
vim.opt.wrap = false
vim.opt.whichwrap = vim.opt.whichwrap + "<>[]hl"
vim.opt.wrapmargin = 0
vim.opt.textwidth = 0
vim.opt.colorcolumn = "80"
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
vim.opt.copyindent = true

-- Spell
vim.opt.spelllang = "en_gb"
vim.opt.spell = false
vim.opt.spelloptions = "camel"

-- Non-text characters
vim.opt.list = false
vim.opt.showbreak = "↪"
vim.opt.fillchars = {
	eob = " ",
	vert = "│",
	foldclose = _G.config.signs.fold_closed,
	foldopen = _G.config.signs.fold_open,
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
