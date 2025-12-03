vim.opt.mouse = ""

vim.cmd.colorscheme("tavern")
vim.env.BAT_THEME = "tavern"
vim.env.DELTA_FEATURES = "+tavern"

-- Defer this here so it picks up the right variant
local ok, devicons = pcall(require, "nvim-web-devicons")
if ok then devicons.setup() end
