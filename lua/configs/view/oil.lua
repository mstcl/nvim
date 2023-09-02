local present, oil = pcall(require, "oil")
if not present then
	return
end

oil.setup({
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>v"] = "actions.select_vsplit",
		["<C-s>h"] = "actions.select_split",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["q"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["<C-h>"] = "actions.toggle_hidden",
	},
	columns = {
		"permissions",
		"size",
	},
	delete_to_trash = true,
	float = {
		padding = 4,
		border = "single",
	},
	preview = {
		border = "single",
	},
	progress = {
		border = "single",
	},
})
