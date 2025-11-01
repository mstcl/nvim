-- Remember last place
MiniDeps.now(function()
	MiniDeps.add("vladdoster/remember.nvim")

	require("remember")
end)

-- Colorschemes
MiniDeps.now(function()
	MiniDeps.add("rktjmp/lush.nvim")
	MiniDeps.add("mstcl/tavern.nvim")
	MiniDeps.add("mstcl/ivory.nvim")

	vim.cmd.colorscheme("ivory_extended")
	vim.env.BAT_THEME = "ivory"
	vim.env.DELTA_FEATURES = "+ivory"
end)

-- (nvim-web-devicons) Icons
MiniDeps.now(function()
	MiniDeps.add("nvim-tree/nvim-web-devicons")

	require("nvim-web-devicons").setup({ variant = "light" })
end)

-- (mini.notify) Popup notifications
MiniDeps.now(function()
	MiniDeps.add("nvim-mini/mini.notify")
	vim.api.nvim_set_hl(0, "MiniNotifyTitle", { link = "DiagnosticOk" })

	require("mini.notify").setup({
		content = {
			format = function(notif)
				return " " .. "[" .. notif.level .. "]" .. " " .. notif.msg .. " "
			end,
		},
		lsp_progress = { enable = false },
		window = { max_width_share = 1, winblend = 0, config = { border = _G.config.border } },
	})

	local vim_notify_opts = {
		ERROR = { duration = 5000, hl_group = "DiagnosticOk" },
		WARN = { duration = 5000, hl_group = "DiagnosticOk" },
		INFO = { duration = 2000, hl_group = "DiagnosticOk" },
		DEBUG = { duration = 0, hl_group = "DiagnosticOk" },
		TRACE = { duration = 0, hl_group = "DiagnosticOk" },
		OFF = { duration = 0, hl_group = "DiagnosticSignOk" },
	}

	vim.notify = require("mini.notify").make_notify(vim_notify_opts)

	vim.keymap.set("n", "<leader>N", function()
		require("mini.notify").clear()
	end, { desc = "Dismiss all notifications", noremap = false, silent = true })
end)
