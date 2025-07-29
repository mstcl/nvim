vim.g.mapleader = ","
vim.g.maplocalleader = ",."

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")
require("core.commands")
require("core.autocmds")
require("core.mappings")
require("core.ui")

-- Lsp setup
require("lsp")

-- Overrides
require("core.override")
