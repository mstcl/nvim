-- Custom user mappings

-- Alias : to <space>
-- Normally I still use : a lot out of habit but sometimes if your pinky is
-- fatigued having this is accessible is great
vim.keymap.set(
	{ "n", "v" },
	"<space>",
	":",
	{ remap = false, desc = "Command", silent = true }
)

-- Overload default <C-L> with more stuff
vim.keymap.set(
	"n",
	"<C-L>",
	function() vim.cmd("Clear") end,
	{ desc = "Clear screen & highlights", noremap = false, silent = true }
)

-- Searching with nicer focus so you can actually follow it
vim.keymap.set("n", "n", "nzz", { desc = "Search previous result" })
vim.keymap.set("n", "N", "Nzz", { desc = "Search next result" })
vim.keymap.set("n", "*", "*zz", { desc = "Search matching forward (word)" })
vim.keymap.set("n", "#", "#zz", { desc = "Search matching backward (word)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search matching backward" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search matching backward" })

-- Quicker indenting (can hit multiple > or < in succession)
vim.keymap.set("x", "<", "<gv", { desc = "Unindent" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent" })

-- Quicker fold toggle
vim.keymap.set("n", "<S-Tab>", "za", { desc = "Fold" })

-- Enhanced tab mappings
vim.keymap.set(
	"n",
	"<C-W>N",
	function() vim.cmd("tabnew") end,
	{ desc = "Open new tab" }
)
vim.keymap.set(
	"n",
	"<C-W>C",
	function() vim.cmd("tabclose") end,
	{ desc = "Close current tab" }
)

vim.keymap.set(
	"n",
	"<C-Space>",
	function() vim.cmd("Toggle terminal") end,
	{ desc = "Quake terminal", noremap = false, silent = true }
)
vim.keymap.set(
	"t",
	"<C-Space>",
	[[<C-Bslash><C-n>:Toggle terminal<CR>]],
	{ silent = true }
)

-- Zoom window
-- (different to <C-W>| in that it's toggleable and the window is floating so
-- doesn't ruin your splits)
vim.keymap.set(
	{ "n", "v" },
	"<C-W>Z",
	require("mini.misc").zoom,
	{ desc = "Zoom window", remap = false, silent = true }
)

-- Toggle number mode
-- Used relatively often so it's handy to have a keymap
vim.keymap.set(
	"n",
	"<leader>n",
	function() vim.cmd("Toggle relative_number") end,
	{ desc = "Number relative toggle", noremap = false, silent = true }
)

-- Yank commit hash
-- Used relatively often so it's handy to have a keymap
vim.keymap.set(
	"n",
	"<leader>y",
	function() vim.cmd("YankCommitHash") end,
	{ desc = "Yank commit hash", noremap = false, silent = true }
)
