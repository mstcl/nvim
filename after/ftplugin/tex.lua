local opt_local = vim.opt_local

opt_local.relativenumber = false
opt_local.number = false
opt_local.foldcolumn = "0"
opt_local.signcolumn = "no"
opt_local.colorcolumn = ""
opt_local.wrap = true
opt_local.list = false
opt_local.spell = true
vim.g.loaded_matchparen = 1

vim.keymap.set(
	"i",
	"<C-L>",
	"<c-g>u<Esc>[s1z=`]a<c-g>u",
	{ noremap = true, silent = true }
) -- autocorrect last spelling error
