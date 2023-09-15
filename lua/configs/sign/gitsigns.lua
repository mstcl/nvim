local present, gs = pcall(require, "gitsigns")
if not present then
	return
end

gs.setup({
	numhl = true,
	linehl = false,
	signcolumn = true,
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	signs = {
		add = { hl = "DiffAdd", text = " ", numhl = "DiffAdd", linehl = "DiffAdd" },
		change = { hl = "DiffChange", text = " ", numhl = "DiffChange", linehl = "DiffChange" },
		delete = { hl = "DiffDelete", text = " ", numhl = "DiffDelete", linehl = "DiffDelete" },
		topdelete = { hl = "DiffDelete", text = "‾", numhl = "DiffDelete", linehl = "DiffDelete" },
		changedelete = { hl = "DiffChange", text = "~", numhl = "DiffChange", linehl = "DiffChange" },
		untracked = { hl = "DiffAdd", text = "╎", numhl = "DiffAdd", linehl = "DiffAdd" },
	},
	current_line_blame = false,
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,
	word_diff = false,
})
