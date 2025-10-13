-- Plugins that add debugging into nvim
return {
	{ -- (nvim-dap-python) Python debugger
		"mfussenegger/nvim-dap-python",
		cond = _G.config.features.dap.enabled,
		ft = "python",
		config = function()
			require("dap-python").setup()
		end,
	},
	{ -- (nvim-dap) General debugging engine
		"mfussenegger/nvim-dap",
		cond = _G.config.features.dap.enabled,
		ft = "python",
		keys = {
			{
				"<leader>dbc",
				function()
					vim.cmd("DapContinue")
				end,
				desc = "continue",
			},
			{
				"<leader>dbo",
				function()
					vim.cmd("DapStepOver")
				end,
				desc = "step over",
			},
			{
				"<leader>dbO",
				function()
					vim.cmd("DapStepOut")
				end,
				desc = "step out",
			},
			{
				"<leader>dbi",
				function()
					vim.cmd("DapStepIn")
				end,
				desc = "step into",
			},
			{
				"<leader>dbk",
				function()
					vim.cmd("DapToggleBreakpoint")
				end,
				desc = "breakpoint toggle",
			},
		},
	},
	{ -- (nvim-dap-virtual-text) Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		cond = _G.config.features.dap.enabled,
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
		cond = _G.config.features.dap.enabled,
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<leader>D",
				function()
					vim.cmd("lua require('dapui').toggle()")
				end,
				desc = "DAP UI toggle",
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
				border = _G.config.border,
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
		},
	},
}
