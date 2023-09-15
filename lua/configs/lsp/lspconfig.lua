local present, lsp = pcall(require, "lspconfig")
local navic = require("nvim-navic")
if not present then
	return
end

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ update_in_insert = false }
	),
}

local function applyFoldsAndThenCloseAllFolds(bufnr, providerName)
	require("async")(function()
		bufnr = bufnr or vim.api.nvim_get_current_buf()
		require("ufo").attach(bufnr)
		local ok, ranges = pcall(await, require("ufo").getFolds(bufnr, providerName))
		if ok and ranges then
			ok = require("ufo").applyFolds(bufnr, ranges)
		end
	end)
end

local on_attach_fold_lsp = function(client, bufnr)
	applyFoldsAndThenCloseAllFolds(bufnr, "lsp")
	require("utils.mappings").lsp_keymaps(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

local on_attach_fold_indent = function(client, bufnr)
	applyFoldsAndThenCloseAllFolds(bufnr, "indent")

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	if client.server_capabilities.hoverProvider then
		opts.desc = "Documentation"
		buf_set_keymap("n", "<C-K>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	end
	if client.server_capabilities.definitionProvider then
		opts.desc = "Buffer declaration"
		buf_set_keymap("n", "<Leader>qq", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	end
	if client.server_capabilities.documentFormattingProvider then
		opts.desc = "Format buffer"
		buf_set_keymap("n", "<Leader><space>", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
	end
	if client.server_capabilities.renameProvider then
		opts.desc = "Rename object"
		buf_set_keymap("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end
	opts.desc = "Next diagnostic"
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ wrap = false, float = false })<CR>", opts)
	opts.desc = "Previous diagnostic"
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ wrap = false, float = false })<CR>", opts)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers_fold_indent = { "clangd", "bashls", "jedi_language_server" }

local servers_fold_lsp = { "vimls", "cssls", "gopls", "marksman" }

for _, server in ipairs(servers_fold_indent) do
	lsp[server].setup({
		on_attach = on_attach_fold_indent,
		capabilities = capabilities,
		handlers = handlers,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

for _, server in ipairs(servers_fold_lsp) do
	lsp[server].setup({
		on_attach = on_attach_fold_lsp,
		capabilities = capabilities,
		handlers = handlers,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

lsp.ruff_lsp.setup({
	capabilities = capabilities,
	handlers = handlers,
	flags = {
		debounce_text_changes = 150,
	},
})

lsp.texlab.setup({
	on_attach = on_attach_fold_lsp,
	capabilities = capabilities,
	handlers = handlers,
	flags = {
		debounce_text_changes = 150,
	},
	cmd = { "texlab" },
	filetypes = { "tex", "bib" },
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-shell-escape" },
				executable = "latexmk",
				forwardSearchAfter = true,
				onSave = true,
			},
			chktex = {
				onEdit = true,
				onOpenAndSave = true,
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				executable = "sioyek",
				args = {
					"--reuse-window",
					"--inverse-search",
					[[nvim-texlabconfig -file %1 -line %2]],
					"--forward-search-file",
					"%f",
					"--forward-search-line",
					"%l",
					"%p",
				},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
})

lsp.lua_ls.setup({
	on_attach = on_attach_fold_lsp,
	capabilities = capabilities,
	handlers = handlers,
	flags = {
		debounce_text_changes = 150,
	},
	cmd = { "/usr/bin/lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = "/usr/bin/luajit",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

local signs = { Error = "━━", Warn = "━━", Hint = "■", Info = "■" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local icons = {
	Class = "⁐ Class",
	Color = "% Color",
	Constant = "π Constant",
	Constructor = "☂ Constructor",
	Enum = "ζ Enum",
	EnumMember = "@ EnumMember",
	Event = "! Event",
	Field = "⊟ Field",
	File = "⊡ File",
	Folder = "+ Folder",
	Function = "ƒ Function",
	Interface = "♺ Interface",
	Keyword = "★ Keyword",
	Reference = "⇒ Reference",
	Method = "ƒ Method",
	Module = "◫ Module",
	Operator = "⁑ Operator",
	Property = "✓ Property",
	Snippet = "& Snippet",
	Struct = "◧ Structure",
	Text = "☰ Text",
	TypeParameter = "⊞ Parameter",
	Unit = "$ Unit",
	Value = "λ Value",
	Variable = "Ψ Variable",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = icons[kind] or kind
end

vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		prefix = "",
		format = function(diagnostic)
			if diagnostic.severity == vim.diagnostic.severity.ERROR then
				return string.format("✗ %s", diagnostic.message)
			elseif diagnostic.severity == vim.diagnostic.severity.WARN then
				return string.format("! %s", diagnostic.message)
			elseif diagnostic.severity == vim.diagnostic.severity.INFO then
				return string.format("i %s", diagnostic.message)
			else return string.format("? %s", diagnostic.message)
			end
		end,
		suffix = " ",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	float = {
		header = false,
		focusable = false,
		prefix = " ",
		suffix = " ",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "single",
		source = "if_many",
		scope = "cursor",
		focus = false,
	},
	severity_sort = true,
})
