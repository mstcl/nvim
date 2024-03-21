local map = vim.keymap.set
local exec = vim.api.nvim_command
local winopt = vim.wo

-- Remove mappings
map("n", "Q", "")
map("n", "gQ", "")
map("n", "<leader>p", "<cmd>Lazy show<cr>", { desc = "Lazy" })

-- UI toggles
map("n", "<C-N>", function()
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
end, { desc = "Cycle number mode" })
map(
	"n",
	"<C-L>",
	":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
	{ desc = "Clear screen & highlights" }
)
map("n", "<C-M>s", function()
	exec("setlocal spell! spelllang=en_gb")
end, { desc = "Toggle spell checking" })
map("n", "<C-M>n", function()
	if winopt.list then
		winopt.list = false
	else
		winopt.list = true
	end
end, { desc = "Toggle non-text characters" })
map("n", "<C-M>l", function()
	if winopt.cursorline then
		winopt.cursorline = false
	else
		winopt.cursorline = false
	end
end, { desc = "Toggle cursorline" })
map("n", "<C-M>f", function()
	if winopt.foldcolumn == "1" then
		winopt.foldcolumn = "0"
	else
		winopt.foldcolumn = "1"
	end
end, { desc = "Toggle foldcolumn" })

-- Window splitting
map("n", "<C-S>v", function()
	exec("vs")
end, { desc = "Split vertical" })
map("n", "<C-S>h", function()
	exec("sp")
end, { desc = "Split horizontal" })

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
map("n", "<Tab>", "za", { desc = "Toggle current fold" })

-- Buffer
if not require("user_configs").ui_features.tabline then
	map("n", "<Left>", function()
		exec("bprev")
	end, { desc = "Buffer previous" })
	map("n", "<Right>", function()
		exec("bnext")
	end, { desc = "Buffer next" })
	map("n", "<leader>`", function()
		exec("bfirst")
	end, { desc = "Buffer first" })
	map("n", "<leader>-", function()
		exec("blast")
	end, { desc = "Buffer last" })
	map("n", "<Down>", function()
		exec("bunload")
	end, { desc = "Buffer unload" })
end
