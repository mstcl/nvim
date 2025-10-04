local M = {}

M.dev_plugins = {
	"ivory",
}

M.dap_enabled = false
M.lsp_enabled = true
M.lsp_features = {
	virtual_text = false,
	virtual_lines = true,
	inlay_hints = false,
}
M.edit_features = {
	completion = true, -- completion by default
}

M.ui_features = {
	indent_lines = true, -- indentscope enabled by default
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

M.spinner = { "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
M.done = " "

M.lsp_kind_icons = {
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

-- Create a new table
M.lsp_kind_icons_padded = {}

for key, value in pairs(M.lsp_kind_icons) do
	M.lsp_kind_icons_padded[key] = " " .. value
end

M.lsp_sources = {
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

M.formatting_sources = {
	prettierd = "prettierd",
	shfmt = "shfmt",
	stylua = "stylua",
	goimports = "goimports",
	gofumpt = "gofumpt",
	golines = "golines",
	gci = "gci",
	terraform_fmt = "",
	mdslw = "mdslw",
	hclfmt = "hclfmt",
	opa = "opa",
}

M.diagnostics_sources = {
	hadolint = "hadolint",
	commitlint = "commitlint",
	ansiblelint = "ansible-lint",
	selene = "selene",
	golangci_lint = "golangci-lint",
	terraform_validate = "",
	codespell = "codespell",
	trivy = "trivy",
}

M.starter_ascii = "  ／l、\n（ﾟ、｡７\n  l  ~ヽ\n  じしf,)ノ\n\n"

M.org_agenda_files = {}

M.border = "rounded"

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

M.oil_columns = {
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

M.all_mason_sources = {}

local join_mason_sources = function()
	for _, value in ipairs(M.get_mason_sources(M.diagnostics_sources)) do
		table.insert(M.all_mason_sources, value)
	end
	for _, value in ipairs(M.get_mason_sources(M.formatting_sources)) do
		table.insert(M.all_mason_sources, value)
	end
	for _, value in ipairs(M.get_mason_sources(M.lsp_sources)) do
		table.insert(M.all_mason_sources, value)
	end
end

join_mason_sources()

return M
