local set = vim.opt
local vt_signs = require("user_configs").lsp_vt_signs

-- Globals
vim.g.mapleader = ","
vim.g.maplocalleader = ",."

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
set.background = "light"
set.modeline = true
set.cursorline = true
-- set.cursorlineopt = "number"
set.hidden = true
set.showmode = false
set.showcmd = true
set.cmdheight = 0
set.lazyredraw = false
set.ttyfast = true
set.conceallevel = 2
if require("user_configs").ui_features.tabline then
	set.showtabline = 2
else
	set.showtabline = 0
end
set.laststatus = 3
set.ruler = false
set.winblend = 0
set.pumblend = 0
set.pumheight = 15
set.pumwidth = 15
set.number = true
set.relativenumber = true

set.iskeyword:append("-")
set.nrformats:append("unsigned")
set.nrformats:remove("bin", "hex")
set.pastetoggle = "<F2>"
set.clipboard = "unnamedplus"
set.mouse = "a"
set.backspace = { "indent", "eol", "start" }

set.foldmethod = "syntax"
set.foldminlines = 1
set.foldnestmax = 6
set.foldenable = true
set.foldlevelstart = 99
set.foldlevel = 99
set.foldcolumn = "auto:1"

set.signcolumn = "auto:1"
set.splitbelow = true
set.splitright = true
set.colorcolumn = "88"
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

set.list = true
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

-- Builtin diagnostics
vim.diagnostic.config({
	inlay_hints = {
		enabled = true,
	},
	virtual_text = {
		enabled = true,
		spacing = 4,
		prefix = "",
		format = function(diagnostic)
			return string.format(vt_signs[diagnostic.severity])
		end,
		suffix = " ",
	},
	signs = true, -- only for the colored number column
	underline = false,
	update_in_insert = false,
	float = {
		header = false,
		focusable = false,
		prefix = " ",
		suffix = " ",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "single",
		source = "if_many",
		scope = "cursor",
		focus = false,
	},
	severity_sort = true,
})

vim.cmd([[
sign define DiagnosticSignError text=
sign define DiagnosticSignWarn text=
sign define DiagnosticSignInfo text=
sign define DiagnosticSignHint text=
sign define DiagnosticSignWarn text=
sign define DiagnosticSignInfo text=
sign define DiagnosticSignHint text=
]])
