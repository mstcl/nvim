-- Plugins that add debugging into nvim
return {
	{
		-- Python debugger
		"mfussenegger/nvim-dap-python",
		lazy = true,
		ft = "python",
		config = function()
			require("dap-python").setup("/usr/bin/python3", { justMyCode = false })
		end,
	},
	{
		-- General debugging engine
		"mfussenegger/nvim-dap",
		lazy = true,
		ft = "python",
		config = function()
			require("configs.debug.dap")
		end,
	},
	{
		-- Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		event = "VeryLazy",
		dependencies = "nvim-dap",
		opts = {},
	},
	{
		-- Show available DAP information panels
		"rcarriga/nvim-dap-ui",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
	},
}
