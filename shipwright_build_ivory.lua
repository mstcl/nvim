---@diagnostic disable: undefined-global
local lushwright = require("shipwright.transform.lush")

-- selene: allow(undefined_variable)
run(
	require("lush.ivory_extended"),
	lushwright.to_vimscript,
	{ prepend, "set background=light" },
	{ prepend, 'let g:colors_name="ivory_extended"' },
	{ patchwrite, "colors/ivory_extended.vim", '" PATCH BEGIN', '" PATCH END' }
)
