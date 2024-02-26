local map = vim.keymap.set
local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end
local opts = { noremap = true, silent = true }

-- Remove mappings
map("n", "Q", "", opts)
map("n", "gQ", "", opts)

-- General and groups
wk.register({
	["<leader>"] = { name = "Leader commands (pickers & LSP)" },
	["<space>"] = { ":", "Command", mode = { "n", "v" } },
	["<leader>o"] = { name = "Org mode actions" },
	["["] = { name = "Previous" },
	["]"] = { name = "Next" },
	["z"] = { name = "Folds, spelling & align" },
	["g"] = { name = "Comment, case & navigation" },
})

-- Window splitting
wk.register({
	["<C-S>"] = { name = "Split windows" },
	["<C-S>v"] = {
		function()
			exec("vs")
		end,
		"Split vertical",
	},
	["<C-S>h"] = {
		function()
			exec("sp")
		end,
		"Split horizontal",
	},
})

-- Searching
wk.register({
	["n"] = { "nzz", "Search previous result" },
	["N"] = { "Nzz", "Search next result" },
	["*"] = { "*zz", "Search matching forward (word)" },
	["#"] = { "#zz", "Search matching backward (word)" },
	["g*"] = { "g*zz", "Search matching backward" },
	["g#"] = { "g#zz", "Search matching backward" },
})

-- Indenting
wk.register({
	["<"] = { "<gv", "Unindent", mode = "x" },
	[">"] = { ">gv", "Indent", mode = "x" },
})

-- Folding
wk.register({
	["zR"] = { require("ufo").openAllFolds, "Open all folds" },
	["zM"] = { require("ufo").closeAllFolds, "Close all folds" },
	["<Tab>"] = { "za", "Toggle current fold" },
})
