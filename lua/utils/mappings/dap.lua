local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end
local dap_ok, dap = pcall(require, "which-key")
if not dap_ok then
	return
end

wk.register({
	["<leader>d"] = { name = "DAP commands" },
	["<leader>dp"] = {
		function()
			exec("Telescope dap commands")
		end,
		"Pick dap commands",
	},
	["<leader>dv"] = {
		function()
			exec("Telescope dap variables")
		end,
		"Pick dap variables",
	},
	["<leader>dc"] = { dap.continue, "Debug: Continue" },
	["<leader>dC"] = {
		function()
			dap.set_breakpoint(vim.fn.input("Set breakpoint condition:"))
		end,
		"Debug: Step over",
	},
	["<leader>do"] = {
		function()
			dap.step_over()
		end,
		"Debug: Step over",
	},
	["<leader>dO"] = { dap.step_out, "Debug: Step out" },
	["<leader>di"] = { dap.step_into, "Debug: Step into" },
	["<leader>db"] = { dap.toggle_breakpoint, "Debug: breakpoint toggle" },
	["<leader>dl"] = {
		function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end,
		"Set log point message",
	},
})
