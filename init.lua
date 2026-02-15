-- Setup mini.nvim
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

local misc = require("mini.misc")
_G.now = function(f) misc.safely("now", f) end
_G.later = function(f) misc.safely("later", f) end
_G.now_if_args = vim.fn.argc(-1) > 0 and _G.now or _G.later
_G.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
_G.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

-- Commands for common minideps operations
vim.api.nvim_create_user_command("PackUpdate", function() vim.pack.update() end, {})

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
	if vim.fn.getfsize(filepath) > (400 * 1024) then return true end
	return false
end

-- Define custom `vim.pack.add()` hook helper. See `:h vim.pack-events`.
_G.on_packchanged = function(plugin_name, kinds, callback, desc)
	local f = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
			return
		end
		if not ev.data.active then vim.cmd.packadd(plugin_name) end
		callback()
	end
	_G.augroup("deps", {
		"PackChanged",
		{
			pattern = "*",
			callback = f,
			desc = desc,
		},
	})
end
