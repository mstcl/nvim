local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

wk.register({
	["<A-j>"] = {
		function()
			exec("MoveLine(1)")
		end,
		"Move line down"
	},
	["<A-k>"] = {
		function()
			exec("MoveLine(-1)")
		end,
		"Move line up"
	},
	["<A-h>"] = {
		function()
			exec("MoveHChar(-1)")
		end,
		"Move char left"
	},
	["<A-l>"] = {
		function()
			exec("MoveHChar(1)")
		end,
		"Move char right"
	},
	["<A-f>"] = {
		function()
			exec("MoveWord(1)")
		end,
		"Move word forward"
	},
	["<A-b>"] = {
		function()
			exec("MoveWord(-1)")
		end,
		"Move word backward"
	},
})
wk.register({
	["<A-j>"] = {
		":MoveBlock(1)<CR>",
		"Move block down",
		mode = "v"
	},
	["<A-k>"] = {
		":MoveBlock(-1)<CR>",
		"Move block up",
		mode = "v"
	},
	["<A-h>"] = {
		":MoveHBlock(-1)<CR>",
		"Move block left",
		mode = "v"
	},
	["<A-l>"] = {
		":MoveHBlock(1)<CR>",
		"Move block right",
		mode = "v"
	},
})
wk.register({
	["w"] = {
		function ()
			exec("lua require('spider').motion('w')")
		end,
		"Spider-w",
		mode = { "n", "o", "x" },
	},
	["e"] = {
		function ()
			exec("lua require('spider').motion('e')")
		end,
		"Spider-e",
		mode = { "n", "o", "x" },
	},
	["b"] = {
		function ()
			exec("lua require('spider').motion('b')")
		end,
		"Spider-b",
		mode = { "n", "o", "x" },
	},
})
