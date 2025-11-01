local nvim_eleven = vim.fn.has("nvim-0.11") == 1

_G.lsp = {}

---@return table
local function virtual_lines_configs()
	return { current_line = false }
end

---@return table
local function virtual_text_configs()
	return {
		current_line = false,
		spacing = 4,
		source = "if_many",
		prefix = "●",
		suffix = " ",
	}
end

-- Configure builtin diagnostics
local function configure_builtin_diagnostic()
	vim.diagnostic.config({
		codelens = {
			enabled = false,
		},

		---@return boolean|fun()
		virtual_lines = function()
			---@diagnostic disable-next-line: unnecessary-if
			if _G.config.features.lsp.virtual_lines then
				---@diagnostic disable-next-line: return-type-mismatch
				return virtual_lines_configs()
			end
			return false
		end,

		---@return boolean|fun()
		virtual_text = function()
			---@diagnostic disable-next-line: unnecessary-if
			if _G.config.features.lsp.virtual_text then
				---@diagnostic disable-next-line: return-type-mismatch
				return virtual_text_configs()
			end
			return false
		end,
		signs = true, -- only for the colored number column
		underline = false,
		update_in_insert = false,
		float = {
			close_events = {
				"BufLeave",
				"CursorMoved",
				"InsertEnter",
				"FocusLost",
			},
			border = _G.config.border,
			source = "always",
			focus = false,
		},
		severity_sort = true,
	})
	vim.cmd([[
				sign define DiagnosticSignError text= numhl=DiagnosticSignError
				sign define DiagnosticSignWarn text=  numhl=DiagnosticSignWarn
				sign define DiagnosticSignInfo text=  numhl=DiagnosticSignInfo
				sign define DiagnosticSignHint text=  numhl=DiagnosticSignHint
			]])
end

local function setup_mappings(client, bufnr)
	-- Symbol actions
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition", buffer = bufnr, noremap = true })
	vim.keymap.set(
		"n",
		"grt",
		vim.lsp.buf.type_definition,
		{ desc = "Type definition", buffer = bufnr, noremap = true }
	)
	vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "References", buffer = bufnr, noremap = true })
	vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr, noremap = true })

	vim.keymap.set("n", "grR", function()
		vim.cmd("FzfLua lsp_references")
	end, { desc = "References (picker)", noremap = false, silent = true })

	vim.keymap.set("n", "<leader>xdD", function()
		vim.cmd("FzfLua lsp_document_diagnostics")
	end, { desc = "Document diagnostics (picker)", noremap = false, silent = true })

	vim.keymap.set("n", "<leader>xds", function()
		vim.cmd("FzfLua lsp_document_symbols")
	end, { desc = "Document symbols (picker)", noremap = false, silent = true })

	vim.keymap.set("n", "<leader>wD", function()
		vim.cmd("FzfLua lsp_workspace_diagnostics")
	end, { desc = "Workspace diagnostics (picker)", noremap = false, silent = true })

	vim.keymap.set("n", "<leader>ws", function()
		vim.cmd("FzfLua lsp_workspace_symbols")
	end, { desc = "Workspace symbols (picker)", noremap = false, silent = true })

	vim.keymap.set(
		"n",
		"<leader>xdS",
		vim.lsp.buf.document_symbol,
		{ desc = "Document symbols (qf)", buffer = bufnr, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<leader>xdd",
		vim.diagnostic.setloclist,
		{ desc = "Document diagnostics (loc)", buffer = bufnr, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<leader>wd",
		vim.diagnostic.setqflist,
		{ desc = "Workspace diagnostics (qf)", buffer = bufnr, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<leader>wS",
		vim.lsp.buf.workspace_symbol,
		{ desc = "Workspace symbols (query)", buffer = bufnr, noremap = true }
	)

	vim.keymap.set("n", "<leader>v", function()
		local config = vim.diagnostic.config()
		if config == nil then
			return
		end

		---@diagnostic disable-next-line: undefined-field, missing-parameter, need-check-nil
		if config.virtual_lines() == false then
			vim.diagnostic.config({
				---@diagnostic disable-next-line: return-type-mismatch
				virtual_lines = function()
					return virtual_lines_configs()
				end,
			})
		else
			vim.diagnostic.config({
				virtual_lines = function()
					---@diagnostic disable-next-line: return-type-mismatch
					return false
				end,
			})
		end
	end, { desc = "Virtual lines toggle" })
	vim.keymap.set("n", "<leader>V", function()
		local config = vim.diagnostic.config()
		if config == nil then
			return
		end

		---@diagnostic disable-next-line: undefined-field, missing-parameter, need-check-nil
		if config.virtual_text() == false then
			vim.diagnostic.config({
				---@diagnostic disable-next-line: return-type-mismatch
				virtual_text = function()
					return virtual_text_configs()
				end,
			})
		else
			vim.diagnostic.config({
				virtual_text = function()
					---@diagnostic disable-next-line: return-type-mismatch
					return false
				end,
			})
		end
	end, { desc = "Virtual text toggle", noremap = true })

	if client.server_capabilities.inlayHintProvider then
		vim.keymap.set("n", "<leader>i", function()
			---@diagnostic disable-next-line: missing-parameter
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Inlay hints toggle", noremap = true })
	end

	if client.server_capabilities.codeActionProvider then
		vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Code actions", buffer = bufnr, noremap = true })
		vim.keymap.set(
			"v",
			"gra",
			":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
			{ desc = "Code actions", buffer = bufnr, noremap = true }
		)
	end

	if client.server_capabilities.codeLensProvider then
		vim.keymap.set({ "n" }, "grl", vim.lsp.codelens.run, { desc = "Code lens", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.declarationProvider then
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.documentFormattingProvider then
		vim.keymap.set(
			{ "n", "v" },
			"<leader>F",
			require("conform").format,
			{ desc = "Format code", buffer = bufnr, noremap = true }
		)
	end

	if client.server_capabilities.hoverProvider then
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = _G.config.border, max_width = 35 })
		end, { desc = "Symbol documentation", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.renameProvider then
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr, noremap = true })
	end
end

-- Configure on attach
_G.lsp.on_attach = function(client, bufnr)
	-- Prevent LSP from overwriting treesitter color settings
	vim.highlight.priorities.semantic_tokens = 120

	-- autocmd to update diagnostic for statusline
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

	-- setup mappings
	setup_mappings(client, bufnr)

	-- inlay hints
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(_G.config.features.lsp.inlay_hints)
	end

	-- code lens
	if client.server_capabilities.codeLensProvider then
		vim.lsp.codelens.refresh({ buffer = bufnr, client = client })
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			buffer = bufnr,
			callback = function()
				vim.lsp.codelens.refresh({ buffer = bufnr, client = client })
			end,
		})
	end

	-- Workarounds for golsp
	if client.name == "gopls" then
		if not client.server_capabilities.semanticTokensProvider then
			local semantic = client.config.capabilities.textDocument.semanticTokens
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

	if client.name == "zk" then
		vim.keymap.set("n", "<leader>ni", ":ZkIndex<CR>", {
			desc = "Index notes",
			noremap = true,
			silent = true,
			buffer = bufnr,
		})
	end
end

-- Override default capabilities
_G.lsp.capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
			completionItem = {
				snippetSupport = true,
			},
		},
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	})

	return capabilities
