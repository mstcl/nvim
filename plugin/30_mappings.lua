vim.keymap.set(
	{ "n", "v" },
	"<space>",
	":",
	{ remap = false, desc = "Command", silent = true }
)

-- UI toggles
vim.keymap.set(
	"n",
	"<C-L>",
	function() vim.cmd("Clear") end,
	{ desc = "Clear screen & highlights", noremap = false, silent = true }
)

vim.keymap.set(
	"n",
	"<leader>m",
	function() vim.cmd("ToggleRelativeNumber") end,
	{ desc = "Number mode (cycle)", noremap = false, silent = true }
)

vim.keymap.set(
	"n",
	"<leader>c",
	function() vim.cmd("ToggleCursorLine") end,
	{ desc = "Cursorline (toggle)", noremap = false, silent = true }
)

vim.keymap.set(
	"n",
	"<leader>Q",
	function() vim.cmd("QuietMode") end,
	{ desc = "Quiet mode", noremap = false, silent = true }
)

-- Window splitting
vim.keymap.set(
	"n",
	"<C-S>v",
	function() vim.cmd("vsplit") end,
	{ desc = "Split vertical", noremap = false, silent = true }
)

vim.keymap.set(
	"n",
	"<C-S>h",
	function() vim.cmd("split") end,
	{ desc = "Split horizontal", noremap = false, silent = true }
)

-- Searching
vim.keymap.set("n", "n", "nzz", { desc = "Search previous result" })
vim.keymap.set("n", "N", "Nzz", { desc = "Search next result" })
vim.keymap.set("n", "*", "*zz", { desc = "Search matching forward (word)" })
vim.keymap.set("n", "#", "#zz", { desc = "Search matching backward (word)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search matching backward" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search matching backward" })

-- Indenting
vim.keymap.set("x", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent" })

-- Folding
vim.keymap.set("n", "<S-Tab>", "za", { desc = "Fold (toggle)" })

-- Better search
vim.keymap.set(
	"n",
	"n",
	"'Nn'[v:searchforward].'zv'",
	{ expr = true, desc = "Next search result" }
)
vim.keymap.set(
	"x",
	"n",
	"'Nn'[v:searchforward]",
	{ expr = true, desc = "Next Search result" }
)
vim.keymap.set(
	"o",
	"n",
	"'Nn'[v:searchforward]",
	{ expr = true, desc = "Next Search result" }
)
vim.keymap.set(
	"n",
	"N",
	"'nN'[v:searchforward].'zv'",
	{ expr = true, desc = "Prev search result" }
)
vim.keymap.set(
	"x",
	"N",
	"'nN'[v:searchforward]",
	{ expr = true, desc = "Prev search result" }
)
vim.keymap.set(
	"o",
	"N",
	"'nN'[v:searchforward]",
	{ expr = true, desc = "Prev search result" }
)

-- Tab mappings
vim.keymap.set("n", "]t", "gt", { desc = "Next tabpage" })
vim.keymap.set("n", "[t", "gT", { desc = "Previous tabpage" })
vim.keymap.set(
	"n",
	"<leader>tn",
	function() vim.cmd("tabnew") end,
	{ desc = "New tab" }
)
vim.keymap.set(
	"n",
	"<leader>tc",
	function() vim.cmd("tabclose") end,
	{ desc = "Close tab" }
)

-- terminal
vim.keymap.set(
	"n",
	"<C-Space>",
	function() vim.cmd("ToggleTerminal") end,
	{ desc = "Quake terminal (toggle)", noremap = false, silent = true }
)
vim.keymap.set(
	"t",
	"<C-Space>",
	[[<C-Bslash><C-n>:ToggleTerminal<CR>]],
	{ silent = true }
)
