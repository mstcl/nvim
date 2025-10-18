local opts = { noremap = true, silent = true }

local function is_valid_git_repo(buf_id)
	-- Check if it's a valid buffer
	local path = vim.api.nvim_buf_get_name(buf_id)
	if path == "" or vim.fn.filereadable(path) ~= 1 then
		return false
	end

	-- Check if the current directory is a Git repository
	if vim.fn.isdirectory(".git") == 0 then
		return false
	end

	return true
end

local branch_cache = {}

-- Function to clear the Git branch cache
local function clear_git_branch_cache()
	-- Clear by doing an empty table :)
	branch_cache = {}
end

local function update_git_branch(data)
	if not is_valid_git_repo(data.buf) then
		return
	end

	-- Check if branch is already cached
	local cached_branch = branch_cache[data.buf]
	if cached_branch then
		vim.b.git_branch = cached_branch
		return
	end

	---@diagnostic disable-next-line: undefined-field
	local stdout = vim.uv.new_pipe(false)
	---@diagnostic disable-next-line: undefined-field
	local _, _ = vim.uv.spawn(
		"git",
		{
			args = { "-C", vim.fn.expand("%:p:h"), "branch", "--show-current" },
			stdio = { nil, stdout, nil },
		},
		vim.schedule_wrap(function(code, _)
			if code == 0 then
				stdout:read_start(function(_, content)
					if content then
						vim.b.git_branch = content:gsub("\n", "") -- Remove newline character
						branch_cache[data.buf] = vim.b.git_branch -- Cache the branch name
						stdout:close()
					end
				end)
			else
				stdout:close()
			end
		end)
	)
end

---@diagnostic disable-next-line: unnecessary-if
if _G.config.features.lsp.enabled then
	_G.augroup("diagnosticUpdate", {
		{ "DiagnosticChanged" },
		{
			desc = "update diagnostics cache for the status line.",
			callback = function(info)
				local b = vim.b[info.buf]
				local diagnostic_cnt_cache = { 0, 0, 0, 0 }
				for _, diagnostic in ipairs(info.data.diagnostics) do
					diagnostic_cnt_cache[diagnostic.severity] = diagnostic_cnt_cache[diagnostic.severity] + 1
				end
				b.diagnostic_str_cache = nil
				b.diagnostic_cnt_cache = diagnostic_cnt_cache
			end,
		},
	})
end

_G.augroup("gitBranch", {
	"BufWinEnter",
	{
		desc = "Refresh git branch",
		callback = update_git_branch,
	},
}, {
	"DirChanged",
	{
		desc = "Clear git branch",
		callback = clear_git_branch_cache,
	},
})

_G.augroup("trim", {
	"BufWritePre",
	{
		desc = "trim whitespace on write",
		pattern = "*",
		command = [[%s/\s\+$//e]],
	},
})

_G.augroup("hideComponents", {
	"BufEnter",
	{
		desc = "hide components",
		pattern = "*",
		callback = function()
			local filetypes = { "DiffviewFiles" }
			local current_ft = vim.bo.filetype
			if vim.tbl_contains(filetypes, current_ft) then
				vim.cmd("MinimalMode")
			end
		end,
	},
})

_G.augroup("editing", {
	"BufEnter",
	{
		pattern = "*",
		desc = "set the format options globally",
		callback = function()
			local vals = { "c", "r", "o" }
			for _, val in ipairs(vals) do
				vim.opt_local.formatoptions:remove(val)
			end
		end,
	},
})

_G.augroup("textOpts", {
	{ "BufNewFile", "BufRead" },
	{
		desc = "enable text editing options, spellcheck and spell correction on certain filetypes",
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd", "*.typ" },
		callback = function()
			vim.opt_local.list = false
			vim.opt_local.spell = true
			vim.opt_local.cursorline = false

			-- Set keymap for spell autocorrect
			vim.keymap.set("i", "<C-L>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts) -- autocorrect last spelling error
		end,
	},
})

_G.augroup("activateOtter", {
	{ "BufNewFile", "BufRead" },
	{
		desc = "activate Otter",
		pattern = { "*.md", "*.qmd" },
		callback = function()
			require("otter").activate()
		end,
	},
})

_G.augroup("verticalHelp", {
	{ "Filetype" },
	{
		desc = "open help in vertical split",
		pattern = "help",
		callback = function()
			vim.bo.bufhidden = "unload"
			vim.cmd.wincmd("L")
			vim.cmd("vertical resize 81")
		end,
	},
})

_G.augroup("rooter", {
	{ "BufEnter" },
	{
		desc = "set cwd to project root directory",
		callback = function(args)
			local root = vim.fs.root(args.buf, {
				".git",
				"pyproject.toml",
				"README.md",
				"go.mod",
			})
			if root then
				---@diagnostic disable-next-line: undefined-field
				vim.fn.chdir(root)
			end
		end,
	},
})

_G.augroup("bigFile", {
	{ "BufReadPre" },
	{
		desc = "set settings for really big files",
		pattern = "*",
		callback = function()
			if _G.big(vim.fn.expand("%")) then
				vim.opt.statusline = ""
				vim.opt_local.swapfile = false
				vim.opt_local.foldmethod = "manual"
				vim.opt_local.undolevels = -1
				vim.opt_local.undoreload = 0

				vim.cmd("MinimalMode")
			end
		end,
	},
})

_G.augroup("terminal", {
	{ "TermOpen", "BufWinEnter", "WinEnter" },
	{
		desc = "set settings for terminal",
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "terminal" and vim.bo.filetype == "" then
				vim.cmd("startinsert")
				vim.cmd("MinimalMode")

				-- Keymaps to leave
				vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { silent = true, buffer = 0 })
				vim.keymap.set(
					"t",
					"<C-Bslash><C-Bslash>",
					[[<C-\><C-n>:ToggleTerminal<CR>]],
					{ silent = true, buffer = 0 }
				)

				-- Also map <C-\> to <Esc> to avoid interuptting Claude code
				vim.keymap.set("t", "<C-Bslash>", function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
				end)
			end
		end,
	},
}, {
	{ "BufLeave" },
	{
		pattern = "term://*",
		desc = "Stop insert when leaving terminal",
		callback = function()
			if vim.bo.buftype == "terminal" and vim.bo.filetype == "" then
				vim.cmd("stopinsert")
			end
		end,
	},
}, {
	{ "TermLeave" },
	{
		desc = "Reload buffers when leaving terminal",
		pattern = "*",
		callback = function()
			vim.cmd.checktime()
		end,
	},
})
