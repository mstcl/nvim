-- Plugins that add things to the signcolumn (or foldcolumn)
return {
	{
		-- Git status in signcolumn
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufRead",
		dependencies = { { "nvim-lua/plenary.nvim", lazy = true, event = "VeryLazy" } },
		opts = {
			numhl = false,
			linehl = false,
			signcolumn = true,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			signs = {
				add = { hl = "DiffAdd", text = "+", numhl = "DiffAdd", linehl = "DiffAdd" },
				change = { hl = "DiffChange", text = "~", numhl = "DiffChange", linehl = "DiffChange" },
				delete = { hl = "DiffDelete", text = "‾", numhl = "DiffDelete", linehl = "DiffDelete" },
				topdelete = { hl = "DiffDelete", text = "‾", numhl = "DiffDelete", linehl = "DiffDelete" },
				changedelete = { hl = "DiffChange", text = "~", numhl = "DiffChange", linehl = "DiffChange" },
				untracked = { hl = "DiffAdd", text = "=", numhl = "DiffAdd", linehl = "DiffAdd" },
			},
			current_line_blame = false,
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			word_diff = false,
		},
	},
	{
		-- Show signs for folded blocks
		"lewis6991/foldsigns.nvim",
		lazy = true,
		event = "BufRead",
		opts = {
			exclude = { "LspDiagnosticsSignWarning" },
		},
	},
	{
		-- Utility to tweak statuscolumn
		"luukvbaal/statuscol.nvim",
		lazy = true,
		event = "BufRead",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				ft_ignore = { "help", "starter" },
				segments = {
					{
						text = {
							builtin.foldfunc,
						},
						click = "v:lua.ScFa",
					},
					{
						sign = {
							name = { ".*" },
							text = { ".*" },
							colwidth = 1,
							maxwidth = 2,
							auto = true,
						},
						click = "v:lua.ScSa",
					},
					{
						text = { " ", builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
				},
			})
		end,
	},
}
