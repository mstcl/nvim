local fzf_lua = require("fzf-lua")

local opts = {
	actions = {
		["default"] = function(selected)
			vim.cmd("cd " .. selected[1])
		end,
	},
	winopts = {
		title = " Zoxide ",
		title_pos = "center",
		height = 0.5,
		width = 0.3,
	},
}

local M = {}

M.exec = function ()
	fzf_lua.fzf_exec("zoxide query -l", opts)
end

return M
