local augroup = require("core.utils").augroup

-- Plugins that add things to the signcolumn (or foldcolumn)
return {
	{
		-- Git status in signcolumn
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<C-M>g",
				function()
					vim.cmd("Gitsigns toggle_signs")
					vim.notify("Toggled git signs", vim.log.levels.INFO)
				end,
				desc = "Toggle gitsigns",
			},
			{
				"ih",
				":<C-U>Gitsigns select_hunk<CR>",
				desc = "Select hunk",
				mode = { "o", "x" },
			},
			{
				"[g",
				"<cmd>Gitsigns prev_hunk<cr><cmd>Gitsigns preview_hunk<cr>",
				desc = "Previous hunk",
			},
			{
				"]g",
				"<cmd>Gitsigns next_hunk<cr><cmd>Gitsigns preview_hunk<cr>",
				desc = "Next hunk",
			},
			{
				"<leader>gh",
				"<cmd>Gitsigns preview_hunk_inline<cr>",
				desc = "Preview hunk inline",
			},
			{
				"<leader>gS",
				"<cmd>Gitsigns stage_hunk<cr>",
				desc = "Stage hunk",
			},
			{
				"<leader>gS",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				desc = "Stage hunk",
				mode = { "v" },
			},
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			numhl = false,
			linehl = false,
			signcolumn = true,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			signs = {
				add = { hl = "DiffFGAdd", text = "▎", numhl = "DiffAdd", linehl = "DiffAdd" },
				change = { hl = "DiffFGChange", text = "▎", numhl = "DiffChange", linehl = "DiffChange" },
				delete = { hl = "DiffFGDelete", text = "▎", numhl = "DiffDelete", linehl = "DiffDelete" },
				topdelete = { hl = "DiffFGDelete", text = "▎", numhl = "DiffDelete", linehl = "DiffDelete" },
				changedelete = { hl = "DiffFGChange", text = "▎", numhl = "DiffChange", linehl = "DiffChange" },
				untracked = { hl = "DiffFGAdd", text = "▎", numhl = "DiffAdd", linehl = "DiffAdd" },
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
		event = "BufRead",
		opts = {
			exclude = { "LspDiagnosticsSignWarning" },
		},
	},
	-- {
	-- 	-- Utility to tweak statuscolumn
	-- 	"luukvbaal/statuscol.nvim",
	-- 	opts = function()
	-- 		local builtin = require("statuscol.builtin")
	-- 		return {
	-- 			relculright = true,
	-- 			ft_ignore = {
	-- 				"help",
	-- 				"starter",
	-- 				"Neogit*",
	-- 				"lazy",
	-- 				"toggleterm",
	-- 			},
	-- 			segments = {
	-- 				{
	-- 					text = {
	-- 						builtin.foldfunc,
	-- 					},
	-- 					click = "v:lua.ScFa",
	-- 				},
	-- 				{
	-- 					text = { builtin.lnumfunc, " " },
	-- 					condition = { true, builtin.not_empty },
	-- 					click = "v:lua.ScLa",
	-- 				},
	-- 				{
	-- 					sign = {
	-- 						name = { ".*" },
	-- 						text = { ".*" },
	-- 						colwidth = 1,
	-- 						maxwidth = 2,
	-- 						auto = true,
	-- 					},
	-- 					click = "v:lua.ScSa",
	-- 				},
	-- 				{
	-- 					text = { " " },
	-- 					hl = "SignColumn",
	-- 					condition = { true, builtin.not_empty },
	-- 					click = "v:lua.ScLa",
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- 	init = function(opts)
	-- 		augroup("loadStatuscolumn", {
	-- 			{ "BufReadPre" },
	-- 			{
	-- 				pattern = "*",
	-- 				desc = "Lazy load statuscol",
	-- 				callback = function()
	-- 					if not require("core.utils").big(vim.fn.expand("%")) then
	-- 						if vim.bo.filetype ~= "starter" and vim.wo.statuscolumn == "" then
	-- 							require("statuscol").setup(opts)
	-- 							vim.wo.statuscolumn = "%!v:lua.StatusCol()"
	-- 						end
	-- 					end
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
