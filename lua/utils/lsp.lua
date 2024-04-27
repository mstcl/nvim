local vl = vim.lsp
local M = {}

function M.on_attach(client, bufnr)
	require("utils.mappings.lsp").setup(client, bufnr)
	if require("user_configs").lsp_features.inlay_hints then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end
end

function M.ufo_handler(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" ↵ %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "DiffChange" })
	return newVirtText
end

M.handlers = {
	["textDocument/hover"] = vl.with(vl.handlers.hover, { border = "single" }),
	["textDocument/publishDiagnostics"] = vl.with(vl.diagnostic.on_publish_diagnostics, { update_in_insert = false }),
}

return M
