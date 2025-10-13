---@type vim.lsp.Config
return {
	cmd = { "marksman" },
	filetypes = { "markdown", "quarto" },
	root_markers = { ".git", ".marksman.toml", "_quarto.yml" },
	settings = {},
}
