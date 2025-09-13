local map = vim.keymap.set
local border = require("core.variables").border

local M = {}

-- LSP mappings for native LSP
function M.setup(client, bufnr)
	-- Symbol actions
	map("n", "gd", vim.lsp.buf.definition, { desc = "Definition", buffer = bufnr })
	map("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition", buffer = bufnr })
	map("n", "grr", vim.lsp.buf.references, { desc = "References", buffer = bufnr })
	map("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })

	map("n", "<leader>xds", vim.lsp.buf.document_symbol, { desc = "Document symbols", buffer = bufnr })
	map("n", "<leader>xdd", vim.diagnostic.setloclist, { desc = "Document diagnostics", buffer = bufnr })
	map("n", "<leader>xws", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbols", buffer = bufnr })
	map("n", "<leader>xwd", vim.diagnostic.setqflist, { desc = "Workspace diagnostics", buffer = bufnr })

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
	end, { desc = "Toggle virtual lines" })
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
	end, { desc = "Toggle virtual text" })

	if client.server_capabilities.inlayHintProvider then
		map("n", "<leader>i", function()
			---@diagnostic disable-next-line: missing-parameter
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Toggle inlay hints" })
	end

	if client.server_capabilities.codeActionProvider then
		map("n", "gra", vim.lsp.buf.code_action, { desc = "Code actions", buffer = bufnr })
		map(
			"v",
			"gra",
			":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
			{ desc = "Symbol code actions", buffer = bufnr }
		)
	end

	if client.server_capabilities.codeLensProvider then
		map({ "n" }, "grl", vim.lsp.codelens.run, { desc = "Code lens", buffer = bufnr })
	end

	if client.server_capabilities.declarationProvider then
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = bufnr })
	end

	if client.server_capabilities.documentFormattingProvider then
		map({ "n", "v" }, "<leader>=", require("conform").format, { desc = "Format code", buffer = bufnr })
	end

	if client.server_capabilities.hoverProvider then
		map("n", "K", function()
			vim.lsp.buf.hover({ border = border, max_width = 35 })
		end, { desc = "Symbol documentation", buffer = bufnr })
	end

	if client.server_capabilities.renameProvider then
		map("n", "grn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
	end
end

return M
