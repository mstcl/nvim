local map = vim.keymap.set

local M = {}

-- LSP mappings for native LSP
function M.setup(client, bufnr)
	map("n", "gd", vim.lsp.buf.definition, { desc = "Symbol defintion", buffer = bufnr })
	map("n", "gp", vim.lsp.buf.type_definition, { desc = "Symbol type defintion", buffer = bufnr })

	if client.server_capabilities.inlayHintProvider then
		map("n", "<C-M>b", function()
			---@diagnostic disable-next-line: missing-parameter
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			---@diagnostic disable-next-line: missing-parameter
			if not vim.lsp.inlay_hint.is_enabled() then
				vim.notify("Disabled inlay hints", vim.log.levels.INFO)
			else
				vim.notify("Enabled inlay hints", vim.log.levels.INFO)
			end
		end, { desc = "Toggle inlay hints" })
	end

	if client.server_capabilities.codeActionProvider then
		map({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "Symbol code actions", buffer = bufnr })
	end

	if client.server_capabilities.declarationProvider then
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Symbol declaration", buffer = bufnr })
	end

	if client.server_capabilities.documentFormattingProvider then
		map({ "n", "v" }, "gF", vim.lsp.buf.format, { desc = "Format code", buffer = bufnr })
	end

	if client.server_capabilities.hoverProvider then
		map("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Symbol documentation", buffer = bufnr })
	end

	if client.server_capabilities.renameProvider then
		map("n", "gR", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
	end
end

return M
