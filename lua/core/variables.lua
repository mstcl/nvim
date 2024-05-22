local M = {}

M.dev_plugins = {
	"dmg",
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
	hlargs = true,
}

M.syntax_features = {
	typst = false,
	quarto = false,
	org = false,
	tex = true,
	markdown = true,
}

M.frecency_workspaces = {
	["conf"] = vim.fn.expand("$HOME/.config"),
	["scripts"] = vim.fn.expand("$HOME/scripts"),
	["dot"] = vim.fn.expand("$HOME/dotfiles"),
	["zsh"] = vim.fn.expand("$HOME/.config/zsh"),
	["nvim"] = vim.fn.expand("$HOME/.config/nvim"),
	["projects"] = vim.fn.expand("$HOME/projects"),
	["go"] = vim.fn.expand("$HOME/projects/go"),
	["org"] = vim.fn.expand("$HOME/sftpgo/notes"),
}

M.treesitter_sources = {
	"python",
	"html",
	"c",
	"cpp",
	"bibtex",
	"css",
	"json",
	"json5",
	"hjson",
	"vim",
	"java",
	"javascript",
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
	"scss",
	"sxhkdrc",
	"yaml",
	"toml",
	"comment",
	"org",
	"rust",
	"norg",
	"xml",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"gotmpl",
	"make",
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
	"ltex",
	"gopls",
	"yamlls",
	"markdown_oxide",
	"dockerls",
}

M.null_formatting_sources = {
	"prettierd",
	"shfmt",
	"mdformat",
	"stylua",
	"cbfmt",
	"goimports",
	"gofumpt",
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
}

M.null_code_action_sources = {
	"gitsigns",
	"impl",
	"gomodifytags",
}

M.starter_ascii = "  ／l、\n（ﾟ、｡７\n  l  ~ヽ\n  じしf,)ノ\n\n"

M.org_agenda_files = {
}

return M
