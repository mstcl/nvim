vim.g.mapleader = ","
vim.g.maplocalleader = ",."

require'lazy-init'

vim.cmd[[
    source ~/.config/nvim/lua/utils/functions.vim
]]

require'utils.commands'
require'utils.autocmds.main'
require'utils.mappings'
require'utils.settings'
