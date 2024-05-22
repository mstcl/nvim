local map = vim.keymap.set
local exec = vim.api.nvim_command

-- Remove mappings
map("n", "Q", "")
map("n", "gQ", "")
map("n", "<leader>p", "<cmd>Lazy show<cr>", { desc = "Lazy" })

map({"n", "v"}, "<space>", ":", { remap = false, desc = "Command", silent = true })

-- UI toggles
map("n", "<C-N>", function()
	if vim.o.number then
		if vim.o.relativenumber then
			vim.o.number = false
			vim.o.relativenumber = false
			vim.notify("Number: off", vim.log.levels.INFO)
		else
			vim.o.relativenumber = true
			vim.notify("Number: relative", vim.log.levels.INFO)
		end
	else
		vim.o.number = true
		vim.notify("Number: static", vim.log.levels.INFO)
	end
end, { desc = "Cycle number mode" })
map(
	"n",
	"<C-L>",
	":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>",
	{ desc = "Clear screen & highlights" }
)
map("n", "<C-M>s", function()
	vim.opt_local.spell = not (vim.opt_local.spell:get())
	---@diagnostic disable-next-line: undefined-field
	if not (vim.opt_local.spell:get()) then
		vim.notify("Disabled spellchecking", vim.log.levels.INFO)
	else
		vim.notify("Enabled spellchecking", vim.log.levels.INFO)
	end
end, { desc = "Toggle spell checking" })
map("n", "<C-M>n", function()
	vim.wo.list = not vim.wo.list
	if not vim.wo.list then
		vim.notify("Disabled non-text characters", vim.log.levels.INFO)
	else
		vim.notify("Enabled non-text characters", vim.log.levels.INFO)
	end
end, { desc = "Toggle non-text characters" })
map("n", "<C-M>cl", function()
	vim.wo.cursorline = not vim.wo.cursorline
	if not vim.wo.cursorline then
		vim.notify("Disabled cursorline", vim.log.levels.INFO)
	else
		vim.notify("Enabled cursorline", vim.log.levels.INFO)
	end
end, { desc = "Toggle cursorline" })
map("n", "<C-M>f", function()
	vim.g.foldcolumn = not vim.g.foldcolumn
	if not vim.g.foldcolumn then
		vim.o.numberwidth = 3
		vim.notify("Disabled foldcolumn", vim.log.levels.INFO)
	else
		vim.o.numberwidth = 4
		vim.notify("Enabled foldcolumn", vim.log.levels.INFO)
	end
end, { desc = "Toggle foldcolumn" })
map("n", "<C-M>cc", function()
	if vim.wo.colorcolumn ~= "" then
		vim.wo.colorcolumn = ""
		vim.notify("Disabled cursorcolumn", vim.log.levels.INFO)
	else
		vim.wo.colorcolumn = "80"
		vim.notify("Enabled cursorcolumn", vim.log.levels.INFO)
	end
end, { desc = "Toggle cursorcolumn" })

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

-- Better search
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Buffer traversal
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]B", "<cmd>blast<cr>", { desc = "Last buffer" })
map("n", "[B", "<cmd>bfirst<cr>", { desc = "First buffer" })
map("n", "<C-Q>", "<cmd>confirm bdelete<cr>", { desc = "Delete buffer" })

-- save original gx to use as fallback
local old_gx = vim.fn.maparg("gx", "n", nil, true)
map("n", "gx", function()
	local word = vim.fn.expand("<cWORD>"):match("[\"']([%a_%.%-]+/[%a_%.%-]+)[\"']")
	if word then
		vim.ui.open("https://github.com/" .. word)
	else
		old_gx.callback()
	end
end, { desc = old_gx.desc })
