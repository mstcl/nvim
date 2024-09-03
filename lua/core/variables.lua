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
	completion = true,
}

M.ui_features = {
	animate = true,
	indent_lines = true,
	tabline = false,
}

M.syntax_features = {
	typst = false,
	quarto = false,
	tex = true,
	markdown = true,
}

M.frecency_workspaces = {
}

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
	"ansiblels",
	"clangd",
	"bashls",
	"jedi_language_server",
	"vimls",
	"cssls",
	"typst_lsp",
	"ruff",
	"texlab",
	"lua_ls",
	"gopls",
	"yamlls",
	"zk",
	"dockerls",
	"terraformls",
}

M.null_formatting_sources = {
	"prettierd",
	"shfmt",
	"mdformat",
	"stylua",
	"cbfmt",
	"goimports",
	"gofumpt",
	"terraform_fmt",
}

M.null_hover_sources = {
	"dictionary",
	"printenv",
}

M.null_diagnostics_sources = {
	"hadolint",
	"commitlint",
	"cppcheck",
	"vint",
	"ansiblelint",
	"mypy",
	"golangci_lint",
	"tfsec",
	"terraform_validate",
}

M.null_code_action_sources = {
	"impl",
	"gomodifytags",
}

M.starter_ascii = "  ／l、\n（ﾟ、｡７\n  l  ~ヽ\n  じしf,)ノ\n\n"

M.org_agenda_files = {
}

M.zk_wiki = "~/shared/wiki"

M.border = "single"

return M
