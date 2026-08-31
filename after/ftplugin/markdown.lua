local setlocal = vim.opt_local

setlocal.shiftwidth = 4
setlocal.expandtab = true
setlocal.colorcolumn = ""

vim.b.minisurround_config = {
	custom_surroundings = {
		L = {
			input = { "%[().-()%]%(.-%)" },
			output = function()
				local link = require("mini.surround").user_input("Link")
				return { left = "[", right = "](" .. link .. ")" }
			end,
		},
		B = { output = { left = "**", right = "**" } },
		I = { output = { left = "*", right = "*" } },
		S = { output = { left = "~~", right = "~~" } },
	},
}
