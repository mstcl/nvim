local map = vim.keymap.set

local M = {}

-- LSP mappings for native LSP
function M.setup(client, bufnr)
	map("n", "gd", vim.lsp.buf.definition, { desc = "Symbol defintion", buffer = bufnr })
	map("n", "gp", vim.lsp.buf.type_definition, { desc = "Symbol type defintion", buffer = bufnr })

	map("n", "<C-M>v", function()
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
		map({ "n" }, "ga", vim.lsp.buf.code_action, { desc = "Symbol code actions", buffer = bufnr })
		map(
			"v",
			"ga",
			":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
			{ desc = "Symbol code actions", buffer = bufnr }
		)
	end

	if client.server_capabilities.codeLensProvider then
		map({ "n" }, "gl", vim.lsp.codelens.run, { desc = "Pick code lens", buffer = bufnr })
	end

	if client.server_capabilities.declarationProvider then
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Symbol declaration", buffer = bufnr })
	end

	if client.server_capabilities.documentFormattingProvider then
		map({ "n", "v" }, "gF", vim.lsp.buf.format, { desc = "Format code", buffer = bufnr })
	end

	if client.server_capabilities.hoverProvider then
		map("n", "K", function()
			vim.lsp.buf.hover()
		end, { desc = "Symbol documentation", buffer = bufnr })
	end

	if client.server_capabilities.renameProvider then
		map("n", "gR", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
	end
end

return M
