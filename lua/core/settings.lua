-- DEFAULT settings

local set = vim.opt

-- Providers for nvim
vim.g.python3_host_prog = vim.fn.expand("$HOME/.config/nvim/.venv/bin/python")
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
set.autochdir = false
set.autoread = true
set.swapfile = false
set.path = set.path + "**"
set.history = 1000
set.undofile = true
set.undolevels = 500
set.encoding = "utf-8"
set.modeline = true
set.modelines = 1

-- Ticks
set.updatetime = 180
set.timeoutlen = 400
set.ttimeout = true
set.ttimeoutlen = 10

-- Cursorline
set.cursorline = true
set.cursorlineopt = "number"

-- Bars
set.hidden = true
set.showmode = false
set.showcmd = true
set.cmdheight = 0
set.ruler = true
set.showtabline = 0

-- Rendering
set.lazyredraw = false
set.ttyfast = true
set.conceallevel = 2
set.winblend = 0
set.termguicolors = true
set.synmaxcol = 400
set.virtualedit = "block"
set.selection = "old"

-- Pum
set.pumblend = 0
set.pumheight = 15
set.pumwidth = 15

-- Hacks
set.iskeyword:append("-")
set.nrformats:append("unsigned")
set.nrformats:remove("bin", "hex")

-- Keys
set.mouse = "a"
set.backspace = { "indent", "eol", "start" }

-- Folding
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = ""
set.foldlevel = 99
set.foldlevelstart = 3
set.foldminlines = 1
set.foldnestmax = 4

-- Statuscolumn
vim.g.foldcolumn = true
set.number = true
set.relativenumber = true
set.signcolumn = "auto"
set.shortmess = set.shortmess + "OosatTcICFSW"

-- Window
set.splitkeep = "screen" -- less jarring splitting
set.splitbelow = true
set.splitright = true
set.jumpoptions = "stack,view"

-- Scrolling
set.scrolljump = 1
set.sidescrolloff = 5
set.scrolloff = 1

-- Wrap & textwidth
set.wrap = true
set.whichwrap = set.whichwrap + "<>[]hl"
set.wrapmargin = 0
set.textwidth = 0
set.colorcolumn = "0"
set.linebreak = true

-- Completion
set.completeopt = { "menu", "menuone", "noselect", "noinsert" }
set.wildmenu = true
set.wildmode = "longest:full,full"
set.wildoptions = "pum"

-- Searching
set.inccommand = "split" -- split when s/find/replace
set.hlsearch = true
set.ignorecase = true
set.infercase = true
set.incsearch = true
set.smartcase = true
set.showmatch = true
set.matchtime = 1

-- Indentation
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = false
set.smarttab = true
set.autoindent = true
set.shiftround = true
set.smartindent = false
set.breakindent = true
set.copyindent = true

-- Spell
set.spelllang = "en_gb"
set.spell = false
set.spelloptions = "camel"

-- Non-text characters
set.list = false
set.showbreak = "↪"
set.fillchars = {
	eob = " ",
	vert = "│",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = "│",
	fold = "·",
	diff = "╱",
}
set.listchars = {
	tab = "  ▸",
	extends = "›",
	precedes = "‹",
	nbsp = "∩",
	eol = "¶",
	trail = "×",
	lead = " ",
	space = "·",
	multispace = "···+",
}
