local opt_local = vim.opt_local

opt_local.expandtab = true
opt_local.colorcolumn = ""
opt_local.wrap = true
opt_local.list = false
opt_local.spell = true

vim.keymap.set(
	"i",
	"<C-L>",
	"<c-g>u<Esc>[s1z=`]a<c-g>u",
	{ noremap = true, silent = true }
) -- autocorrect last spelling error
