-- This file defines a function and a keybinding to create a dedicated
-- "select mode" for easily copying code.

-- The `select_mode` function will open the current buffer in a new tab,
-- disable a number of visual features like line numbers and fold columns,
-- automatically enter visual line mode, and map 'q' to close the tab.
-- This makes it easy to select and copy text from a terminal or SSH session.
local M = {}

function M.start()
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
end

return M
