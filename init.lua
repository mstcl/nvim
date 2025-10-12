---@diagnostic disable: undefined_variable
vim.g.mapleader = ","
vim.g.maplocalleader = ",."

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")

-- UI setup
require("core.ui")
-- selene: allow(undefined_variable)
set_statusline()
-- selene: allow(undefined_variable)
set_statuscol()

-- Autocommands, mappings, and commands
require("core.commands")
require("core.autocmds")
require("core.mappings")

-- Lsp setup
require("lsp")

-- Overrides
require("core.override")
