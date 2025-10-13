local fzf_lua = require("fzf-lua")

_G.pickers = {}

_G.pickers.zoxide = function()
	fzf_lua.fzf_exec("zoxide query -l", {
		winopts = {
			title = " Zoxide ",
			title_pos = "center",
		},
		fzf_opts = {
			["--no-multi"] = "",
		},
		actions = {
			["ctrl-o"] = {
				fn = function(selected)
					require("oil").open(selected[1])
				end,
				desc = "open-oil",
				header = "open oil in selected directory",
			},
			["ctrl-s"] = {
				fn = function(selected)
					fzf_lua.files({ cwd = selected[1] })
				end,
				desc = "search-files",
				header = "search files in selected directory",
			},
			["default"] = function(selected)
				vim.cmd("cd " .. selected[1])
			end,
		},
	})
end
