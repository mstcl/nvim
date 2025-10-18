---@diagnostic disable: undefined-global
vim.opt.rtp:prepend("~/projects/tavern")
local lushwright = require("shipwright.transform.lush")

-- selene: allow(undefined_variable)
run(
	require("themes.tavern_extended"),
	lushwright.to_vimscript,
	{ prepend, "set background=dark" },
	{ prepend, 'let g:colors_name="tavern_extended"' },
	{ patchwrite, "colors/tavern_extended.vim", '" PATCH BEGIN', '" PATCH END' }
)
