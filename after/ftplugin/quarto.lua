local opt_local = vim.opt_local

opt_local.expandtab = true

vim.keymap.set(
	"n",
	"mr",
	require("quarto.runner").run_cell,
	{ desc = "Run cell", buffer = true }
)

vim.keymap.set(
	"i",
	"<C-L>",
	"<c-g>u<Esc>[s1z=`]a<c-g>u",
	{ noremap = true, silent = true }
) -- autocorrect last spelling error
