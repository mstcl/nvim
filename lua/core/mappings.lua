local map = vim.keymap.set

map("n", "<leader>p", function()
	vim.cmd("Lazy show")
end, { desc = "Lazy configuration" })

map({ "n", "v" }, "<space>", ":", { remap = false, desc = "Command", silent = true })

-- UI toggles
map("n", "<C-L>", function()
	vim.cmd("Clear")
end, { desc = "Clear screen & highlights", noremap = false, silent = true })

map("n", "<C-N>", function()
	vim.cmd("ToggleNumber")
end, { desc = "Cycle number mode", noremap = false, silent = true })

map("n", "<C-M>so", function()
	vim.cmd("ToggleScrolloff")
end, { desc = "Toggle scrolloff", noremap = false, silent = true })

map("n", "<C-M>sp", function()
	vim.cmd("ToggleSpell")
end, { desc = "Toggle spell checking", noremap = false, silent = true })

map("n", "<C-M>n", function()
	vim.cmd("ToggleList")
end, { desc = "Toggle non-text characters", noremap = false, silent = true })

map("n", "<C-M>cl", function()
	vim.cmd("ToggleCursorLine")
end, { desc = "Toggle cursorline", noremap = false, silent = true })

map("n", "<C-M>f", function()
	vim.cmd("ToggleFoldColumn")
end, { desc = "Toggle foldcolumn", noremap = false, silent = true })

map("n", "<C-M>cc", function()
	vim.cmd("ToggleColorColumn")
end, { desc = "Toggle cursorcolumn", noremap = false, silent = true })

map("n", "<C-M>p", function()
	vim.cmd("PasteMode")
end, { desc = "Enter paste mode", noremap = false, silent = true })

-- Window splitting
map("n", "<C-S>v", function()
	vim.cmd("vsplit")
end, { desc = "Split vertical", noremap = false, silent = true })

map("n", "<C-S>h", function()
	vim.cmd("split")
end, { desc = "Split horizontal", noremap = false, silent = true })

-- Searching
map("n", "n", "nzz", { desc = "Search previous result" })
map("n", "N", "Nzz", { desc = "Search next result" })
map("n", "*", "*zz", { desc = "Search matching forward (word)" })
map("n", "#", "#zz", { desc = "Search matching backward (word)" })
map("n", "g*", "g*zz", { desc = "Search matching backward" })
map("n", "g#", "g#zz", { desc = "Search matching backward" })

-- Indenting
map("x", "<", "<gv", { desc = "Unindent" })
map("x", ">", ">gv", { desc = "Indent" })

-- Folding
map("n", "<S-Tab>", "za", { desc = "Toggle current fold" })

-- Better search
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Tab mappings
map("n", "]t", "gt", { desc = "Next tabpage" })
map("n", "[t", "gT", { desc = "Previous tabpage" })
map("n", "<C-T>n", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<C-T>c", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- save original gx to use as fallback
local old_gx = vim.fn.maparg("gx", "n", nil, true)
map("n", "gx", function()
	local word = vim.fn.expand("<cWORD>"):match("[\"']([%a_%.%-]+/[%a_%.%-]+)[\"']")
	if word then
		vim.ui.open("https://github.com/" .. word)
	else
		old_gx.callback()
	end
end, { desc = "Follow word with xdg-open" })

-- open terminal
map("n", "<C-Bslash>", function()
	require("core.terminal").Toggle()
end, { desc = "Toggle terminal", noremap = false, silent = true })
