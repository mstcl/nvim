_G.config = {}

_G.config.dev_plugins = {
	"ivory",
	"tavern",
}

_G.config.ascii = "  ／l、\n（ﾟ、｡７\n  l  ~ヽ\n  じしf,)ノ\n\n"

_G.config.border = "rounded"

_G.config.features = {}

_G.config.features.dap = {
	enabled = false,
}

_G.config.features.edit = {
	completion = true,
}

_G.config.features.ui = {
	indent_lines = true,
}

_G.config.features.lsp = {
	enabled = true,
	virtual_text = false,
	virtual_lines = true,
	inlay_hints = false,
}

_G.config.signs = {}

_G.config.signs.done = "✓"
_G.config.signs.fold_open = "▸"
_G.config.signs.fold_closed = "▾"

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

_G.config.signs.dap = {
	Breakpoint = "⚑",
	BreakpointCondition = "⚑",
	LogPoint = "★",
	Stopped = "☛",
	BreakpointRejected = "☒",
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
	Number = "󰎠",
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

_G.config.simple_fts = {
	"",
	"fzf",
	"oil",
	"Fyler",
	"mason",
	"Lazy",
	"aerial",
	"grug-far",
	"NvimTree",
	"OverseerList",
	"OverseerForm",
	"gitsigns-blame",
	"NeogitStatus",
	"NeogitDiffView",
	"NeogitLogView",
	"DiffviewFileHistory",
	"DiffviewFiles",
}

_G.config.oil_columns = {
	types = {
		"type",
		icons = {
			directory = "+",
			fifo = "p",
			file = "·",
			link = "l",
			socket = "s",
		},
		highlight = "Special",
	},
	icon = { "icon" },
	permissions = { "permissions", highlight = "Number" },
}

_G.config.sources = {}

_G.config.treesitter_sources = {
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

_G.config.sources.lsp = {
	ansiblels = "ansible-language-server",
	bashls = "bash-language-server",
	cssls = "css-lsp",
	ruff = "ruff",
	pyrefly = "pyrefly",
	ty = "ty",
	emmyluals = "emmylua_ls",
	gopls = "gopls",
	gitlabcils = "gitlab-ci-ls",
	yamlls = "yaml-language-server",
	zk = "zk",
	dockerls = "dockerfile-language-server",
	terraformls = "terraform-ls",
	tflint = "tflint",
	tofuls = "tofu-ls",
}

_G.config.sources.formatting = {
	"prettierd",
	"shfmt",
	"stylua",
	"goimports",
	"gofumpt",
	"golines",
	"gci",
	"mdslw",
	"hclfmt",
	"opa",
}

_G.config.sources.diagnostics = {
	"hadolint",
	"ansible-lint",
	"selene",
	"golangci-lint",
	"codespell",
	"trivy",
}

_G.config.sources.get_compatible_sources = function(source_map)
	local sources = {}
	for k, _ in pairs(source_map) do
		table.insert(sources, k)
	end

	return sources
end

_G.config.sources.get_mason_sources = function(source_map)
	local sources = {}
	for _, v in pairs(source_map) do
		if v ~= "" then
			table.insert(sources, v)
		end
	end

	return sources
end

_G.config.sources.mason = {}

local function get_all_mason_sources()
	for _, value in ipairs(_G.config.sources.diagnostics) do
		table.insert(_G.config.sources.mason, value)
	end
	for _, value in ipairs(_G.config.sources.formatting) do
		table.insert(_G.config.sources.mason, value)
	end
	for _, value in ipairs(_G.config.sources.get_mason_sources(_G.config.sources.lsp)) do
		table.insert(_G.config.sources.mason, value)
	end
end

get_all_mason_sources()
