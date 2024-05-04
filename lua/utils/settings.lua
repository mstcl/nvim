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
set.background = "light"
set.modeline = true
set.cursorline = true

-- Statusline components
local statusline_parts = {
	-- Highlights
	hl_main = [[%#statuslinenc#]],
	hl_strong = [[%#statusline#]],
	hl_alt = [[%#statuslinealt#]],
	hl_orange = [[%#statuslineorange#]],
	hl_restore = [[%*]],
	-- LSP
	diagnostics = [[%{%v:lua.require'utils.statusline'.get_lsp_diagnostic()%}]],
	progress = [[%{%v:lua.require'utils.statusline'.get_lsp_progress()%}]],
	-- Git
	branch = [[%{%v:lua.require'utils.statusline'.get_git_branch()%}]],
	diffs = [[%{%v:lua.require'utils.statusline'.get_diffs()%}]],
	-- Misc
	align = [[%=]],
	truncate = [[%<]],
	open_bracket = [[(]],
	close_bracket = [[)]],
	padding = [[ ]],
	-- General
	filename = [[%{%&ft=="toggleterm"?"terminal #".b:toggle_number."":"%t"%}]],
	pos = [[%{%&ru?" %l:%c %2p%% ":""%}]],
	mode = [[%{%v:lua.require'utils.statusline'.get_mode()%}]],
	cwd = [[%{%v:lua.require'utils.statusline'.get_cwd()%}]],
	indentation = [[%{&expandtab?"shift:":"tab:"} %{&shiftwidth}]],
	ft = [[%{&ft!=""?"".&ft." ":"nil "}]],
	fformat = [[%{&ff!="unix"?"  ".&ff." ":""}]],
	fenc = [[%{(&fenc!="utf-8"&&&fenc!="")?"  ".&fenc." ":""}]],
}
set.statusline = table.concat({
	statusline_parts.mode,
	statusline_parts.hl_strong,
	statusline_parts.filename,
	statusline_parts.hl_main,
	statusline_parts.padding,
	statusline_parts.open_bracket,
	statusline_parts.ft,
	statusline_parts.branch,
	statusline_parts.hl_main,
	statusline_parts.diffs,
	statusline_parts.hl_main,
	statusline_parts.close_bracket,
	statusline_parts.align,
	statusline_parts.hl_alt,
	statusline_parts.progress,
	statusline_parts.hl_main,
	statusline_parts.diagnostics,
	statusline_parts.hl_orange,
	statusline_parts.truncate,
	statusline_parts.fformat,
	statusline_parts.fenc,
	statusline_parts.hl_alt,
	statusline_parts.align,
	statusline_parts.pos,
	statusline_parts.padding,
	statusline_parts.indentation,
	statusline_parts.padding,
	statusline_parts.cwd,
	statusline_parts.padding,
	statusline_parts.hl_restore,
}, "")
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
if require("user_configs").ui_features.tabline then
	set.showtabline = 2
else
	set.showtabline = 0
end

set.winblend = 0
set.pumblend = 0
set.pumheight = 15
set.pumwidth = 15

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

-- Signcolumn
set.foldcolumn = "auto:1"
set.number = true
set.relativenumber = true
set.signcolumn = "auto:1"

set.splitbelow = true
set.splitright = true
set.colorcolumn = "80"
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
