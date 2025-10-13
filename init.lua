-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field, deprecated
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

---Shortcut syntax to create autocmd with augroup @param group string @vararg { [1]: string|string[], [2]: vim.api.keyset.create_autocmd }
---@return nil
_G.augroup = function(group, ...)
	local id = vim.api.nvim_create_augroup(group, { clear = true })
	for _, a in ipairs({ ... }) do
		a[2].group = id
		---@diagnostic disable-next-line: missing-parameter
		vim.api.nvim_create_autocmd(unpack(a))
	end
end

---Detecting big file size (> 400 KB)
---Normally we want to pass `vim.fn.expand("%")`
---@ param filepath string
---@return boolean
_G.big = function(filepath)
	if vim.fn.getfsize(filepath) > 400 * 1024 then
		return true
	end
	return false
end

require("plugin.00_variables")
require("plugin.10_statusline")
require("plugin.11_statuscol")
require("plugin.20_options")
require("plugin.25_terminal")
require("plugin.30_lazy")
require("plugin.40_commands")
require("plugin.41_quietmode")
require("plugin.50_autocmds")
require("plugin.60_mappings")
require("plugin.70_lsp")
require("plugin.80_pickers")
require("plugin.99_override")
