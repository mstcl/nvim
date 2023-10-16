local present, hlchunk = pcall(require, "hlchunk")
if not present then
	return
end

local disabled_ft = {
	plugin = true,
	Outline = true,
	Trouble = true,
	[""] = true,
	help = true,
	toggleterm = true,
	lazy = true,
	TelescopePrompt = true,
	alpha = true,
	man = true,
	checkhealth = true,
	starter = true,
	markdownpreview = true,
	frecency = true,
	oil = true,
	i3config = true,
}

local hl = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("ErrorMsg")), "fg", "gui")
local hl_alt = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("TSRainbowRed")), "fg", "gui")

hlchunk.setup({
	indent = {
		exclude_filetypes = disabled_ft,
	},
	line_num = {
		enable = false,
		use_treesitter = true,
		style = hl,
		exclude_filetypes = disabled_ft,
	},
	blank = {
		style = hl,
		enable = false,
	},
	chunk = {
		use_treesitter = true,
		style = hl,
		chars = {
			horizontal_line = "─",
			vertical_line = "│",
			left_top = "┌",
			left_bottom = "└",
			right_arrow = "─",
		},
		exclude_filetypes = disabled_ft,
	},
})
