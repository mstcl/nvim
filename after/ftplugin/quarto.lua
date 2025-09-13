local setlocal = vim.opt_local

setlocal.shiftwidth = 4
setlocal.expandtab = true

local map = vim.keymap.set

map("n", "mr", require("quarto.runner").run_cell, { desc = "run cell", buffer = true })
