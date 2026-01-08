_G.config = {}
_G.config.sources = {}
_G.config.filetypes = {}
_G.config.features = {}
_G.config.signs = {}
_G.config.diagnostics = {}

_G.config.ascii = "  ／l、\n（ﾟ、｡７\n  l  ~ヽ\n  じしf,)ノ\n\n"

_G.config.border = "rounded"

_G.config.features.lsp = {
	enabled = true,
	virtual_text = false,
	virtual_lines = false,
	inlay_hints = false,
}

_G.config.signs.done = "✓"
_G.config.signs.close = ""
_G.config.signs.open = ""

_G.config.signs.diagnostics = " "
_G.config.signs.branch = " "
_G.config.signs.diff = " "
_G.config.signs.delimiter = "·"
_G.config.signs.file = "@"

_G.config.signs.lsp = {
	Error = "*",
	Warn = "!",
	Hint = "?",
	Info = "i",
}

_G.config.signs.spinner = {
	"⣽",
	"⣻",
	"⢿",
	"⡿",
	"⣟",
	"⣯",
	"⣷",
}

_G.config.signs.kinds = {
	Array = "󰅪",
	Boolean = "B",
	Calendar = "C",
	Class = "󰆼",
	Collapsed = "▶",
	Color = "#",
	Constructor = "󰆧",
	Constant = "π",
	Copilot = "*",
	Element = "󰅩",
	Enum = "󰃷",
	EnumMember = "󰃷",
	Event = "",
	Field = "󰆧",
	File = "•",
	Folder = "+",
	Function = "󰊕",
	Interface = "⦿",
	Key = "*",
	Keyword = "*",
	Method = "󰊕",
	Module = "󰅩",
	Namespace = "󰅩",
	Null = "Ø",
	Number = "",
	Object = "󰅩",
	Operator = "⁑",
	Package = "󰆧",
	Property = "󰅴",
	Reference = "→",
	Regex = "",
	Snippet = "*",
	String = "󰉾",
	Struct = "󰆼",
	Table = "󰅩",
	Tag = "#",
	TypeParameter = ":",
	Variable = "󰀫",
	Text = "󰉾",
	Unit = "$",
	Value = "λ",
	Watch = "W",
}

_G.config.signs.kinds_padded = {}

for key, value in pairs(_G.config.signs.kinds) do
	_G.config.signs.kinds_padded[key] = " " .. value
end

-- all treesitter grammar to compile
_G.config.sources.treesitter = {
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
	"markdown",
	"bash",
	"diff",
	"dockerfile",
	"gitignore",
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
	"rasi",
}

-- all lsp servers to download from mason
_G.config.sources.lsp = {
	ansiblels = "ansible-language-server",
	bashls = "bash-language-server",
	cssls = "css-lsp",
	ruff = "ruff",
	pyrefly = "pyrefly",
	ty = "ty",
	emmylua_ls = "emmylua_ls",
	gopls = "gopls",
	gitlab_ci_ls = "gitlab-ci-ls",
	yamlls = "yaml-language-server",
	zk = "zk",
	dockerls = "dockerfile-language-server",
	tflint = "tflint",
	tofu_ls = "tofu-ls",
}

-- all code tools to download from mason
_G.config.sources.tools = {
	"shfmt",
	"stylua",
	"goimports",
	"gofumpt",
	"golines",
	"gci",
	"mdslw",
	"hclfmt",
	"opa",
	"hadolint",
	"ansible-lint",
	"selene",
	"golangci-lint",
	"codespell",
	"trivy",
	"biome",
	"yamlfmt",
}

-- diagnostic configuration
_G.config.diagnostics.virtual_text = {
	current_line = true,
	spacing = 4,
	source = "if_many",
	prefix = "●",
	suffix = " ",
}

_G.config.diagnostics.virtual_lines = {
	current_line = true,
}

-- LSP capabilities
_G.config.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
			completionItem = {
				snippetSupport = true,
			},
		},
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	})

	return capabilities
end
