local lsp = vim.lsp
local augroup = require("utils.misc").augroup
local conf = require("user_configs")
local M = {}

function M.on_attach(client, bufnr)
	-- setup mappings
	require("utils.mappings.lsp").setup(client, bufnr)

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(conf.lsp_features.inlay_hints)
	end

	if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

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

	if client.server_capabilities.codeLensProvider then
		vim.lsp.codelens.refresh()
		augroup("codeLensRefresh", {
			{ "BufEnter", "CursorHold", "InsertLeave" },
			{
				callback = vim.lsp.codelens.refresh
			},
			buffer = bufnr,
			desc = "Refresh codelens"
		})
	end
end

M.handlers = {
	["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" }),
	["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = false,
	}),
}

-- Configure builtin diagnostics
function M.configure_builtin_diagnostic()
	vim.diagnostic.config({
		---@return boolean|fun()
		virtual_text = function()
			if require("user_configs").lsp_features.virtual_text then
				return {
					spacing = 4,
					prefix = "",
					format = function(diagnostic)
						return string.format(require("user_configs").lsp_vt_signs[diagnostic.severity])
					end,
					suffix = " ",
				}
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
			border = "single",
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

M.capabilities = lsp.protocol.make_client_capabilities()
if conf.edit_features.completion then
	M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
M.capabilities.workspace = {
	didChangeWatchedFiles = {
		dynamicRegistration = true,
	},
}

return M
