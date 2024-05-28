local fzf = require("fzf-lua")
local path = vim.fn.expand(require("core.variables").zk_wiki)

local M = {}

M.exec = function()
	fzf.files({ cwd = path })
end

return M
