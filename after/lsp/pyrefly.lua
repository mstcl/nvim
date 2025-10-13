---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/pyrefly"), "lsp" },
	filetypes = { "python" },
	root_markers = { "ty.toml", "pyproject.toml", ".git", "setup.cfg", "setup.py" },
	settings = {},
}
