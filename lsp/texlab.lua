---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/texlab") },
	filetypes = { "tex", "plaintex", "bib" },
	root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "miktex-pdflatex",
				forwardSearchAfter = true,
				onSave = true,
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				executable = "qpdfview",
				args = {
					"--unique",
					"%p#src:%f:%l:0",
				},
			},
		},
	},
}
