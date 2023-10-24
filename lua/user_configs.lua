local M = {}

M.dap_enabled = true
M.lsp_enabled = true
M.lsp_features = {
	show_usage = false
}
M.edit_features = {
	biscuits = true
}

M.frecency_workspaces = {
	["conf"] = "/home/lckdscl/.config",
	["scripts"] = "/home/lckdscl/scripts",
	["dot"] = "/home/lckdscl/dotfiles",
	["zsh"] = "/home/lckdscl/.config/zsh",
	["nvim"] = "/home/lckdscl/.config/nvim",
	["projects"] = "/home/lckdscl/projects",
	["go"] = "/home/lckdscl/projects/go",
	["bimbox"] = "/home/lckdscl/bimbox",
}

M.treesitter_sources = {
	"python",
	"html",
	"c",
	"cpp",
	"bibtex",
	"css",
	"json",
	"vim",
	"java",
	"javascript",
	"cmake",
	"latex",
	"lua",
	"markdown_inline",
	"bash",
	"diff",
	"dockerfile",
	"gitignore",
	"git_config",
	"gitcommit",
	"git_rebase",
	"ini",
	"passwd",
	"php",
	"rasi",
	"scss",
	"sxhkdrc",
	"yaml",
	"toml",
	"comment",
	"org",
	"rust",
	"xml",
	"go",
}

M.dap_signs = {
	Breakpoint = " ⚑",
	BreakpointCondition = " ⚑",
	LogPoint = " ★",
	Stopped = " ☛",
	BreakpointRejected = " ☒",
}

M.lsp_signs = { Error = "━━", Warn = "━━", Hint = "■", Info = "■" }

M.lsp_vt_signs = {
	[1] = "✗", -- ERROR
	[2] = "!", -- WARN
	[3] = "i", -- INFO
	[4] = "?", -- HINT
}

M.lsp_kind_icons = {
	Array = "☷",
	Boolean = "◕",
	Calendar = "◪",
	Class = "⁐",
	Collapsed = "▶",
	Color = "%",
	Constructor = "☂",
	Constant = "π",
	Copilot = "★",
	Enum = "ζ",
	EnumMember = "@",
	Event = "!",
	Field = "⊟",
	File = "⊡",
	Folder = "+",
	Function = "ƒ",
	Interface = "♺",
	Key = "*",
	Keyword = "★",
	Method = "ƒ",
	Module = "◫",
	Namespace = "ξ",
	Null = "∅",
	Number = "#",
	Object = "☁",
	Operator = "⁑",
	Package = "◫",
	Property = "✓",
	Reference = "⇒",
	Snippet = "★",
	String = "T",
	Struct = "◧",
	Table = "☷",
	Tag = "#",
	TypeParameter = "⊞",
	Variable = "Ψ",
	Text = "☰",
	Unit = "$",
	Value = "λ",
	Watch = "◔",
}

M.lsp_sources = {
	"clangd",
	"bashls",
	"jedi_language_server",
	"vimls",
	"cssls",
	"typst_lsp",
	"marksman",
	"ruff_lsp",
	"texlab",
	"lua_ls",
	"gopls",
}

M.null_formatting_sources = {
	"prettierd",
	"black",
	"shfmt",
	"mdformat",
	"bibclean",
	"stylua",
	"latexindent",
	"cbfmt",
}

M.null_hover_sources = {
	"dictionary",
}

M.null_diagnostics_sources = {
	"chktex",
	"cppcheck",
	"codespell",
	"vint",
	"revive",
	"proselint",
	"mypy",
	"pylint",
	"shellcheck",
}

M.null_code_action_sources = {
	"gitsigns",
	"proselint",
}

M.telescope_find_ignore = {
	"fd",
	"--type",
	"file",
	"--strip-cwd-prefix",
	"--follow",
	"--exclude",
	"*.png*",
	"--exclude",
	"*.PNG",
	"--exclude",
	"*.pdf",
	"--exclude",
	"*.jpeg",
	"--exclude",
	"*.jpg",
	"--exclude",
	"*.svg",
	"--exclude",
	"*.pm",
	"--exclude",
	"pictures",
}

M.starter_ascii =
"███╗   ██╗███████╗ ██████╗ ██████╗ ██╗███╗   ███╗\n████╗  ██║██╔════╝██╔═══██╗██╔══██╗██║████╗ ████║\n██╔██╗ ██║█████╗  ██║   ██║██████╔╝██║██╔████╔██║\n██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██║██║╚██╔╝██║\n██║ ╚████║███████╗╚██████╔╝██████╔╝██║██║ ╚═╝ ██║\n╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝     ╚═╝\n"

M.statusline_short_ft = {
	"lazy",
	"Trouble",
	"LuaTree",
	"dapui_scopes",
	"dapui_breakpoints",
	"dapui_repl",
	"vista",
	"qf",
	"dbui",
	"startify",
	"",
	"floaterm",
	"DiffviewFileHistoryPanel",
	"DiffviewFiles",
	"alpha",
	"man",
	"term",
	"nerdtree",
	"dashboard",
	"Packer",
	"NvimTree",
	"TelescopePrompt",
	"Help",
	"help",
	"diff",
	"undotree",
	"netrw",
	"plug",
	"Outline",
	"quickfix",
	"toggleterm",
	"NeogitStatus"
}

M.indent_scope_disabled_ft = {
	plugin = true,
	Outline = true,
	Trouble = true,
	[""] = true,
	help = true,
	toggleterm = true,
	lazy = true,
	TelescopePrompt = true,
	alpha = true,
	man = true,
	checkhealth = true,
	starter = true,
	markdownpreview = true,
	frecency = true,
	oil = true,
	i3config = true,
	toml = true,
	typst = true,
	config = true,
	NeogitStatus = true,
	NeogitCommitView = true,
	NeogitLogView = true,
}
M.indent_scope_hl = "#630e49"

return M
