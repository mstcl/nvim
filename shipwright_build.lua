---@diagnostic disable: undefined-global
local lushwright = require("shipwright.transform.lush")
run(
	require("lush.ivory_extended"),
	lushwright.to_vimscript,
	{ prepend, "set background=light" },
	{ prepend, 'let g:colors_name="ivory_extended"' },
	{ patchwrite, "colors/ivory_extended.vim", "\" PATCH BEGIN", "\" PATCH END" }
)
run(
	require("lush.dmg_extended"),
	lushwright.to_vimscript,
	{ prepend, "set background=light" },
	{ prepend, 'let g:colors_name="dmg_extended"' },
	{ overwrite, "colors/dmg_extended.vim" }
	{ patchwrite, "colors/dmg_extended.vim", "\" PATCH BEGIN", "\" PATCH END" }
)
