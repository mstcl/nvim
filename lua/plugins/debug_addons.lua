local conf = require("core.variables")
local condition = conf.dap_enabled

-- Plugins that add debugging into nvim
return {
	{ -- (nvim-dap-python) Python debugger
		"mfussenegger/nvim-dap-python",
		cond = condition,
		ft = "python",
		config = function()
			require("dap-python").setup()
		end,
	},
	{ -- (nvim-dap) General debugging engine
		"mfussenegger/nvim-dap",
		cond = condition,
		ft = "python",
		keys = {
			{
				"<leader>dbc",
				"<cmd>DapContinue<cr>",
				desc = "Debug: Continue",
			},
			{
				"<leader>dbo",
				"<cmd>DapStepOver<cr>",
				desc = "Debug: Step over",
			},
			{
				"<leader>dbO",
				"<cmd>DapStepOut<cr>",
				desc = "Debug: Step out",
			},
			{
				"<leader>dbi",
				"<cmd>DapStepIn<cr>",
				desc = "Debug: Step into",
			},
			{
				"<leader>dbk",
				function()
					vim.cmd("DapToggleBreakpoint")
				end,
				desc = "Debug: breakpoint toggle",
			},
		},
	},
	{ -- (nvim-dap-virtual-text) Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		cond = condition,
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
	{ -- (nvim-dap-ui) Show available DAP information panels
		"rcarriga/nvim-dap-ui",
		cond = condition,
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<leader>xd",
				function()
					vim.cmd("lua require('dapui').toggle()")
				end,
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
					{ id = "scopes", size = 0.25 },
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
				border = conf.border,
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
		},
	},
}
