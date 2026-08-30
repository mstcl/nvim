-- Custom user autocommands
-- this file is basically self-documenting and honestly it's a bit messy so
-- I won't be documenting every single one of them
local new_autocmd = _G.helpers.new_autocmd

_G.helpers.later(function()
	new_autocmd("autosave", {
		{ "BufLeave", "WinLeave", "FocusLost" },
		{
			nested = true,
			desc = "Autosave on focus change.",
			callback = function(args)
				-- Don't auto-save non-file buffers
				vim.uv.fs_stat(args.file, function(err, stat)
					if err or not stat or stat.type ~= "file" then return end
					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(args.buf) then return end
						vim.api.nvim_buf_call(
							args.buf,
							function()
								vim.cmd.update({ mods = { emsg_silent = true } })
							end
						)
					end)
				end)
			end,
		},
	})

	new_autocmd("formatoptions", {
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

	new_autocmd("clean", {
		{ "BufRead", "BufEnter", "BufReadPre", "FileType" },
		{
			desc = "disable some buffer noise for special buftypes/filetypes",
			pattern = { "*" },
			callback = function()
				local special_buftype = {
					nofile = true,
					help = true,
					quickfix = true,
					prompt = true,
					acwrite = true,
				}
				local special_filetype = {
					ipynb = true,
				}
				if
					special_buftype[vim.bo.buftype]
					or special_filetype[vim.bo.filetype]
				then
					vim.wo.colorcolumn = ""
					vim.opt_local.list = false
				end
			end,
		},
	})

	new_autocmd("prose", {
		{ "BufNewFile", "BufRead" },
		{
			desc = "enable text editing options, spellcheck and spell correction on certain filetypes",
			pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd", "*.typ" },
			callback = function()
				vim.opt_local.wrap = true
				vim.opt_local.list = false
				vim.opt_local.spell = true

				-- Set keymap for spell autocorrect
				vim.keymap.set(
					"i",
					"<C-L>",
					"<c-g>u<Esc>[s1z=`]a<c-g>u",
					{ noremap = true, silent = true }
				) -- autocorrect last spelling error
			end,
		},
	})

	new_autocmd("help", {
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

	new_autocmd("root", {
		{ "BufEnter" },
		{
			desc = "set cwd to project root directory",
			callback = function(args)
				local root = vim.fs.root(args.buf, {
					".git",
					"pyproject.toml",
					"README.md",
					"go.mod",
					"Cargo.toml",
				})
				if root and root ~= "." then pcall(vim.cmd.tcd, root) end
			end,
		},
	})

	new_autocmd("bigfile", {
		{ "BufReadPre" },
		{
			desc = "set settings for really big files",
			pattern = "*",
			callback = function()
				---@diagnostic disable-next-line: param-type-mismatch
				if _G.helpers.is_big_file(vim.fn.expand("%")) then
					vim.cmd("Mode bigfile")
				end
			end,
		},
	})

	new_autocmd("terminal", {
		{ "TermOpen", "BufWinEnter", "WinEnter" },
		{
			desc = "set settings for terminal",
			pattern = "*",
			callback = function()
				if vim.bo.buftype == "terminal" and vim.bo.filetype == "" then
					vim.cmd("Mode minimal")
				end
			end,
		},
	}, {
		{ "TermLeave" },
		{
			desc = "reload buffers when leaving terminal",
			pattern = "*",
			callback = function() vim.cmd.checktime() end,
		},
	})

	new_autocmd("lsp", {
		"LspAttach",
		{
			desc = "on attach for LSP",
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

				-- Set semantic tokens priority
				vim.hl.priorities.semantic_tokens = 125
				if client and vim.bo[args.buf].filetype == "python" then
					client.server_capabilities.semanticTokensProvider = nil
				end

				vim.keymap.set(
					"n",
					"gd",
					function() vim.cmd("FzfLua lsp_definitions") end,
					{
						desc = "Definition",
						noremap = true,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"grt",
					function() vim.cmd("FzfLua lsp_typedefs") end,
					{
						desc = "Type definition",
						noremap = true,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"grr",
					function() vim.cmd("FzfLua lsp_references") end,
					{
						desc = "References",
						noremap = true,
						silent = true,
						buffer = bufnr,
					}
				)

				vim.keymap.set(
					"n",
					"gri",
					function() vim.cmd("FzfLua lsp_implementations") end,
					{
						desc = "Implementation",
						noremap = true,
						silent = true,
						buffer = bufnr,
					}
				)

				if client.server_capabilities.inlayHintProvider then
					vim.keymap.set("n", "<leader>H", function()
						---@diagnostic disable-next-line: missing-parameter
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled()
						)
					end, {
						desc = "Hints",
						noremap = true,
						silent = true,
						buffer = bufnr,
					})
				end

				if client.server_capabilities.codeActionProvider then
					vim.keymap.set(
						"n",
						"gra",
						function() vim.cmd("FzfLua lsp_code_actions") end,
						{
							desc = "Code actions",
							noremap = true,
							silent = true,
							buffer = bufnr,
						}
					)
				end

				if client.server_capabilities.codeLensProvider then
					vim.keymap.set({ "n" }, "grl", vim.lsp.codelens.run, {
						desc = "Code lens",
						noremap = true,
						silent = true,
						buffer = bufnr,
					})
				end

				if client.server_capabilities.declarationProvider then
					vim.keymap.set(
						"n",
						"gD",
						function() vim.cmd("FzfLua lsp_declarations") end,
						{
							desc = "Declaration",
							noremap = true,
							silent = true,
							buffer = bufnr,
						}
					)
				end

				-- inlay hints
				if client.server_capabilities.inlayHintProvider then
					_G.helpers.lsp.setup_inlay_hints()
					vim.lsp.inlay_hint.enable(false) -- toggled off by default
				end

				-- code lens
				if client.server_capabilities.codeLensProvider then
					vim.lsp.codelens.enable(
						true,
						{ buffer = bufnr, client = client }
					)
					new_autocmd("codeLensRefresh", {
						{ "BufEnter", "CursorHold", "InsertLeave" },
						{
							buffer = bufnr,
							callback = function()
								vim.lsp.codelens.enable(true, {
									buffer = bufnr,
									client = client,
								})
							end,
						},
					})
				end
			end,
		},
	})

	local function stop_hlsearch()
		if vim.v.hlsearch == 1 then
			vim.api.nvim_feedkeys(
				vim.api.nvim_replace_termcodes("<Cmd>nohl<CR>", true, false, true),
				"n",
				false
			)
		end
	end

	new_autocmd("hlsearch", {
		"CursorMoved",
		{
			callback = function()
				local res = vim.fn.getreg("/")
				if vim.v.hlsearch == 0 or res == "" then return end
				if res:find([[%#]], 1, true) then
					stop_hlsearch()
					return
				end

				local ok, match = pcall(vim.fn.search, [[\%#\zs]] .. res, "cnW")
				if ok and match == 0 then stop_hlsearch() end
			end,
			desc = "Auto clear hlsearch on cursor move",
		},
	}, {
		"InsertEnter",
		{
			callback = stop_hlsearch,
			desc = "Auto clear hlsearch on insert mode",
		},
	})

	new_autocmd("quickfix", {
		"BufRead",
		{
			callback = function(ev)
				if vim.bo[ev.buf].buftype ~= "quickfix" then return end
				vim.schedule(function()
					local winid = vim.fn.bufwinid(ev.buf)
					local wintype = vim.fn.win_gettype(winid)
					local title = wintype == "loclist" and " Loclist "
						or " Quickfix "
					vim.api.nvim_win_set_config(winid, {
						title = title,
						relative = "msgarea",
						height = 12,
						style = "minimal",
					})
				end)
			end,
		},
	})

	new_autocmd("health", {
		{ "FileType" },
		{
			pattern = "checkhealth",
			callback = function(ev)
				vim.schedule(function()
					local winid = vim.fn.bufwinid(ev.buf)
					vim.api.nvim_win_set_config(winid, {
						title = "Health",
						relative = "msgarea",
						height = 12,
						style = "minimal",
					})
				end)
			end,
		},
	})
end)
