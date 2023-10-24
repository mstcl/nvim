local exec = vim.api.nvim_command
local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	return
end

local M = {}

-- LSP
function M.setup(client, bufnr)
	wk.register({
		["<leader>q"] = { name = "LSP commands" },
	})

	if client.server_capabilities.definitionProvider then
		wk.register({
			["<leader>qd"] = {
				function()
					exec("Glance definitions")
				end,
				"LSP definitions",
			},
			buffer = bufnr,
		})
	end

	if client.server_capabilities.referencesProvider then
		wk.register({
			["<leader>qr"] = {
				function()
					exec("Glance references")
				end,
				"LSP references",
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.implementationProvider then
		wk.register({
			["<leader>qi"] = {
				function()
					exec("Glance implementations")
				end,
				"Implementations",
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.typeDefinitionProvider then
		wk.register({
			["<leader>qt"] = {
				function()
					exec("Glance type_definitions")
				end,
				"Type definitions",
				buffer = bufnr,
			},
		})
	end

	wk.register({
		["<C-Q>"] = {
			vim.diagnostic.open_float,
			"Open diagnostic (floating)",
			buffer = bufnr,
		},
	})

	if client.server_capabilities.codeActionProvider then
		wk.register({
			["<leader>qc"] = {
				vim.lsp.buf.code_action,
				"Pick code actions",
				mode = { "n", "v" },
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.declarationProvider then
		wk.register({
			["<leader>qD"] = {
				vim.lsp.buf.declaration,
				"Declaration",
				buffer = bufnr,
			},
		})
	end

	if client.server_capabilities.documentFormattingProvider then
		wk.register({
			["<leader><space>"] = {
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
			["<leader>r"] = {
				vim.lsp.buf.rename,
				"Rename object",
				buffer = bufnr,
			},
		})
	end

	wk.register({
		["[d"] = {
			function()
				vim.diagnostic.goto_prev({ wrap = false, float = true })
			end,
			"Previous diagnostic",
			buffer = bufnr,
		},
		["]d"] = {
			function()
				vim.diagnostic.goto_next({ wrap = false, float = true })
			end,
			"Next diagnostic",
			buffer = bufnr,
		},
	})
end

return M
