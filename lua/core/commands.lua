local create_command = vim.api.nvim_create_user_command

-- Clean register
create_command("WipeReg", "for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor", { bang = false })

-- Oil replaces old explorer
create_command("E", "Oil", {})
create_command("Ex", "Oil", {})
create_command("Explore", "Oil", {})

-- Clear screen for real
create_command("Clear", function()
	vim.cmd("nohlsearch")
	vim.cmd("diffupdate")
	vim.cmd("syntax sync fromstart")
	vim.cmd("normal! <C-l>")
end, {})

-- Toggle number
create_command("ToggleNumber", function()
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
create_command("ToggleScrolloff", function()
	vim.opt.scrolloff = 999 - vim.o.scrolloff
end, {})

-- Toggle spelling
create_command("ToggleSpell", function()
	---@diagnostic disable-next-line: undefined-field
	vim.opt_local.spell = not (vim.opt_local.spell:get())
end, {})

-- Toggle nontext chars
create_command("ToggleList", function()
	vim.wo.list = not vim.wo.list
end, {})

-- Toggle cursorline
create_command("ToggleCursorLine", function()
	if vim.wo.cursorlineopt == "number" then
		vim.wo.cursorlineopt = "both"
	else
		vim.wo.cursorlineopt = "number"
	end
end, {})

-- Toggle foldcolumn
create_command("ToggleFoldColumn", function()
	vim.g.foldcolumn = not vim.g.foldcolumn
	if not vim.g.foldcolumn then
		vim.o.numberwidth = 3
	else
		vim.o.numberwidth = 4
	end
end, {})

-- Toggle colorcolumn
create_command("ToggleColorColumn", function()
	if vim.wo.colorcolumn ~= "" then
		vim.wo.colorcolumn = ""
	else
		vim.wo.colorcolumn = "80"
	end
end, {})

-- Check notification history
create_command("MsgHistory", "lua require('mini.notify').show_history()", {})

create_command("QuietMode", function()
	require("core.quietmode").start()
end, {})

create_command("MinimalMode", function()
	vim.b.minianimate_disable = true
	vim.b.miniindentscope_disable = true
	vim.wo.list = false
	vim.g.foldcolumn = false
	vim.wo.foldcolumn = "0"
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.cursorline = false
	vim.wo.statuscolumn = ""
	vim.wo.colorcolumn = ""
	vim.wo.signcolumn = "no"
end, {})

-- Get latest commit hash
create_command("GetCommitHash", function()
	local hash = vim.fn.system("git rev-parse HEAD")
	vim.fn.setreg('"', hash)
	vim.fn.setreg("+", hash)
	vim.notify("Copied commit hash to clipboard", vim.log.levels.INFO)
end, {})
