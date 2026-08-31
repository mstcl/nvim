local opt_local = vim.opt_local

opt_local.shiftwidth = 4
opt_local.expandtab = true

local map = vim.keymap.set

map("n", "mr", require("quarto.runner").run_cell, { desc = "Run cell", buffer = true })
