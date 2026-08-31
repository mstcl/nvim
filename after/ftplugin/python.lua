local opt_local = vim.opt_local

opt_local.expandtab = true

-- preserve indentation
local map = vim.keymap.set
map("i", "<CR>", "<CR>x<BS>", { noremap = true, silent = true })
map("n", "o", "ox<BS>", { noremap = true, silent = true })
map("n", "O", "Ox<BS>", { noremap = true, silent = true })
