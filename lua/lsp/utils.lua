local lsp = vim.lsp
local conf = require("core.variables")
local border = require("core.variables").border
local M = {}

function M.on_attach(client, bufnr)
	require("core.progress")

	-- Prevent LSP from overwriting treesitter color settings
	vim.highlight.priorities.semantic_tokens = 95

	-- setup mappings
	require("lsp.mappings").setup(client, bufnr)

	-- inlay hints
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(conf.lsp_features.inlay_hints)
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
		vim.keymap.set("n", "<leader>ki", ":ZkIndex<CR>", {
			desc = "Index notes",
			noremap = true,
			silent = true,
			buffer = bufnr,
		})
	end
end

---@return table
function M.virtual_text_configs()
	return {
		current_line = false,
		spacing = 4,
		source = "if_many",
		prefix = "●",
		suffix = " ",
	}
end

---@return table
function M.virtual_lines_configs()
	return { current_line = false }
end

-- Configure builtin diagnostics
function M.configure_builtin_diagnostic()
	vim.diagnostic.config({
		codelens = {
			enabled = false,
		},

		---@return boolean|fun()
		virtual_lines = function()
			if require("core.variables").lsp_features.virtual_lines then
				return M.virtual_lines_configs()
			end
			return false
		end,

		---@return boolean|fun()
		virtual_text = function()
			if require("core.variables").lsp_features.virtual_text then
				return M.virtual_text_configs()
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
			border = border,
			source = "if_many",
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

-- Override default capabilities
function M.create_capabilities()
	local capabilities = lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
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

return M
