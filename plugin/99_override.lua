vim.opt.mouse = ""

vim.cmd.colorscheme("tavern")
vim.env.BAT_THEME = "tavern"
vim.env.DELTA_FEATURES = "+tavern"

-- Defer this here so it picks up the right variant
require("nvim-web-devicons").setup()
