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
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "definition", buffer = bufnr, noremap = true })
	vim.keymap.set(
		"n",
		"grt",
		vim.lsp.buf.type_definition,
		{ desc = "type definition", buffer = bufnr, noremap = true }
	)
	vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "references", buffer = bufnr, noremap = true })
	vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "implementation", buffer = bufnr, noremap = true })

	vim.keymap.set(
		"n",
		"<leader>xdS",
		vim.lsp.buf.document_symbol,
		{ desc = "document symbols (qf)", buffer = bufnr, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<leader>xdd",
		vim.diagnostic.setloclist,
		{ desc = "document diagnostics (loc)", buffer = bufnr, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<leader>wd",
		vim.diagnostic.setqflist,
		{ desc = "workspace diagnostics (qf)", buffer = bufnr, noremap = true }
	)
	vim.keymap.set(
		"n",
		"<leader>wS",
		vim.lsp.buf.workspace_symbol,
		{ desc = "workspace symbols (query)", buffer = bufnr, noremap = true }
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
	end, { desc = "virtual lines toggle" })
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
	end, { desc = "virtual text toggle", noremap = true })

	if client.server_capabilities.inlayHintProvider then
		vim.keymap.set("n", "<leader>i", function()
			---@diagnostic disable-next-line: missing-parameter
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "inlay hints toggle", noremap = true })
	end

	if client.server_capabilities.codeActionProvider then
		vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "code actions", buffer = bufnr, noremap = true })
		vim.keymap.set(
			"v",
			"gra",
			":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
			{ desc = "code actions", buffer = bufnr, noremap = true }
		)
	end

	if client.server_capabilities.codeLensProvider then
		vim.keymap.set({ "n" }, "grl", vim.lsp.codelens.run, { desc = "code lens", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.declarationProvider then
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "declaration", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.documentFormattingProvider then
		vim.keymap.set(
			{ "n", "v" },
			"<leader>F",
			require("conform").format,
			{ desc = "format code", buffer = bufnr, noremap = true }
		)
	end

	if client.server_capabilities.hoverProvider then
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = _G.config.border, max_width = 35 })
		end, { desc = "symbol documentation", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.renameProvider then
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "rename", buffer = bufnr, noremap = true })
	end
end

-- Configure on attach
_G.lsp.on_attach = function(client, bufnr)
	-- Prevent LSP from overwriting treesitter color settings
	vim.highlight.priorities.semantic_tokens = 120

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
			desc = "index notes",
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

vim.lsp.enable(_G.config.sources.get_compatible_sources(_G.config.sources.lsp))
