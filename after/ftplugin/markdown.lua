local opt_local = vim.opt_local

opt_local.expandtab = true
opt_local.colorcolumn = ""
opt_local.wrap = true
opt_local.list = false
opt_local.spell = true

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

vim.keymap.set(
	"i",
	"<C-L>",
	"<c-g>u<Esc>[s1z=`]a<c-g>u",
	{ noremap = true, silent = true }
) -- autocorrect last spelling error
