local augroup = require("utils.misc").augroup
local autocmd = vim.api.nvim_create_autocmd
local bo = vim.bo
local opt_local = vim.opt_local
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

augroup("trim", {
	"BufWritePre",
	{
		desc = "Trim whitespace on write",
		pattern = "*",
		command = [[%s/\s\+$//e]],
	},
})

augroup("stay", {
	{ "BufWinLeave", "BufWritePost", "WinLeave" },
	{
		desc = "Save view with mkview for real files",
		callback = function(args)
			if vim.b[args.buf].view_activated then
				vim.cmd.mkview({ mods = { emsg_silent = true } })
			end
		end,
	},
}, {
	"BufWinEnter",
	{
		desc = "Try to load file view if available and enable view saving for real files",
		callback = function(args)
			if not vim.b[args.buf].view_activated then
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
				local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
				local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
				if
					buftype == ""
					and filetype
					and filetype ~= ""
					and not vim.tbl_contains(ignore_filetypes, filetype)
				then
					vim.b[args.buf].view_activated = true
					vim.cmd.loadview({ mods = { emsg_silent = true } })
				end
			end
		end,
	},
})

augroup("editing", {
	"BufEnter",
	{
		pattern = "*",
		desc = "Set the format options globally",
		callback = function()
			local vals = { "c", "r", "o" }
			for _, val in ipairs(vals) do
				opt_local.formatoptions:remove(val)
			end
		end,
	},
})

augroup("highlight_yank", {
	"TextYankPost",
	{
		pattern = "*",
		desc = "Highlight the selection on yank",
		command = 'silent! lua vim.highlight.on_yank{"IncSearch", 1000}',
	},
})

augroup("text_opts", {
	{ "BufNewFile", "BufRead" },
	{
		desc = "Enable text editing options, spellcheck and spell correction on certain filetypes",
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd", "*.typ" },
		callback = function()
			opt_local.list = false
			opt_local.spell = true
			opt_local.cursorline = false
			map("i", "<C-L>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts) -- autocorrect last spelling error
		end,
	},
})

augroup("vertical_help", {
	{ "FileType" },
	{
		desc = "Open help in vertical split",
		pattern = "help",
		callback = function()
			vim.bo.bufhidden = "unload"
			vim.cmd.wincmd("L")
			vim.cmd("vertical resize 81")
		end,
	},
})

augroup("starter", {
	{ "VimEnter" },
	{
		desc = "Starter autocmds",
		pattern = "*",
		callback = function()
			if bo.filetype == "starter" then
				opt_local.laststatus = 0
				vim.o.showtabline = 0
				vim.o.statuscolumn = ""
				autocmd({ "BufUnload" }, {
					pattern = "<buffer>",
					callback = function()
						opt_local.laststatus = 3
						vim.o.statuscolumn = "%!v:lua.StatusCol()"
						if require("user_configs").ui_features.tabline then
							vim.o.showtabline = 2
						end
					end,
				})
			end
		end,
	},
})