local autocmd = vim.api.nvim_create_autocmd
local groupid = vim.api.nvim_create_augroup
local bo = vim.bo
local opt_local = vim.opt_local
local wo = vim.wo
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

---@param group string
---@vararg { [1]: string|string[], [2]: vim.api.keyset.create_autocmd }
---@return nil
local function augroup(group, ...)
	local id = groupid(group, { clear = true })
	for _, a in ipairs({ ... }) do
		a[2].group = id
		autocmd(unpack(a))
	end
end

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
}, {
	"BufReadPost",
	{
		pattern = "*.rasi",
		callback = function()
			opt_local.filetype = "css"
		end,
	},
}, {
	"BufReadPost",
	{
		pattern = "*.conf",
		callback = function()
			opt_local.filetype = "config"
		end,
	},
}, {
	"BufReadPost",
	{
		pattern = "*.sbat",
		callback = function()
			opt_local.filetype = "sh"
		end,
	},
}, {
	{ "BufReadPost", "BufNewFile" },
	{
		pattern = "*.yml",
		callback = function()
			opt_local.filetype = "yaml.ansible"
		end,
	},
}, {
	{ "BufReadPost", "BufNewFile" },
	{
		pattern = "**/docker-compose.yml",
		callback = function()
			opt_local.filetype = "yaml"
			opt_local.indentkeys = opt_local.indentkeys - "0#"
		end,
	},
}, {
	{ "BufReadPost", "BufNewFile" },
	{
		pattern = "*/fontconfig/*",
		command = "set ft=xml",
	},
})

augroup("text_opts", {
	{ "BufNewFile", "BufRead" },
	{
		desc = "Enable spellcheck and spell correction on certain filetypes",
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd", "*.typ" },
		callback = function()
			opt_local.list = false
			opt_local.spell = true
			map("i", "<C-L>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts) -- autocorrect last spelling error
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

augroup("showpaste", {
	{ "InsertLeave", "InsertEnter" },
	{
		pattern = "*",
		desc = "Enable showpaste in insert mode",
		callback = function()
			if opt_local.paste then
				opt_local.paste = false
			else
				opt_local.paste = true
			end
		end,
	},
})
