local cond = require("user_configs").lsp_enabled

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
		config = function()
			local dap_ok, dap = pcall(require, "dap")
			if not dap_ok then
				return
			end
			dap.defaults.fallback.terminal_win_cmd = "10split new"
		end,
	},
	{
		-- Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		cond = cond,
		lazy = true,
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", lazy = true, ft = "python" },
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
		dependencies = { "mfussenegger/nvim-dap", lazy = true, ft = "python" },
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
