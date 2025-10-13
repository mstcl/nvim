vim.keymap.set("n", "<leader>L", function()
	vim.cmd("Lazy show")
end, { desc = "lazy panel toggle" })

vim.keymap.set({ "n", "v" }, "<space>", ":", { remap = false, desc = "command", silent = true })

-- UI toggles
vim.keymap.set("n", "<C-L>", function()
	vim.cmd("Clear")
end, { desc = "clear screen & highlights", noremap = false, silent = true })

vim.keymap.set("n", "<C-N>", function()
	vim.cmd("ToggleNumber")
end, { desc = "cycle number mode", noremap = false, silent = true })

vim.keymap.set("n", "<leader>C", function()
	vim.cmd("ToggleScrolloff")
end, { desc = "centered cursor", noremap = false, silent = true })

vim.keymap.set("n", "<leader>xs", function()
	vim.cmd("ToggleSpell")
end, { desc = "spell toggle", noremap = false, silent = true })

vim.keymap.set("n", "<leader>xn", function()
	vim.cmd("ToggleList")
end, { desc = "non-text characters toggle", noremap = false, silent = true })

vim.keymap.set("n", "<leader>c", function()
	vim.cmd("ToggleCursorLine")
end, { desc = "cursorline toggle", noremap = false, silent = true })

-- vim.keymap.set("n", "<leader>xf", function()
-- 	vim.cmd("ToggleFoldColumn")
-- end, { desc = "foldcolumn toggle", noremap = false, silent = true })

vim.keymap.set("n", "<leader>xc", function()
	vim.cmd("ToggleColorColumn")
end, { desc = "cursorcolumn toggle", noremap = false, silent = true })

vim.keymap.set("n", "<leader>Q", function()
	vim.cmd("QuietMode")
end, { desc = "quiet mode", noremap = false, silent = true })

-- Window splitting
vim.keymap.set("n", "<C-S>v", function()
	vim.cmd("vsplit")
end, { desc = "split vertical", noremap = false, silent = true })

vim.keymap.set("n", "<C-S>h", function()
	vim.cmd("split")
end, { desc = "split horizontal", noremap = false, silent = true })

-- Searching
vim.keymap.set("n", "n", "nzz", { desc = "search previous result" })
vim.keymap.set("n", "N", "Nzz", { desc = "search next result" })
vim.keymap.set("n", "*", "*zz", { desc = "search matching forward (word)" })
vim.keymap.set("n", "#", "#zz", { desc = "search matching backward (word)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "search matching backward" })
vim.keymap.set("n", "g#", "g#zz", { desc = "search matching backward" })

-- Indenting
vim.keymap.set("x", "<", "<gv", { desc = "unindent" })
vim.keymap.set("x", ">", ">gv", { desc = "indent" })

-- Folding
vim.keymap.set("n", "<S-Tab>", "za", { desc = "fold toggle" })

-- Better search
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next Search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next Search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })

-- Tab mappings
vim.keymap.set("n", "]t", "gt", { desc = "next tabpage" })
vim.keymap.set("n", "[t", "gT", { desc = "previous tabpage" })
vim.keymap.set("n", "<C-T>n", function()
	vim.cmd("tabnew")
end, { desc = "new tab" })
vim.keymap.set("n", "<C-T>c", function()
	vim.cmd("tabclose")
end, { desc = "close tab" })

-- save original gx to use as fallback
---@diagnostic disable-next-line: param-type-not-match
local old_gx = vim.fn.maparg("gx", "n", nil, true)
vim.keymap.set("n", "gx", function()
	local word = vim.fn.expand("<cWORD>"):match("[\"']([%a_%.%-]+/[%a_%.%-]+)[\"']")
	if word then
		vim.ui.open("https://github.com/" .. word)
	else
		---@diagnostic disable-next-line: undefined-field
		old_gx.callback()
	end
end, { desc = "follow word with xdg-open" })

-- open terminal
vim.keymap.set("n", "<C-Bslash>", function()
	vim.cmd("ToggleTerminal")
end, { desc = "quake terminal toggle", noremap = false, silent = true })

-- copy commit hash
vim.keymap.set("n", "<leader>gy", function()
	vim.cmd("GetCommitHash")
end, { desc = "yank commit hash", noremap = false, silent = true })

-- pair mode commands
vim.keymap.set("n", "<leader>xp", function()
	vim.cmd("PairModeEnter")
end, { desc = "Pair mode enter", noremap = false, silent = true })

vim.keymap.set("n", "<leader>xP", function()
	vim.cmd("PairModeLeave")
end, { desc = "Pair mode leave", noremap = false, silent = true })
