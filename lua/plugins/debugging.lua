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
			require("configs.dap")
		end,
	},
	{
		-- Show debugging variable values as virtual text
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = "nvim-dap",
		config = function()
			require("nvim-dap-virtual-text").setup({})
		end,
	},
	{
		-- Show available DAP information panels
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
	},
}
