local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

local M = {}

-- LSP mappings for native LSP
function M.setup(client, bufnr)
	if client.server_capabilities.codeActionProvider then
		wk.register({
			["crr"] = {
				vim.lsp.buf.code_action,
				"Pick code actions",
				mode = { "n", "v" },
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.declarationProvider then
		wk.register({
			["gD"] = {
				vim.lsp.buf.declaration,
				"Declaration",
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.documentFormattingProvider then
		wk.register({
			["cfm"] = {
				vim.lsp.buf.format,
				"Format code",
				mode = { "n", "v" },
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.hoverProvider then
		wk.register({
			["<C-K>"] = {
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				"Code documentation",
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.renameProvider then
		wk.register({
			["crn"] = {
				vim.lsp.buf.rename,
				"Rename object",
				buffer = bufnr,
			},
		})
	end
end

return M
