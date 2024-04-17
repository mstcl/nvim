-- Additional addons go here
return {
	-- "rktjmp/lush.nvim",
	-- "rktjmp/shipwright.nvim",
	{
		"nvim-orgmode/orgmode",
		opts = {
			org_capture_templates = { t = { description = "New task", template = "* TODO %?\n  %u" } },
			org_default_notes_file = "~/sftpgo/notes/Main.org",
			org_custom_exports = {
				c = {
					label = "Export to HTML format with CSS and MathJax",
					action = function(exporter)
						local current_file = vim.fn.expand("%:t")
						local target = vim.fn.expand("$HOME/sftpgo/shared/static/org/")
							.. vim.fn.fnamemodify(current_file, ":r")
							.. ".html"
						local command = {
							"pandoc",
							"-f",
							"org",
							"-s",
							current_file,
							"-o",
							target,
							"-c",
							vim.fn.expand("pandoc.css"),
							"--mathjax",
							"--toc",
						}
						local on_success = function(output)
							print("Success!")
							vim.api.nvim_echo({ { table.concat(output, "\n") } }, true, {})
						end
						local on_error = function(err)
							print("Error!")
							vim.api.nvim_echo({ { table.concat(err, "\n"), "ErrorMsg" } }, true, {})
						end
						return exporter(command, target, on_success, on_error)
					end,
				},
			},
		},
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
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = { "org" },
				disable = { "latex", "yaml" },
			},
		},
	},
	{
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
				vim.api.nvim_create_autocmd({ "BufEnter" }, {
					pattern = "wiki.bim.boats_*.txt",
					command = "set filetype=gemtext",
				})
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
