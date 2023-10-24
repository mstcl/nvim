local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end
local winopt = vim.wo

wk.register({
	["<C-Bslash>"] = {
		function()
			if vim.api.nvim_win_get_width(0) >= 200 then
				exec("ToggleTerm direction=vertical")
			else
				exec("ToggleTerm direction=horizontal")
			end
		end,
		"Terminal",
	},
	["<BS>"] = {
		function()
			exec("Noice dismiss")
		end,
		"Dismiss notification",
	},
	["<C-N>"] = {
		function()
			if winopt.number then
				if winopt.relativenumber then
					winopt.number = false
					winopt.relativenumber = false
				else
					winopt.relativenumber = true
				end
			else
				winopt.number = true
			end
		end,
		"Cycle number mode",
	},
	["<C-R>"] = {
		function()
			exec("RooterToggle")
		end,
		"Toggle autochdir or root dir",
	},
	["<C-P>"] = {
		function()
			exec("WhichKey")
		end,
		"List all keymaps",
	},
	["<C-L>"] = {
		":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
		"Clear screen & highlights",
	},
})
