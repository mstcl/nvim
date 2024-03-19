local cond = require("user_configs").dap_enabled
local dap_ok, dap = pcall(require, "dap")

-- Plugins that add debugging into nvim
return {
	{
		-- Python debugger
		"mfussenegger/nvim-dap-python",
		cond = cond,
		lazy = true,
		ft = "python",
		config = function()
			require("dap-python").setup()
		end,
	},
	{
		-- General debugging engine
		"mfussenegger/nvim-dap",
		cond = cond,
		lazy = true,
		ft = "python",
		keys = {
			{
				"<leader>dp",
				"<cmd>Telescope dap commands<cr>",
				desc = "Pick dap commands",
			},
			{
				"<leader>dv",
				"<cmd>Telescope dap variables<cr>",
				desc = "Pick dap variables",
			},
			{
				"<leader>dc",
				"<cmd>DapContinue<cr>",
				desc = "Debug: Continue",
			},
			{
				"<leader>do",
				"<cmd>DapStepOver<cr>",
				desc = "Debug: Step over",
			},
			{
				"<leader>dO",
				"<cmd>DapStepOut<cr>",
				desc = "Debug: Step out",
			},
			{
				"<leader>di",
				"<cmd>DapStepIn<cr>",
				desc = "Debug: Step into",
			},
			{
				"<leader>db",
				"<cmd>DapToggleBreakpoint<cr>",
				desc = "Debug: breakpoint toggle",
			},
			{
				"<C-M>d",
				"<cmd>lua require('dapui').toggle()<cr>",
				desc = "Toggle DAP ui",
			},
		},
	},
	{
		-- Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		cond = cond,
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = false,
			commented = false,
			virt_text_pos = "eol",
			all_frames = false,
			virt_lines = false,
			virt_text_win_col = nil,
		},
	},
	{
		-- Show available DAP information panels
		"rcarriga/nvim-dap-ui",
		cond = cond,
		lazy = true,
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<C-M>d",
				desc = "Toggle DAP ui",
			},
		},
		opts = {
			icons = { expanded = "▾", collapsed = "▸" },
			mappings = {
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
			},
			sidebar = {
				elements = {
					{ id = "scopes",      size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
				},
				size = 25,
				position = "left",
			},
			tray = {
				elements = { "repl" },
				size = 3,
				position = "bottom",
			},
			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
		},
	},
}
