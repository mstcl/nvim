_G.augroup("trim", {
	"BufWritePre",
	{
		desc = "trim whitespace on write",
		pattern = "*",
		command = [[%s/\s\+$//e]],
	},
})

_G.augroup("formatoptions", {
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

_G.augroup("prose", {
	{ "BufNewFile", "BufRead" },
	{
		desc = "enable text editing options, spellcheck and spell correction on certain filetypes",
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd", "*.typ" },
		callback = function()
			vim.opt_local.list = false
			vim.opt_local.spell = true
			vim.opt_local.cursorline = false

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

_G.augroup("help", {
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

_G.augroup("root", {
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
			if root and root ~= "." then pcall(vim.cmd.tcd, root) end
		end,
	},
})

_G.augroup("bigfile", {
	{ "BufReadPre" },
	{
		desc = "set settings for really big files",
		pattern = "*",
		callback = function()
			if _G.big(vim.fn.expand("%")) then vim.cmd("BigFileMode") end
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
			end
		end,
	},
}, {
	{ "BufLeave" },
	{
		pattern = "term://*",
		desc = "stop insert when leaving terminal",
		callback = function()
			if vim.bo.buftype == "terminal" and vim.bo.filetype == "" then
				vim.cmd("stopinsert")
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

_G.augroup("lsp", {
	"LspAttach",
	{
		desc = "on attach for LSP",
		callback = function(args)
			local bufnr = args.buf
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

			-- Prevent LSP from overwriting treesitter color settings
			vim.highlight.priorities.semantic_tokens = 120

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
				desc = "Definition",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, {
				desc = "Type definition",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "grr", vim.lsp.buf.references, {
				desc = "References",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
				desc = "Implementation",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>Ds", vim.lsp.buf.document_symbol, {
				desc = "Document symbols (qf)",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>DD", vim.diagnostic.setloclist, {
				desc = "Document diagnostics (loc)",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, {
				desc = "Workspace diagnostics (qf)",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "<leader>wS", vim.lsp.buf.workspace_symbol, {
				desc = "Workspace symbols (query)",
				silent = true,
				noremap = true,
				buffer = bufnr,
			})

			-- vim.keymap.set("n", "<leader>v", function()
			-- 	---@diagnostic disable-next-line: undefined-field
			-- 	if vim.diagnostic.config().virtual_lines == false then
			-- 		vim.diagnostic.config({
			-- 			virtual_lines = _G.config.diagnostics.virtual_lines,
			-- 		})
			-- 	else
			-- 		vim.diagnostic.config({
			-- 			virtual_lines = false,
			-- 		})
			-- 	end
			-- end, {
			-- 	desc = "Virtual lines (toggle)",
			-- 	noremap = true,
			-- 	silent = true,
			-- 	buffer = bufnr,
			-- })
			--
			-- vim.keymap.set("n", "<leader>V", function()
			-- 	---@diagnostic disable-next-line: undefined-field
			-- 	if vim.diagnostic.config().virtual_text == false then
			-- 		vim.diagnostic.config({
			-- 			virtual_text = _G.config.diagnostics.virtual_text,
			-- 		})
			-- 	else
			-- 		vim.diagnostic.config({
			-- 			virtual_text = false,
			-- 		})
			-- 	end
			-- end, {
			-- 	desc = "Virtual text (toggle)",
			-- 	noremap = true,
			-- 	silent = true,
			-- 	buffer = bufnr,
			-- })

			if client.server_capabilities.inlayHintProvider then
				vim.keymap.set("n", "<leader>i", function()
					---@diagnostic disable-next-line: missing-parameter
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, {
					desc = "Inlay hints (toggle)",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
			end

			if client.server_capabilities.codeActionProvider then
				vim.keymap.set("n", "gra", vim.lsp.buf.code_action, {
					desc = "Code actions",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set(
					"v",
					"gra",
					":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
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
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
					desc = "Declaration",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
			end

			-- update diagnostic cache
			_G.augroup("diagnosticUpdate", {
				{ "DiagnosticChanged" },
				{
					desc = "update diagnostics cache for the status line.",
					callback = function(info)
						local b = vim.b[info.buf]
						local diagnostic_cnt_cache = { 0, 0, 0, 0 }
						for _, diagnostic in ipairs(info.data.diagnostics) do
							diagnostic_cnt_cache[diagnostic.severity] = diagnostic_cnt_cache[diagnostic.severity]
								+ 1
						end
						b.diagnostic_str_cache = nil
						b.diagnostic_cnt_cache = diagnostic_cnt_cache
					end,
				},
			})

			-- inlay hints
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(_G.config.features.lsp.inlay_hints)
			end

			-- code lens
			if client.server_capabilities.codeLensProvider then
				vim.lsp.codelens.refresh({ buffer = bufnr, client = client })
				_G.augroup("codeLensRefresh", {
					{ "BufEnter", "CursorHold", "InsertLeave" },
					{
						buffer = bufnr,
						callback = function()
							vim.lsp.codelens.refresh({
								buffer = bufnr,
								client = client,
							})
						end,
					},
				})
			end

			-- Workarounds for golsp
			if client.name == "gopls" then
				if not client.server_capabilities.semanticTokensProvider then
					local semantic =
						client.config.capabilities.textDocument.semanticTokens
					client.server_capabilities.semanticTokensProvider = {
						full = true,
						legend = {
							tokenTypes = semantic.tokenTypes,
							tokenModifiers = semantic.tokenModifiers,
						},
						range = true,
					}
				end
			end
		end,
	},
})
