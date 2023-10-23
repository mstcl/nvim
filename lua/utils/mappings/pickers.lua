local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

wk.register({
	["<leader>h"] = {
		function()
			exec("Telescope oldfiles")
		end,
		"Pick history",
	},
	["<leader>l"] = {
		function()
			exec("Telescope resume")
		end,
		"Pick last used picker",
	},
	["<leader>c"] = {
		function()
			exec("Telescope aerial")
		end,
		"Pick document code symbols",
	},
	["<leader>m"] = {
		function()
			exec("Telescope commands")
		end,
		"Pick commands",
	},
	["<leader>t"] = {
		function()
			exec("Telescope builtin")
		end,
		"Pick telescope builtin pickers",
	},
	["<leader>p"] = {
		function()
			exec("Telescope lazy")
		end,
		"Pick plugins README (lazy)",
	},
	["<leader>f"] = {
		function()
			exec("Telescope find_files <CR>path=%:p:h")
		end,
		"Pick file in current path",
	},
	["<leader>e"] = { name = "Explorers (additional)" },
	["<leader>er"] = {
		function()
			exec("Telescope frecency")
		end,
		"Recent files",
	},
	["<leader>ep"] = {
		function()
			exec("Telescope projects")
		end,
		"Projects",
	},
	["<leader>ez"] = {
		function()
			exec("Telescope zoxide list")
		end,
		"Zoxide",
	},
	["<leader>n"] = {
		function()
			exec("Telescope noice")
		end,
		"Pick notifications",
	},
	["<leader>u"] = {
		function()
			exec("Telescope undo")
		end,
		"Pick undo tree",
	},
	["<leader>/"] = {
		function()
			exec("Telescope live_grep")
		end,
		"Pick live grep workspace results",
	},
	["<leader>\\"] = {
		function()
			exec("Telescope current_buffer_fuzzy_find")
		end,
		"Pick live grep buffer results",
	},
})
