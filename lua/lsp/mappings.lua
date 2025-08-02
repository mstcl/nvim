local map = vim.keymap.set
local border = require("core.variables").border

local M = {}

-- LSP mappings for native LSP
function M.setup(client, bufnr)
	map("n", "grd", vim.lsp.buf.definition, { desc = "[LSP] Symbol defintion", buffer = bufnr })
	map("n", "gO", vim.lsp.buf.document_symbol, { desc = "[LSP] Document symbol", buffer = bufnr })
	map("n", "gW", vim.diagnostic.setqflist, { desc = "[LSP] Workspace diagnostic", buffer = bufnr })
	map("n", "grr", vim.lsp.buf.references, { desc = "[LSP] Symbol references", buffer = bufnr })
	map("n", "grt", vim.lsp.buf.type_definition, { desc = "[LSP] Symbol type definition", buffer = bufnr })
	map("n", "gri", vim.lsp.buf.implementation, { desc = "[LSP] Symbol implementation", buffer = bufnr })

	map("n", "<C-M>vl", function()
		local config = vim.diagnostic.config()
		if config == nil then
			return
		end

		---@diagnostic disable-next-line: undefined-field, missing-parameter
		if config.virtual_lines() == false then
			vim.diagnostic.config({
				---@diagnostic disable-next-line: return-type-mismatch
				virtual_lines = function()
					return require("lsp.utils").virtual_lines_configs()
				end,
			})
			vim.notify("Enabled virtual lines", vim.log.levels.INFO)
		else
			vim.diagnostic.config({
				virtual_lines = function()
					---@diagnostic disable-next-line: return-type-mismatch
					return false
				end,
			})
			vim.notify("Disabled virtual lines", vim.log.levels.INFO)
		end
	end, { desc = "Toggle virtual lines" })
	map("n", "<C-M>vt", function()
		local config = vim.diagnostic.config()
		if config == nil then
			return
		end

		---@diagnostic disable-next-line: undefined-field, missing-parameter
		if config.virtual_text() == false then
			vim.diagnostic.config({
				---@diagnostic disable-next-line: return-type-mismatch
				virtual_text = function()
					return require("lsp.utils").virtual_text_configs()
				end,
			})
			vim.notify("Enabled virtual text", vim.log.levels.INFO)
		else
			vim.diagnostic.config({
				virtual_text = function()
					---@diagnostic disable-next-line: return-type-mismatch
					return false
				end,
			})
			vim.notify("Disabled virtual text", vim.log.levels.INFO)
		end
	end, { desc = "Toggle virtual text" })

	if client.server_capabilities.inlayHintProvider then
		map("n", "<C-M>ih", function()
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
		map("n", "gra", vim.lsp.buf.code_action, { desc = "[LSP] Code actions", buffer = bufnr })
		map(
			"v",
			"ga",
			":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
			{ desc = "Symbol code actions", buffer = bufnr }
		)
	end

	if client.server_capabilities.codeLensProvider then
		map({ "n" }, "gl", vim.lsp.codelens.run, { desc = "[LSP] Pick code lens", buffer = bufnr })
	end

	if client.server_capabilities.declarationProvider then
		map("n", "grD", vim.lsp.buf.declaration, { desc = "[LSP] Symbol declaration", buffer = bufnr })
	end

	if client.server_capabilities.documentFormattingProvider then
		map({ "n", "v" }, "gF", require("conform").format, { desc = "[LSP] Format code", buffer = bufnr })
	end

	if client.server_capabilities.hoverProvider then
		map("n", "K", function()
			vim.lsp.buf.hover({ border = border, max_width = 35 })
		end, { desc = "[LSP] Symbol documentation", buffer = bufnr })
	end

	if client.server_capabilities.renameProvider then
		map("n", "grn", vim.lsp.buf.rename, { desc = "[LSP] Rename symbol", buffer = bufnr })
	end
end

return M
