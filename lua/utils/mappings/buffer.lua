local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

wk.register({
	["<Left>"] = {
		function()
			exec("BufferPrevious")
		end,
		"Buffer: previous"
	},
	["<Right>"] = {
		function()
			exec("BufferNext")
		end,
		"Buffer: next"
	},
	["<leader><Left>"] = {
		function ()
			exec("BufferMovePrevious")
		end,
		"Move buffer backward"
	},
	["<leader><Right>"] = {
		function ()
			exec("BufferMoveNext")
		end,
		"Move buffer forward"
	},
	["<leader>`"] = {
		function ()
			exec("BufferFirst")
		end,
		"Buffer first"
	},
	["<leader>-"] = {
		function ()
			exec("BufferLast")
		end,
		"Buffer last"
	},
	["<leader>1"] = {
		function ()
			exec("BufferGoto 1")
		end,
		"Buffer 1"
	},
	["<leader>2"] = {
		function ()
			exec("BufferGoto 2")
		end,
		"Buffer 2"
	},
	["<leader>3"] = {
		function ()
			exec("BufferGoto 3")
		end,
		"Buffer 3"
	},
	["<leader>4"] = {
		function ()
			exec("BufferGoto 4")
		end,
		"Buffer 4"
	},
	["<leader>5"] = {
		function ()
			exec("BufferGoto 5")
		end,
		"Buffer 5"
	},
	["<leader>6"] = {
		function ()
			exec("BufferGoto 6")
		end,
		"Buffer 6"
	},
	["<leader>7"] = {
		function ()
			exec("BufferGoto 7")
		end,
		"Buffer 7"
	},
	["<leader>8"] = {
		function ()
			exec("BufferGoto 8")
		end,
		"Buffer 8"
	},
	["<leader>9"] = {
		function ()
			exec("BufferGoto 9")
		end,
		"Buffer 9"
	},
	["<Up>"] = {
		function()
			exec("BufferPin")
		end,
		"Buffer: pin"
	},
	["<Down>"] = {
		function()
			exec("BufferClose")
		end,
		"Buffer: close"
	},
	["<leader>b"] = {
		function()
			exec("BufferPick")
		end,
		"Pick buffer"
	},
})
