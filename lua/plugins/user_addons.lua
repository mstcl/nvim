-- Additional addons go here
return {
	{
		-- Colorscheme converter & visualization
		"rktjmp/lush.nvim",
		lazy = true,
		cmd = { "Lushify" },
	},
	{
		-- Colorscheme builder
		"rktjmp/shipwright.nvim",
		lazy = true,
		cmd = { "Shipwright" },
	},
	{
		"chrishrb/gx.nvim",
		opts = {
			handler_options = {
				search_engine = "https://sxn.lonely-desk.top/search?q=",
			},
		},
	},
	{
		-- Neovim in the browser!
		"glacambre/firenvim",
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		init = function()
			if vim.g.started_by_firenvim then
				vim.cmd(
					[[ let g:firenvim_config['localSettings']['.*'] = { 'takeover': 'never', 'cmdline': 'neovim' } ]]
				)
			end
		end,
	},
	{
		"echasnovski/mini.starter",
		cond = function()
			if vim.tbl_contains(vim.v.argv, "-R") or vim.g.started_by_firenvim == true then
				return false
			end
			return true
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		cond = vim.fn.getcwd() == vim.fn.expand("/hades/projects/msci-wiki"),
	},
}
