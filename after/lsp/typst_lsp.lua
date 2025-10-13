---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/typst-lsp") },
	filetypes = { "typst" },
	root_markers = { ".git" },
	settings = {
		exportPdf = "onSave",
		experimentalFormatterMode = "On",
	},
}
