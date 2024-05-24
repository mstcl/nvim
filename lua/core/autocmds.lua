local augroup = require("core.utils").augroup
local opt_local = vim.opt_local
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local big = require("core.utils").big

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

augroup("highlightYank", {
	"TextYankPost",
	{
		pattern = "*",
		desc = "Highlight the selection on yank",
		command = 'silent! lua vim.highlight.on_yank{"IncSearch", 1000}',
	},
})

augroup("textOpts", {
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

augroup("verticalHelp", {
	{ "Filetype" },
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

augroup("loadUI", {
	{ "BufReadPre" },
	{
		pattern = "*",
		desc = "Lazy load UI",
		callback = function()
			if vim.bo.filetype ~= "starter" then
				if vim.o.laststatus == 0 then
					vim.o.laststatus = 3
				end
				if vim.o.statusline == "" and not big(vim.fn.expand("%")) then
					vim.o.statusline = "%!v:lua.get_statusline()"
					vim.o.statuscolumn = "%!v:lua.get_statuscol()"
				end
			end
		end,
	},
})

augroup("rooter", {
	{ "BufEnter" },
	{
		desc = "Set cwd to project root directory",
		callback = function(args)
			if not big(vim.fn.expand("%")) then
				local root = vim.fs.root(args.buf, {
					".git",
					"Makefile",
					".hg",
					"project.json",
					".svn",
					"pyproject.toml",
					"README.md",
					"go.mod",
					".envrc",
					".editorconfig",
				})
				if root then
					---@diagnostic disable-next-line: undefined-field
					vim.uv.chdir(root)
				end
			end
		end,
	},
})

augroup("bigFile", {
	{ "BufReadPre" },
	{
		pattern = "*",
		callback = function()
			if big(vim.fn.expand("%")) then
				vim.opt_local.statusline = ""
				vim.opt_local.swapfile = false
				vim.opt_local.foldmethod = "manual"
				vim.opt_local.undolevels = -1
				vim.opt_local.undoreload = 0
				vim.opt_local.list = false
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.cursorline = false
				vim.opt_local.foldcolumn = "0"
				vim.opt_local.signcolumn = "no"
				vim.opt_local.colorcolumn = "0"
				vim.b.minianimate_disable = true
				vim.b.miniindentscope_disable = true
				vim.b.miniindentscope_disable = true
			end
		end,
	},
})
