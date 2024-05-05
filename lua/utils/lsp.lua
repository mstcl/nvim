local vl = vim.lsp
local M = {}

function M.on_attach(client, bufnr)
	require("utils.mappings.lsp").setup(client, bufnr)
	if require("user_configs").lsp_features.inlay_hints then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end
end

M.handlers = {
	["textDocument/hover"] = vl.with(vl.handlers.hover, { border = "single" }),
	["textDocument/publishDiagnostics"] = vl.with(vl.diagnostic.on_publish_diagnostics, { update_in_insert = false }),
}

return M
