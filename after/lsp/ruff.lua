---@type vim.lsp.Config
return {
	cmd = { "ruff" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	settings = {},
}
