local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local call = vim.api.nvim_call_function

local tshighlight = augroup("tshighlight", { clear = true })
autocmd({ "VimEnter" }, {
	pattern = "*.zsh",
	group = tshighlight,
	command = "silent! TSBufDisable highlight",
})
autocmd({ "BufRead" }, {
	pattern = "*/fontconfig/*",
	group = tshighlight,
	command = "set ft=xml",
})
