_G.quiet_mode = function()
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
