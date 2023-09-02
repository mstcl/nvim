vim.g.mapleader = ","
vim.g.maplocalleader = ",."

require'lazy-init'

local disabled_built_ins = {
    "gzip",
    "zip",
    "zipPlugin",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "tutor_mode_plugin",
    "matchit",
    "matchparen",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.cmd[[
    source ~/.config/nvim/lua/utils/functions.vim
]]

require'utils.commands'
require'utils.autocmds'
require'utils.mappings'
require'utils.settings'
