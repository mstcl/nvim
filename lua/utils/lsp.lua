local lsp = vim.lsp
local conf = require("user_configs")
local M = {}

function M.on_attach(client, bufnr)
	-- setup mappings
	require("utils.mappings.lsp").setup(client, bufnr)

	-- inlay_hints for neovim < 0.10
	if conf.lsp_features.inlay_hints then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end

	-- refresh codelens on textchanged and insertleave
	-- and trigger codelens refresh
	-- augroup("refreshCodeLens", {
	-- 	{ "TextChanged", "InsertLeave", "LspAttach" },
	-- 	{
	-- 		buffer = bufnr,
	-- 		callback = lsp.codelens.refresh,
	-- 	},
	-- })
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
		inlay_hints = {
			enabled = true,
		},
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
