---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jedi-language-server") },
	filetypes = { "yaml.ansible", "yaml", "yml" },
	root_markers = { ".git" },
	settings = {
	},
}
