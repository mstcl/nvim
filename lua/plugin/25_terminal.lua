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

_G.toggle_terminal = function()
	if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then
		hide_terminal()
	else
		open_terminal()
	end
end
