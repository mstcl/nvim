local present, multicolumn = pcall(require, "multicolumn")
if not present then
	return
end

multicolumn.setup({
	sets = {
		lua = {
			rulers = { 88 },
			scope = "file",
		},
		default = {
			rulers = { 88 },
			full_column = true,
		},
		python = {
			scope = "window",
			rulers = { 88 },
			to_line_end = true,
		},
		starter = {
			rulers = { 9999 },
		},
		exclude_ft = { "markdown", "help", "netrw", "starter", "man" },
	},
})
