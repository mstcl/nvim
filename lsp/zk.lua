---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/zk"), "lsp" },
	filetypes = { "markdown" },
	root_markers = { ".zk" },
	settings = {},
}
