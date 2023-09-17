local present, toggleterm = pcall(require, "toggleterm")
if not present then
	return
end

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
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
