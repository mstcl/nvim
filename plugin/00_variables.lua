-- Global variables

---@type table
_G.config = {}

---@type table
_G.config.treesitter = {}

---LSP configuration
---@type table
_G.config.lsp = {}

---Default UI border to feed into winborder and similar options
---@type string
_G.config.border = "rounded"

---Nice symbols found in various places
---@type table
_G.config.signs = {
	done = "✓",
	close = "",
	open = "",
	diagnostics = " ",
	branch = " ",
	diff = " ",
	delimiter = "·",
	file = "@",

	lsp = {
		Error = "*",
		Warn = "!",
		Hint = "?",
		Info = "i",
	},

	spinner = {
		"⣽",
		"⣻",
		"⢿",
		"⡿",
		"⣟",
		"⣯",
		"⣷",
	},

	kinds = {
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
	},
}

---Kind icons but padded with a whitespace at the front
---@type table
_G.config.signs.kinds_padded = {}
for key, value in pairs(_G.config.signs.kinds) do
	_G.config.signs.kinds_padded[key] = " " .. value
end

---Treesitter grammar to compile and enable
---@type table
_G.config.treesitter.grammars = {
	"lua",
	"vimdoc",
	"markdown",
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

---Treesittter grammars/filetypes with highlights disabled
---(i.e. vim.treesitter.start(buf) won't run)
---@type table
_G.config.treesitter.disabled_filetypes = {
	"csv",
	-- "go",
	-- "terraform",
	-- "hcl",
}

---Set default LSP configuration (what appears as default)
---@type table<string, boolean>
_G.config.lsp.features = {
	inlay_hints = false,
}

---Language servers to enable; will be passed into
---vim.lsp.enable()
---@type table
_G.config.lsp.servers = {
	"ansiblels",
	"bashls",
	"cssls",
	"ruff",
	"pyrefly",
	"ty",
	"emmylua_ls",
	"gopls",
	"gitlab_ci_ls",
	"yamlls",
	"dockerls",
	"tflint",
	"tofu_ls",
}

---LSP capabilities
---@return table
_G.config.lsp.capabilities = function()
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
