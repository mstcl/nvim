local ufo_ok, ufo = pcall(require, "ufo")
if not ufo_ok then
	return
end
local null_ok, null_ls = pcall(require, "null-ls")
if not null_ok then
	return
end
local vl = vim.lsp
local M = {}
local null_sources = {}
local fmt_sources = require("user_configs").null_formatting_sources
local hover_sources = require("user_configs").null_hover_sources
local diagnostics_sources = require("user_configs").null_diagnostics_sources
local code_action_sources = require("user_configs").null_code_action_sources

function M.on_attach(client, bufnr)
	require("utils.mappings.lsp").setup(client, bufnr)
	require("lsp-inlayhints").on_attach(client, bufnr)
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

for _, source in ipairs(fmt_sources) do
	if source == "mdformat" then
		table.insert(
			null_sources,
			null_ls.builtins.formatting[source].with({
				filetypes = { "markdown", "quarto" },
			})
		)
	end
	if source == "cbfmt" then
		table.insert(
			null_sources,
			null_ls.builtins.formatting[source].with({
				filetypes = { "markdown", "quarto", "org" },
			})
		)
	end
	table.insert(null_sources, null_ls.builtins.formatting[source])
end
for _, source in ipairs(hover_sources) do
	table.insert(null_sources, null_ls.builtins.hover[source])
end
for _, source in ipairs(diagnostics_sources) do
	if source == "proselint" then
		table.insert(
			null_sources,
			null_ls.builtins.diagnostics[source].with({
				filetypes = { "markdown", "quarto", "org", "tex" },
			})
		)
	end
	table.insert(null_sources, null_ls.builtins.diagnostics[source])
end
for _, source in ipairs(code_action_sources) do
	if source == "proselint" then
		table.insert(
			null_sources,
			null_ls.builtins.code_actions[source].with({
				filetypes = { "markdown", "quarto", "org", "tex" },
			})
		)
	end
	table.insert(null_sources, null_ls.builtins.code_actions[source])
end

M.null_sources = null_sources

return M
