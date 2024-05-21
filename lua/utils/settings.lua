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

-- Default options
set.autochdir = false
set.autoread = true
set.swapfile = false
set.path = set.path + "**"
set.history = 1000
set.undofile = true
set.undolevels = 500
set.encoding = "utf-8"

set.updatetime = 180
set.timeoutlen = 400
set.ttimeout = true
set.ttimeoutlen = 10

set.termguicolors = true
set.modeline = true
set.cursorline = true

set.laststatus = 3
set.cursorlineopt = "both"
set.hidden = true
set.showmode = false
set.showcmd = true
set.cmdheight = 0
set.ruler = true

-- Rendering
set.lazyredraw = false
set.ttyfast = true
set.conceallevel = 2

-- Tabline
set.showtabline = 0

set.winblend = 0
set.pumblend = 0
set.pumheight = 15
set.pumwidth = 15

set.iskeyword:append("-")
set.nrformats:append("unsigned")
set.nrformats:remove("bin", "hex")
set.mouse = "a"
set.backspace = { "indent", "eol", "start" }

set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = ""
set.foldlevel = 99
set.foldlevelstart = 1
set.foldminlines = 1
set.foldnestmax = 4

-- Signcolumn
set.foldcolumn = "auto:1"
set.number = true
set.relativenumber = true
set.signcolumn = "auto:1"

set.splitbelow = true
set.splitright = true
set.synmaxcol = 400
set.scrolljump = 1
set.sidescrolloff = 5
set.scrolloff = 1
set.wrap = true
set.whichwrap = set.whichwrap + "<>[]hl"
set.wrapmargin = 0
set.textwidth = 0
set.linebreak = true
set.virtualedit = "block"
set.completeopt = { "menu", "menuone", "noselect", "noinsert" }
set.shortmess = set.shortmess + "OosatTcI"

set.hlsearch = true
set.ignorecase = true
set.infercase = true
set.incsearch = true
set.smartcase = true
set.showmatch = true
set.matchtime = 1

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

set.spelllang = "en_gb"
set.spell = false
set.spelloptions = "camel"

set.list = false
set.selection = "old"
set.showbreak = "↳"
set.fillchars = {
	eob = " ",
	vert = "│",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = "│",
	fold = " ",
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
