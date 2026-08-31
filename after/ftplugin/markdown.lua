local opt_local = vim.opt_local

opt_local.shiftwidth = 4
opt_local.expandtab = true
opt_local.colorcolumn = ""

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
