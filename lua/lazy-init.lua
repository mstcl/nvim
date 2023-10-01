local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup("plugins", {
	default = { lazy = true },
	install = {
		missing = true,
	},
	ui = {
		border = "single",
		icons = {
			cmd = "⌘",
			config = "",
			event = "",
			ft = "",
			init = "",
			keys = "",
			plugin = "",
			runtime = "",
			source = "",
			start = "",
			task = "",
			lazy = " ",
		},
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	disabled_plugins = {
		"gzip",
		"zip",
		"zipPlugin",
		"netrw",
		"netrwPlugin",
		"netrwSettings",
		"netrwFileHandlers",
		"tar",
		"tarPlugin",
		"getscript",
		"getscriptPlugin",
		"vimball",
		"vimballPlugin",
		"2html_plugin",
		"logipat",
		"rrhelper",
		"spellfile_plugin",
		"tutor_mode_plugin",
		"matchit",
		"matchparen",
	},
})
