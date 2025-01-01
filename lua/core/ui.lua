local components = require("core.components").components
local utils = require("core.utils")

---@diagnostic disable-next-line: duplicate-set-field
_G.get_statuscol = function()
	local win = vim.g.statusline_winid
	local args = {}

	args.lnum = vim.v.lnum
	args.relnum = vim.v.relnum
	args.virtnum = vim.v.virtnum

	args.nu = vim.api.nvim_get_option_value("nu", { win = win })
	args.rnu = vim.api.nvim_get_option_value("rnu", { win = win })

	return utils.lnumfunc(args) .. "%=%s" .. utils.get_fold(vim.v.lnum)
end

---@diagnostic disable-next-line: duplicate-set-field
_G.get_statusline = function()
	return table.concat({
		components.padding,
		components.modified,
		components.mode,
		components.padding,
		components.hl_alt,
		components.filepath,
		components.hl_main,
		components.filename,
		components.padding,
		components.hl_alt,
		components.open_bracket,
		components.hl_main,
		components.ft,
		components.padding,
		components.branch,
		components.padding,
		components.hl_main,
		components.diffs,
		components.hl_alt,
		components.close_bracket,
		components.hl_main,
		components.padding,
		components.symbol,
		components.padding,
		components.diagnostics,
		components.truncate,
		-- Messy middle bit
		components.align,
		components.hl_alt,
		components.macro,
		--
		components.hl_alt,
		components.search,
		--
		components.hl_orange,
		components.fformat,
		--
		components.hl_orange,
		components.fenc,
		-- Right most
		components.align,
		--
		components.hl_alt,
		components.info,
		--
		components.padding,
		components.padding,
		components.indentation,
		--
		components.padding,
		components.padding,
		components.scrollbar,
		--
		components.padding,
		components.padding,
		components.hl_restore,
	}, "")
end
