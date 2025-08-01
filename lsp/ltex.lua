--@type vim.lsp.Config
local spell_words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(spell_words, word)
end
return {
	cmd = { "ltex-ls" },
	filetypes = {
		"bib",
		"gitcommit",
		"markdown",
		"org",
		"plaintex",
		"rst",
		"rnoweb",
		"tex",
		"pandoc",
		"quarto",
		"rmd",
		"context",
		"html",
		"xhtml",
		"mail",
		"text",
	},
	root_markers = { ".git" },
	settings = {
		ltex = {
			enabled = {
				"bibtex",
				"gitcommit",
				"markdown",
				"org",
				"tex",
				"restructuredtext",
				"rsweave",
				"latex",
				"quarto",
				"rmd",
				"context",
				"html",
				"xhtml",
				"mail",
				"plaintext",
			},
		},
	},
}
