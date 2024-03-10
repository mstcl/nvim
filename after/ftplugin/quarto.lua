local setlocal = vim.opt_local

setlocal.shiftwidth = 4
setlocal.expandtab = true

local map = vim.keymap.set
local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end
local otter_ok, otter = pcall(require, "otter")
if not otter_ok then
	return
end

wk.register({
	["<leader>z"] = { name = "Molten operations" },
	["<leader>v"] = { name = "Quarto operations" },
})

local opts = { buffer = "true" }

wk.register({
	["<C-K><C-K>"] = {
		function()
			otter.ask_hover()
		end,
		"Otter hover",
		opts,
	},
	["<leader>qdd"] = {
		function()
			otter.ask_definition()
		end,
		"Otter definition",
		opts,
	},
	["<leader>qDD"] = {
		function()
			otter.ask_type_definition()
		end,
		"Otter type definition",
		opts,
	},
	["<leader>rr"] = {
		function()
			otter.ask_rename()
		end,
		"Otter rename",
		opts,
	},
	["<leader>qrr"] = {
		function()
			otter.ask_references()
		end,
		"Otter references",
		opts,
	},
	["<leader><space><space>"] = {
		function()
			otter.ask_format()
		end,
		"Otter format",
		opts,
	},
	["ze"] = {
		":<C-u>MoltenEvaluateVisual<CR>gv",
		"Evaluate Molten cell (visual)",
		mode = { "v" },
		opts,
	},
	["<leader>zd"] = {
		function()
			exec("MoltenDelete")
		end,
		"Delete Molten cell",
		opts,
	},
	["<leader>zh"] = {
		function()
			exec("MoltenHideOutput")
		end,
		"Hide Molten output",
		opts,
	},
	["<leader>zo"] = {
		function()
			exec("noautocmd MoltenEnterOutput")
		end,
		"Open Molten output",
		opts,
	},
	["]c"] = {
		function()
			exec("MoltenNext")
		end,
		"Next Molten cell",
		opts,
	},
	["[c"] = {
		function()
			exec("MoltenPrev")
		end,
		"Previous Molten cell",
		opts,
	},
	["<leader>v"] = {
		function()
			require("quarto.runner").run_cell()
		end,
		"Open Molten output",
		opts,
	},
})
