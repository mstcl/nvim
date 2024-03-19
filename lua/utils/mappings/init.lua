local map = vim.keymap.set
local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
local winopt = vim.wo
if not wk_ok then
	return
end

-- Remove mappings
map("n", "Q", "")
map("n", "gQ", "")

-- General and groups
wk.register({
	["<leader>"] = { name = "Leader commands (pickers & LSP)" },
	["<space>"] = { ":", "Command", mode = { "n", "v" } },
	["<leader>o"] = { name = "Org mode actions" },
	["<leader>g"] = { name = "Git commands" },
	["<leader>e"] = { name = "Explorers (additional)" },
	["<leader>d"] = { name = "DAP commands" },
	["<leader>q"] = { name = "LSP commands" },
	["<C-M>"] = { name = "Toggle components" },
	["["] = { name = "Previous" },
	["]"] = { name = "Next" },
	["z"] = { name = "Folds, spelling & align" },
	["g"] = { name = "Comment, case & navigation" },
})

-- UI toggles
wk.register({
	["<C-N>"] = {
		function()
			if winopt.number then
				if winopt.relativenumber then
					winopt.number = false
					winopt.relativenumber = false
				else
					winopt.relativenumber = true
				end
			else
				winopt.number = true
			end
		end,
		"Cycle number mode",
	},
	["<C-L>"] = {
		":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
		"Clear screen & highlights",
	},
	["<C-M>s"] = {
		function()
			exec("setlocal spell! spelllang=en_gb")
		end,
		"Toggle spell checking",
	},
	["<C-M>n"] = {
		function()
			if winopt.list then
				winopt.list = false
			else
				winopt.list = true
			end
		end,
		"Toggle non-text characters",
	},
	["<C-M>l"] = {
		function()
			if winopt.cursorline then
				winopt.cursorline = false
			else
				winopt.cursorline = false
			end
		end,
		"Toggle cursorline",
	},
	["<C-M>f"] = {
		function()
			if winopt.foldcolumn == "1" then
				winopt.foldcolumn = "0"
			else
				winopt.foldcolumn = "1"
			end
		end,
		"Toggle foldcolumn",
	},
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

-- Buffer
if not require("user_configs").ui_features.tabline then
	wk.register({
		["<Left>"] = {
			function()
				exec("bprev")
			end,
			"Buffer previous",
		},
		["<Right>"] = {
			function()
				exec("bnext")
			end,
			"Buffer next",
		},
		["<leader><Left>"] = {
			function()
				exec("BufferMovePrevious")
			end,
			"Move buffer backward",
		},
		["<leader><Right>"] = {
			function()
				exec("BufferMoveNext")
			end,
			"Move buffer forward",
		},
		["<leader>`"] = {
			function()
				exec("bfirst")
			end,
			"Buffer first",
		},
		["<leader>-"] = {
			function()
				exec("blast")
			end,
			"Buffer last",
		},
		["<Down>"] = {
			function()
				exec("bunload")
			end,
			"Buffer unload",
		},
	})
end