end

configure_builtin_diagnostic()

local function tbl_flatten(t)
	--- @diagnostic disable-next-line:deprecated
	return nvim_eleven and vim.iter(t):flatten(math.huge):totable() or vim.tbl_flatten(t)
end

local function escape_wildcards(path)
	return path:gsub("([%[%]%?%*])", "\\%1")
end

local function search_ancestors(startpath, func)
	if nvim_eleven then
		vim.validate("func", func, "function")
	end
	if func(startpath) then
		return startpath
	end
	local guard = 100
	for path in vim.fs.parents(startpath) do
		-- Prevent infinite recursion if our algorithm breaks
		guard = guard - 1
		if guard == 0 then
			return
		end

		if func(path) then
			return path
		end
	end
end

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
local function strip_archive_subpath(path)
	-- Matches regex from zip.vim / tar.vim
	path = vim.fn.substitute(path, "zipfile://\\(.\\{-}\\)::[^\\\\].*$", "\\1", "")
	path = vim.fn.substitute(path, "tarfile:\\(.\\{-}\\)::.*$", "\\1", "")
	return path
end

_G.lsp.root_pattern = function(...)
	local patterns = tbl_flatten({ ... })
	return function(startpath)
		startpath = strip_archive_subpath(startpath)
		for _, pattern in ipairs(patterns) do
			local match = search_ancestors(startpath, function(path)
				for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, "/"), true, true)) do
					---@diagnostic disable-next-line: undefined-field
					if vim.uv.fs_stat(p) then
						return path
					end
				end
			end)

			if match ~= nil then
				return match
			end
		end
	end
end

vim.lsp.config("*", {
	capabilities = _G.lsp.capabilities(),
	on_attach = _G.lsp.on_attach,
	---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
	flags = { debounce_text_changes = 150 },
})

local get_lsp_sources = function(source_map)
	local sources = {}
	for k, _ in pairs(source_map) do
		table.insert(sources, k)
	end

	return sources
end

vim.lsp.enable(get_lsp_sources(_G.config.sources.lsp))
