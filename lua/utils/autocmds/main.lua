local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local call = vim.api.nvim_call_function
local bo = vim.bo
local cmd = vim.cmd
local setlocal = vim.opt_local
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

autocmd({ "ColorScheme" }, {
	pattern = "*",
	callback = function()
		call("SetupOrgColors", {})
	end,
})

local nvimcmp = augroup("nvimcmp", { clear = true })
autocmd({ "BufWritePost" }, {
	pattern = "*.snipppets",
	group = nvimcmp,
	command = "CmpUltisnipsReloadSnippets",
})

local stay = augroup("stay", { clear = true })
autocmd({ "BufReadPost" }, {
	pattern = "*",
	group = stay,
	command = "silent! normal! g`\"zv' zz",
})

local saveFold = augroup("saveFold", { clear = true })
autocmd({ "BufWinLeave" }, {
	pattern = "*.*",
	group = saveFold,
	command = "silent mkview",
})
autocmd({ "BufWinEnter" }, {
	pattern = "*.*",
	group = saveFold,
	command = "silent! loadview",
})

local editing = augroup("editing", { clear = true })
autocmd({ "BufEnter" }, {
	pattern = "*",
	group = editing,
	callback = function()
		local vals = { "c", "r", "o" }
		for _, val in ipairs(vals) do
			setlocal.formatoptions:remove(val)
		end
	end,
})

local highlight_yank = augroup("highlight_yank", { clear = true })
autocmd({ "TextYankPost" }, {
	pattern = "*",
	group = highlight_yank,
	command = 'silent! lua vim.highlight.on_yank{"IncSearch", 1000}',
})

local filetypes = augroup("filetypes", { clear = true })
autocmd({ "BufReadPost" }, {
	pattern = "*.rasi",
	group = filetypes,
	callback = function()
		setlocal.filetype = "css"
	end,
})
autocmd({ "BufReadPost" }, {
	pattern = "*.ipynb",
	group = filetypes,
	callback = function()
		setlocal.filetype = "python"
	end,
})
autocmd({ "BufReadPost" }, {
	pattern = "*.conf",
	group = filetypes,
	callback = function()
		setlocal.filetype = "config"
	end,
})
autocmd({ "BufReadPost" }, {
	pattern = "*.sbat",
	group = filetypes,
	callback = function()
		setlocal.filetype = "sh"
	end,
})
autocmd({ "BufReadPost" }, {
	pattern = "*.txt",
	group = filetypes,
	callback = function()
		setlocal.filetype = "dokuwiki"
	end,
})

local mdoptions = augroup("mdoptions", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.md", "*.txt", "*.tex", "*.org" },
	group = mdoptions,
	callback = function()
		setlocal.list = false
		setlocal.spell = true
		map("i", "<C-L>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts) -- autocorrect last spelling error
	end,
})
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.md" },
	group = mdoptions,
	callback = function()
		call("MathAndLiquid", {})
	end,
})

local org = augroup("org", { clear = true })
autocmd({ "Filetype" }, {
	pattern = "org",
	group = org,
	callback = function()
		setlocal.expandtab = true
		setlocal.list = false
		setlocal.conceallevel = 2
		setlocal.concealcursor = "nc"
		setlocal.shiftwidth = 2
		setlocal.foldlevel = 99
	end,
})

local starter = augroup("starter", { clear = true })
autocmd({ "VimEnter" }, {
	pattern = "*",
	group = starter,
	callback = function()
		if bo.filetype == "starter" then
			setlocal.laststatus = 0
			autocmd({ "BufUnload" }, {
				group = starter,
				pattern = "<buffer>",
				callback = function()
					setlocal.laststatus = 3
				end,
			})
		end
	end,
})

local telescope = augroup("telescope", { clear = true })
autocmd({ "Filetype" }, {
	pattern = "TelescopePrompt",
	group = telescope,
	callback = function()
		require("cmp").setup.buffer({ completion = { autocomplete = false } })
	end,
})

local showpaste = augroup("showpaste", { clear = true })
autocmd({ "InsertLeave", "InsertEnter" }, {
	pattern = "*",
	group = showpaste,
	callback = function()
		call("ShowPaste", {})
	end,
})

local autochdir = augroup("autochdir", { clear = true })
autocmd("BufWinEnter", {
	group = autochdir,
	pattern = "?*",
	callback = function()
		local ignoredFT = { "gitcommit", "DiffviewFileHistory", "" }
		if not bo.modifiable or vim.tbl_contains(ignoredFT, bo.filetype) or not (vim.fn.expand("%:p"):find("^/")) then
			return
		end
		cmd.cd(vim.fn.expand("%:p:h"))
	end,
})

function _G.set_terminal_keymaps()
	local opts_b = { buffer = 0 }
	vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts_b)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts_b)
end

local toggleterm = augroup("toggleterm", { clear = true })
autocmd({ "TermOpen" }, {
	pattern = "term://*",
	group = toggleterm,
	callback = function()
		set_terminal_keymaps()
	end,
})
