---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/marksman") },
	filetypes = { "markdown", "quarto" },
	root_markers = { ".git", ".marksman.toml", "_quarto.yml" },
	settings = {},
}
