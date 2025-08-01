local M = {}

M.dev_plugins = {
	"dmg",
	"ivory",
}

M.dap_enabled = false
M.lsp_enabled = true
M.lsp_features = {
	virtual_text = false,
	inlay_hints = false,
}
M.edit_features = {
	completion = true, -- completion by default
	flash = false,
	retirement = false,
}

M.ui_features = {
	animate = false,
	indent_lines = true, -- indentscope enabled by default
	tabline = false,
	incline = false,
	starter = false,
}

M.syntax_features = {
	typst = false,
	quarto = false,
	tex = false,
	markdown = true,
	notebook = false,
}

M.frecency_workspaces = {}

M.treesitter_sources = {
	"python",
	"html",
	"c",
	"cpp",
	"bibtex",
	"json",
	"json5",
	"hjson",
	"vim",
	"java",
	"cmake",
	"ssh_config",
	"latex",
	"lua",
	"markdown_inline",
	"markdown",
	"bash",
	"diff",
	"dockerfile",
	"gitignore",
	"git_config",
	"gitcommit",
	"git_rebase",
	"regex",
	"ini",
	"muttrc",
	"passwd",
	"php",
	"rasi",
	"sxhkdrc",
	"yaml",
	"toml",
	"comment",
	"org",
	"rust",
	"xml",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"gotmpl",
	"make",
	"terraform",
	"query",
	"sql",
	"printf",
}

M.dap_signs = {
	Breakpoint = "⚑",
	BreakpointCondition = "⚑",
	LogPoint = "★",
	Stopped = "☛",
	BreakpointRejected = "☒",
}

M.lsp_signs = {
	Error = "*",
	Warn = "!",
	Hint = "?",
	Info = "i",
}

M.lsp_vt_signs = {
	[1] = "ERROR", -- ERROR
	[2] = "WARN", -- WARN
	[3] = "INFO", -- INFO
	[4] = "HINT", -- HINT
}

M.lsp_kind_icons = {
	Array = "※",
	Boolean = "B",
	Calendar = "C",
	Class = "@",
	Collapsed = "▶",
	Color = "%",
	Constructor = "#",
	Constant = "π",
	Copilot = "*",
	Enum = "ζ",
	EnumMember = "@",
	Event = "!",
	Field = "—",
	File = "•",
	Folder = "+",
	Function = "f",
	Interface = "†",
	Key = "*",
	Keyword = "*",
	Method = "f",
	Module = "M",
	Namespace = "ξ",
	Null = "Ø",
	Number = "#",
	Object = "ß",
	Operator = "⁑",
	Package = "P",
	Property = "✓",
	Reference = "→",
	Snippet = "*",
	String = "T",
	Struct = "@",
	Table = "※",
	Tag = "#",
	TypeParameter = ":",
	Variable = "Ψ",
	Text = "T",
	Unit = "$",
	Value = "λ",
	Watch = "W",
}

M.lsp_sources = {
	ansiblels = "ansible-language-server",
	bashls = "bash-language-server",
	jedi_language_server = "jedi-language-server",
	cssls = "css-lsp",
	ruff = "ruff",
	lua_ls = "lua-language-server",
	gopls = "gopls",
	yamlls = "yaml-language-server",
	zk = "zk",
	dockerls = "dockerfile-language-server",
	terraformls = "terraform-ls",
}

M.formatting_sources = {
	prettierd = "prettierd",
	shfmt = "shfmt",
	mdformat = "mdformat",
	stylua = "stylua",
	cbfmt = "cbfmt",
	goimports = "goimports",
	gofumpt = "gofumpt",
	terraform_fmt = "",
	hclfmt = "hclfmt",
	opa = "opa",
}

M.hover_sources = {
	"dictionary",
	"printenv",
}

M.diagnostics_sources = {
	hadolint = "hadolint",
	commitlint = "commitlint",
	ansiblelint = "ansible-lint",
	mypy = "mypy",
	golangci_lint = "golangci-lint",
	tfsec = "tfsec",
	terraform_validate = "",
}

M.code_action_sources = {
	impl = "impl",
	gomodifytags = "gomodifytags",
}

M.starter_ascii = "  ／l、\n（ﾟ、｡７\n  l  ~ヽ\n  じしf,)ノ\n\n"

M.org_agenda_files = {}

M.zk_wiki = "~/shared/wiki"

M.border = "single"

function M.get_compatible_sources(source_map)
	local sources = {}
	for k, _ in pairs(source_map) do
		table.insert(sources, k)
	end

	return sources
end

function M.get_mason_sources(source_map)
	local sources = {}
	for _, v in pairs(source_map) do
		if v ~= "" then
			table.insert(sources, v)
		end
	end

	return sources
end

return M
