vim.g.mapleader = ","
vim.g.maplocalleader = ",."

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")
require("core.commands")
require("core.autocmds")
require("core.mappings")

-- Overrides
-- require("lua.core.override")
