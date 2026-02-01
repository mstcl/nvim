-- clean register
vim.api.nvim_create_user_command(
	"WipeReg",
	"for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor",
	{ bang = false }
)

-- oil replaces old explorer
vim.api.nvim_create_user_command("E", "Oil", {})
vim.api.nvim_create_user_command("Ex", "Oil", {})
vim.api.nvim_create_user_command("Explore", "Oil", {})

-- clear screen for real
vim.api.nvim_create_user_command("Clear", function()
	vim.cmd("nohlsearch")
	vim.cmd("diffupdate")
	vim.cmd("syntax sync fromstart")
	vim.cmd("normal! <C-l>")
end, {})

-- toggle number
vim.api.nvim_create_user_command("ToggleNumber", function()
	if vim.wo.number then
		if vim.wo.relativenumber then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
		else
			vim.opt_local.relativenumber = true
		end
	else
		vim.opt_local.number = true
	end
end, {})

-- toggle scrolloff
vim.api.nvim_create_user_command(
	"ToggleScrolloff",
	function() vim.opt_local.scrolloff = 999 - vim.wo.scrolloff end,
	{}
)

-- toggle tabline
vim.api.nvim_create_user_command(
	"ToggleTabLine",
	function() vim.o.showtabline = vim.o.showtabline == 1 and 0 or 1 end,
	{}
)

-- toggle spelling
vim.api.nvim_create_user_command(
	"ToggleSpell",
	function() vim.opt_local.spell = not vim.wo.spell end,
	{}
)

-- toggle nontext chars
vim.api.nvim_create_user_command(
	"ToggleList",
	function() vim.opt_local.list = not vim.wo.list end,
	{}
)

-- toggle cursorline
vim.api.nvim_create_user_command("ToggleCursorLine", function()
	if vim.wo.cursorlineopt == "number" then
		vim.opt_local.cursorlineopt = "both"
	else
		vim.opt_local.cursorlineopt = "number"
	end
end, {})

-- toggle foldcolumn
-- vim.api.nvim_create_user_command("ToggleFoldColumn", function()
-- vim.g.foldcolumn = not vim.g.foldcolumn
-- if not vim.g.foldcolumn then
-- 	vim.o.numberwidth = 3
-- else
-- 	vim.o.numberwidth = 4
-- end
-- end, {})

-- toggle colorcolumn
vim.api.nvim_create_user_command("ToggleColorColumn", function()
	if vim.wo.colorcolumn ~= "" then
		vim.opt_local.colorcolumn = ""
	else
		vim.opt_local.colorcolumn = "80"
	end
end, {})

-- minimal mode
vim.api.nvim_create_user_command("MinimalMode", function()
	vim.b.minianimate_disable = true
	vim.b.miniindentscope_disable = true
	vim.b.indent_guide = false
	vim.opt_local.list = false
	vim.opt_local.foldcolumn = "0"
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.statuscolumn = ""
	vim.opt_local.colorcolumn = ""
	vim.opt_local.signcolumn = "no"
end, {})

vim.api.nvim_create_user_command("BigFileMode", function()
	---@diagnostic disable-next-line: unnecessary-if
	-- disable matchparen
	if vim.fn.exists(":DoMatchParen") ~= 2 then return end
	vim.cmd("NoMatchParen")

	-- defer disable lsp
	_G.augroup("bigfile_deferred", {
		"LspAttach",
		{
			desc = "detach client for big files",
			callback = function(args)
				local bufnr = args.buf
				vim.schedule(
					function() vim.lsp.buf_detach_client(bufnr, args.data.client_id) end
				)
			end,
		},
	}, {
		"BufReadPost",
		{
			desc = "deferred actions for big files",
			callback = function()
				vim.cmd("syntax clear")
				vim.opt_local.syntax = "OFF"
				vim.opt_local.filetype = ""
			end,
		},
	})

	-- disable swap
	vim.opt_local.swapfile = false

	-- turn off expr fold
	vim.opt_local.foldmethod = "manual"

	-- disable undotree
	vim.opt_local.undolevels = -1
	vim.opt_local.undoreload = 0

	-- turn on minimal mode
	vim.cmd("MinimalMode")
end, {})

-- Quiet mode
vim.api.nvim_create_user_command("QuietMode", function()
	-- Get the number of the current buffer.
	local current_buf = vim.api.nvim_get_current_buf()

	-- Open a new tab and create a new window within it.
	vim.cmd("tabnew")
	local new_win = vim.api.nvim_get_current_win()

	-- Load the original buffer into the new window.
	-- This ensures you are viewing the exact same file content.
	vim.api.nvim_win_set_buf(new_win, current_buf)

	vim.g.pastemode = true
	vim.cmd("MinimalMode")

	vim.keymap.set(
		"n",
		"q",
		function() vim.cmd("tabclose") end,
		{ buffer = true, desc = "quit select mode and return to previous tab" }
	)
end, {})

-- Get latest commit hash
vim.api.nvim_create_user_command("GetCommitHash", function()
	local hash = vim.fn.system("git rev-parse HEAD")
	vim.fn.setreg('"', hash)
	vim.fn.setreg("+", hash)
	vim.notify("Copied commit hash to clipboard", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("PairModeEnter", function()
	vim.opt.cursorlineopt = "both"
	vim.cmd("NvimTreeOpen")
	vim.cmd("wincmd p")
end, {})

vim.api.nvim_create_user_command("PairModeLeave", function()
	vim.opt.cursorlineopt = "number"
	vim.cmd("NvimTreeClose")
end, {})

local function split_new_terminal()
	if vim.api.nvim_win_get_width(0) >= 350 then
		vim.cmd("vsplit | winc L | vertical resize 150 | term")
	else
		vim.cmd("split | winc J | resize 10 | term")
	end
end

local function split_existing_terminal()
	if vim.api.nvim_win_get_width(0) >= 350 then
		vim.cmd("vert sb " .. vim.t.t_buf .. "| winc L | vertical resize 150")
	else
		vim.cmd("sb" .. vim.t.t_buf .. "| winc J | resize 10")
	end
end

local function open_terminal()
	if vim.fn.bufexists(vim.t.t_buf) ~= 1 then
		split_new_terminal()
		vim.t.t_win_id = vim.fn.win_getid()
		vim.t.t_buf = vim.fn.bufnr("%")
	elseif vim.fn.win_gotoid(vim.t.t_win_id) ~= 1 then
		split_existing_terminal()
		vim.t.t_win_id = vim.fn.win_getid()
	end
end

local function hide_terminal()
	if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then vim.cmd("hide") end
end

vim.api.nvim_create_user_command("ToggleTerminal", function()
	if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then
		hide_terminal()
	else
		open_terminal()
	end
end, {})

vim.api.nvim_create_user_command(
	"WorkspaceSymbols",
	vim.lsp.buf.workspace_symbol,
	{}
)

vim.api.nvim_create_user_command(
	"WorkspaceDiagnostics",
	vim.diagnostic.setqflist,
	{}
)

vim.api.nvim_create_user_command("DocumentSymbols", vim.lsp.buf.document_symbol, {})

vim.api.nvim_create_user_command(
	"DocumentDiagnostics",
	vim.diagnostic.setloclist,
	{}
)
