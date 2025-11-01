-- Clean register
vim.api.nvim_create_user_command(
	"WipeReg",
	"for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor",
	{ bang = false }
)

-- Oil replaces old explorer
vim.api.nvim_create_user_command("E", "Oil", {})
vim.api.nvim_create_user_command("Ex", "Oil", {})
vim.api.nvim_create_user_command("Explore", "Oil", {})

-- Clear screen for real
vim.api.nvim_create_user_command("Clear", function()
	vim.cmd("nohlsearch")
	vim.cmd("diffupdate")
	vim.cmd("syntax sync fromstart")
	vim.cmd("normal! <C-l>")
end, {})

-- Toggle number
vim.api.nvim_create_user_command("ToggleNumber", function()
	if vim.o.number then
		if vim.o.relativenumber then
			vim.o.number = false
			vim.o.relativenumber = false
		else
			vim.o.relativenumber = true
		end
	else
		vim.o.number = true
	end
end, {})

-- Toggle scrolloff
vim.api.nvim_create_user_command("ToggleScrolloff", function()
	vim.opt.scrolloff = 999 - vim.o.scrolloff
end, {})

-- Toggle spelling
vim.api.nvim_create_user_command("ToggleSpell", function()
	---@diagnostic disable-next-line: undefined-field
	vim.opt_local.spell = not (vim.opt_local.spell:get())
end, {})

-- Toggle nontext chars
vim.api.nvim_create_user_command("ToggleList", function()
	vim.wo.list = not vim.wo.list
end, {})

-- Toggle cursorline
vim.api.nvim_create_user_command("ToggleCursorLine", function()
	if vim.wo.cursorlineopt == "number" then
		vim.wo.cursorlineopt = "both"
	else
		vim.wo.cursorlineopt = "number"
	end
end, {})

-- Toggle foldcolumn
-- vim.api.nvim_create_user_command("ToggleFoldColumn", function()
-- vim.g.foldcolumn = not vim.g.foldcolumn
-- if not vim.g.foldcolumn then
-- 	vim.o.numberwidth = 3
-- else
-- 	vim.o.numberwidth = 4
-- end
-- end, {})

-- Toggle colorcolumn
vim.api.nvim_create_user_command("ToggleColorColumn", function()
	if vim.wo.colorcolumn ~= "" then
		vim.wo.colorcolumn = ""
	else
		vim.wo.colorcolumn = "80"
	end
end, {})

-- Check notification history
vim.api.nvim_create_user_command("MsgHistory", "lua require('mini.notify').show_history()", {})

-- Minimal mode
vim.api.nvim_create_user_command("MinimalMode", function()
	vim.b.minianimate_disable = true
	vim.b.miniindentscope_disable = true
	vim.wo.list = false
	vim.wo.foldcolumn = "0"
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.statuscolumn = ""
	vim.wo.colorcolumn = ""
	vim.wo.signcolumn = "no"
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

	vim.keymap.set("n", "q", function()
		vim.cmd("tabclose")
	end, { buffer = true, desc = "quit select mode and return to previous tab" })
end, {})

-- Get latest commit hash
vim.api.nvim_create_user_command("GetCommitHash", function()
	local hash = vim.fn.system("git rev-parse HEAD")
	vim.fn.setreg('"', hash)
	vim.fn.setreg("+", hash)
	vim.notify("Copied commit hash to clipboard", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("PairModeEnter", function()
	vim.wo.cursorlineopt = "both"
	vim.cmd("NvimTreeOpen")
	vim.cmd("wincmd p")
end, {})

vim.api.nvim_create_user_command("PairModeLeave", function()
	vim.wo.cursorlineopt = "number"
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
	if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then
		vim.cmd("hide")
	end
end

vim.api.nvim_create_user_command("ToggleTerminal", function()
	if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then
		hide_terminal()
	else
		open_terminal()
	end
end, {})
