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

local stay = augroup("stay", { clear = true })

autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
	group = stay,
	desc = "Save view with mkview for real files",
	callback = function(args)
		if vim.b[args.buf].view_activated then
			vim.cmd.mkview({ mods = { emsg_silent = true } })
		end
	end,
})
autocmd("BufWinEnter", {
	desc = "Try to load file view if available and enable view saving for real files",
	group = stay,
	callback = function(args)
		if not vim.b[args.buf].view_activated then
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
			local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
			if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
				vim.b[args.buf].view_activated = true
				vim.cmd.loadview({ mods = { emsg_silent = true } })
			end
		end
	end,
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
autocmd("BufWritePre", {
	desc = "Close all notifications on BufWritePre",
	group = editing,
	callback = function()
		require("notify").dismiss({ pending = true, silent = true })
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

local mdoptions = augroup("mdoptions", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd" },
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
