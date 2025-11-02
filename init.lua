-- Setup mini.deps
local path_package = vim.fn.stdpath("data") .. "/site/"
local deps_path = path_package .. "pack/deps/start/mini.deps"
---@diagnostic disable-next-line: deprecated, undefined-field
if not (vim.uv or vim.loop).fs_stat(deps_path) then
	vim.cmd('echo "Installing `mini.deps`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-mini/mini.deps",
		deps_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.deps | helptags ALL")
	vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

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
	if vim.fn.getfsize(filepath) > 400 * 1024 then return true end
	return false
end

-- Some plugins and 'mini.nvim' modules only need setup during startup if Neovim
-- is started like `nvim -- path/to/file`, otherwise delaying setup is fine
_G.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later
