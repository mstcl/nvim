---@diagnostic disable: undefined-global
local lushwright = require("shipwright.transform.lush")
run(
	require("lush.ivory_extended"),
	lushwright.to_vimscript,
	{ prepend, "set background=light" },
	{ prepend, 'let g:colors_name="ivory_extended"' },
	{ overwrite, "colors/ivory_extended.vim" }
)
run(
	require("lush.dmg_extended"),
	lushwright.to_vimscript,
	{ prepend, "set background=light" },
	{ prepend, 'let g:colors_name="dmg_extended"' },
	{ overwrite, "colors/dmg_extended.vim" }
)
