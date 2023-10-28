local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end
local winopt = vim.wo

wk.register({
	["<C-M>"] = { name = "Toggle components" },
	["<C-M>z"] = {
		function()
			exec("ZenMode")
		end,
		"Toggle Zen mode",
	},
	["<C-M>t"] = {
		function()
			exec("TSBufToggle highlight")
		end,
		"Toggle treesitter highlighting",
	},
	["<C-M>g"] = {
		function()
			exec("Gitsigns toggle_signs")
		end,
		"Toggle gitsigns",
	},
	["<C-M>s"] = {
		function()
			exec("setlocal spell! spelllang=en_gb")
		end,
		"Toggle spell checking",
	},
	["<C-M>a"] = {
		function()
			if vim.g.cmp_toggle then
				vim.g.cmp_toggle = false
			else
				vim.g.cmp_toggle = true
			end
		end,
		"Toggle auto-completion window",
	},
	["<C-M>h"] = {
		function()
			exec("ColorizerToggle")
		end,
		"Toggle highlighting colours",
	},
	["<C-M>n"] = {
		function()
			if winopt.list then
				winopt.list = false
			else
				winopt.list = true
			end
		end,
		"Toggle non-text characters",
	},
	["<C-M>l"] = {
		function()
			if winopt.cursorline then
				winopt.cursorline = false
			else
				winopt.cursorline = false
			end
		end,
		"Toggle cursorline",
	},
	["<C-M>f"] = {
		function()
			if winopt.foldcolumn == "1" then
				winopt.foldcolumn = "0"
			else
				winopt.foldcolumn = "1"
			end
		end,
		"Toggle foldcolumn",
	},
})
