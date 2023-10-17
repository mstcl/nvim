local present, toggleterm = pcall(require, "toggleterm")
if not present then
	return
end
local Terminal = require("toggleterm.terminal").Terminal

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	hide_numbers = true,
	shade_filetypes = {},
	autochdir = false,
	shade_terminals = false,
	shading_factor = "1",
	highlights = {
		Normal = {
			link = "Floaterm",
		},
	},
	direction = "vertical",
})

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "single",
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end
