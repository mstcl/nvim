local cond = require("core.variables").dap_enabled
local border = require("core.variables").border

-- Plugins that add debugging into nvim
return {
	{
		-- Python debugger
		"mfussenegger/nvim-dap-python",
		cond = cond,
		ft = "python",
		config = function()
			require("dap-python").setup()
		end,
	},
	{
		-- General debugging engine
		"mfussenegger/nvim-dap",
		cond = cond,
		ft = "python",
		keys = {
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
				function ()
					vim.cmd("DapToggleBreakpoint")
					vim.notify("Toggled DAP breakpoint", vim.log.levels.INFO)
				end,
				desc = "Debug: breakpoint toggle",
			},
			{
				"<C-M>d",
				function ()
					vim.cmd("lua require('dapui').toggle()")
					vim.notify("Toggled DAP ui", vim.log.levels.INFO)
				end,
				desc = "Toggle DAP ui",
			},
		},
		init = function()
			local wk = require("which-key")
			wk.register({
				["<leader>d"] = { name = "DAP commands" },
			})
		end,
	},
	{
		-- Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		cond = cond,
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
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<C-M>d"
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
				border = border,
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
		},
	},
}
