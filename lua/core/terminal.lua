local exec = vim.api.nvim_command

local M = {}

local t_buf = nil
local t_win_id = nil

local function split_new_terminal()
	if vim.api.nvim_win_get_width(0) >= 150 then
		exec("vsplit | winc L | vertical resize 50 | term ")
	else
		exec("split | winc J | resize 10 | term")
	end
end

local function split_existing_terminal()
	if vim.api.nvim_win_get_width(0) >= 150 then
		exec("vert sb " .. t_buf .. "| winc L | vertical resize 50")
	else
		exec("sb" .. t_buf .. "| winc J | resize 10")
	end
end

local function open_terminal()
	if vim.fn.bufexists(t_buf) ~= 1 then
		split_new_terminal()
		t_win_id = vim.fn.win_getid()
		t_buf = vim.fn.bufnr("%")
	elseif vim.fn.win_gotoid(t_win_id) ~= 1 then
		split_existing_terminal()
		t_win_id = vim.fn.win_getid()
	end
end

local function hide_terminal()
	if vim.fn.win_gotoid(t_win_id) == 1 then
		exec("hide")
	end
end

function M.Toggle()
	if vim.fn.win_gotoid(t_win_id) == 1 then
		hide_terminal()
	else
		open_terminal()
	end
end

return M
