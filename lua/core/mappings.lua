local map = vim.keymap.set

map("n", "<leader>L", function()
	vim.cmd("Lazy show")
end, { desc = "lazy panel toggle" })

map({ "n", "v" }, "<space>", ":", { remap = false, desc = "command", silent = true })

-- UI toggles
map("n", "<C-L>", function()
	vim.cmd("Clear")
end, { desc = "clear screen & highlights", noremap = false, silent = true })

map("n", "<C-N>", function()
	vim.cmd("ToggleNumber")
end, { desc = "cycle number mode", noremap = false, silent = true })

map("n", "<leader>C", function()
	vim.cmd("ToggleScrolloff")
end, { desc = "centered cursor", noremap = false, silent = true })

map("n", "<leader>xs", function()
	vim.cmd("ToggleSpell")
end, { desc = "spell toggle", noremap = false, silent = true })

map("n", "<leader>xn", function()
	vim.cmd("ToggleList")
end, { desc = "non-text characters toggle", noremap = false, silent = true })

map("n", "<leader>c", function()
	vim.cmd("ToggleCursorLine")
end, { desc = "cursorline toggle", noremap = false, silent = true })

map("n", "<leader>xf", function()
	vim.cmd("ToggleFoldColumn")
end, { desc = "foldcolumn toggle", noremap = false, silent = true })

map("n", "<leader>xc", function()
	vim.cmd("ToggleColorColumn")
end, { desc = "cursorcolumn toggle", noremap = false, silent = true })

map("n", "<leader>Q", function()
	vim.cmd("QuietMode")
end, { desc = "quiet mode", noremap = false, silent = true })

-- Window splitting
map("n", "<C-S>v", function()
	vim.cmd("vsplit")
end, { desc = "split vertical", noremap = false, silent = true })

map("n", "<C-S>h", function()
	vim.cmd("split")
end, { desc = "split horizontal", noremap = false, silent = true })

-- Searching
map("n", "n", "nzz", { desc = "search previous result" })
map("n", "N", "Nzz", { desc = "search next result" })
map("n", "*", "*zz", { desc = "search matching forward (word)" })
map("n", "#", "#zz", { desc = "search matching backward (word)" })
map("n", "g*", "g*zz", { desc = "search matching backward" })
map("n", "g#", "g#zz", { desc = "search matching backward" })

-- Indenting
map("x", "<", "<gv", { desc = "unindent" })
map("x", ">", ">gv", { desc = "indent" })

-- Folding
map("n", "<S-Tab>", "za", { desc = "fold toggle" })

-- Better search
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next Search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next Search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })

-- Tab mappings
map("n", "]t", "gt", { desc = "next tabpage" })
map("n", "[t", "gT", { desc = "previous tabpage" })
map("n", "<C-T>n", function()
	vim.cmd("tabnew")
end, { desc = "new tab" })
map("n", "<C-T>c", function()
	vim.cmd("tabclose")
end, { desc = "close tab" })

-- save original gx to use as fallback
---@diagnostic disable-next-line: param-type-not-match
local old_gx = vim.fn.maparg("gx", "n", nil, true)
map("n", "gx", function()
	local word = vim.fn.expand("<cWORD>"):match("[\"']([%a_%.%-]+/[%a_%.%-]+)[\"']")
	if word then
		vim.ui.open("https://github.com/" .. word)
	else
		---@diagnostic disable-next-line: undefined-field
		old_gx.callback()
	end
end, { desc = "follow word with xdg-open" })

-- open terminal
map("n", "<C-Bslash>", function()
	require("core.terminal").Toggle()
end, { desc = "quake terminal toggle", noremap = false, silent = true })

-- copy commit hash
map("n", "<leader>gy", function()
	vim.cmd("GetCommitHash")
end, { desc = "yank commit hash", noremap = false, silent = true })
