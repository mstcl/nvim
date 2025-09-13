local map = vim.keymap.set
local border = require("core.variables").border

local M = {}

-- LSP mappings for native LSP
function M.setup(client, bufnr)
	-- Symbol actions
	map("n", "gd", vim.lsp.buf.definition, { desc = "definition", buffer = bufnr, noremap = true })
	map("n", "grt", vim.lsp.buf.type_definition, { desc = "type definition", buffer = bufnr, noremap = true })
	map("n", "grr", vim.lsp.buf.references, { desc = "references", buffer = bufnr, noremap = true })
	map("n", "gri", vim.lsp.buf.implementation, { desc = "implementation", buffer = bufnr, noremap = true })

	map(
		"n",
		"<leader>xdS",
		vim.lsp.buf.document_symbol,
		{ desc = "document symbols (qf)", buffer = bufnr, noremap = true }
	)
	map(
		"n",
		"<leader>xdd",
		vim.diagnostic.setloclist,
		{ desc = "document diagnostics (loc)", buffer = bufnr, noremap = true }
	)
	map(
		"n",
		"<leader>wd",
		vim.diagnostic.setqflist,
		{ desc = "workspace diagnostics (qf)", buffer = bufnr, noremap = true }
	)
	map(
		"n",
		"<leader>wS",
		vim.lsp.buf.workspace_symbol,
		{ desc = "workspace symbols (query)", buffer = bufnr, noremap = true }
	)

	map("n", "<leader>vl", function()
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
		else
			vim.diagnostic.config({
				virtual_lines = function()
					---@diagnostic disable-next-line: return-type-mismatch
					return false
				end,
			})
		end
	end, { desc = "virtual lines toggle" })
	map("n", "<leader>vt", function()
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
		map("n", "<leader>i", function()
			---@diagnostic disable-next-line: missing-parameter
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "inlay hints toggle", noremap = true })
	end

	if client.server_capabilities.codeActionProvider then
		map("n", "gra", vim.lsp.buf.code_action, { desc = "code actions", buffer = bufnr, noremap = true })
		map(
			"v",
			"gra",
			":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
			{ desc = "code actions", buffer = bufnr, noremap = true }
		)
	end

	if client.server_capabilities.codeLensProvider then
		map({ "n" }, "grl", vim.lsp.codelens.run, { desc = "code lens", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.declarationProvider then
		map("n", "gD", vim.lsp.buf.declaration, { desc = "declaration", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.documentFormattingProvider then
		map(
			{ "n", "v" },
			"<leader>F",
			require("conform").format,
			{ desc = "format code", buffer = bufnr, noremap = true }
		)
	end

	if client.server_capabilities.hoverProvider then
		map("n", "K", function()
			vim.lsp.buf.hover({ border = border, max_width = 35 })
		end, { desc = "symbol documentation", buffer = bufnr, noremap = true })
	end

	if client.server_capabilities.renameProvider then
		map("n", "grn", vim.lsp.buf.rename, { desc = "rename", buffer = bufnr, noremap = true })
	end
end

return M
