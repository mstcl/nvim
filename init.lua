vim.g.mapleader = ","
vim.g.maplocalleader = ",."

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")

-- UI setup
require("core.ui")
set_statusline()
set_statuscol()

-- Autocommands, mappings, and commands
require("core.autocmds")
require("core.mappings")
require("core.commands")

-- Lsp setup
require("lsp")

-- Overrides
require("core.override")
