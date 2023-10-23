local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

wk.register({
	["<leader>g"] = { name = "Git commands" },
	["<leader>gs"] = {
		function()
			exec("Telescope git_status")
		end,
		"Git status",
	},
	["<leader>gc"] = {
		function()
			exec("Telescope git_commits")
		end,
		"Git commits (repo)",
	},
	["<leader>gC"] = {
		function()
			exec("Telescope git_bcommits")
		end,
		"Git commits (buffer)",
	},
	["<leader>gS"] = {
		function()
			exec("Gitsigns stage_hunk")
		end,
		"Stage hunk",
	},
	["<leader>gh"] = {
		function()
			exec("Gitsigns preview_hunk")
		end,
		"Preview hunk",
	},
	["<leader>gg"] = {
		function()
			_lazygit_toggle()
		end,
		"Lazygit",
	},
	["ih"] = {
		":<C-U>Gitsigns select_hunk<CR>",
		"Select hunk (operation)",
		mode = { "o", "x" },
	},
	["]g"] = {
		function()
			exec("Gitsigns next_hunk")
		end,
		"Next git hunk",
	},
	["[g"] = {
		function()
			exec("Gitsigns prev_hunk")
		end,
		"Previous git hunk",
	},
})
wk.register({
	["<leader>gS"] = {
		function()
			require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end,
		"Stage hunk (selection)",
		mode = { "v" },
	},
})
