local utils = require("lsp.utils")
local LSP_SOURCES = require("core.variables").lsp_sources
local LSP_COMPATIBLE_SOURCES = require("core.variables").get_compatible_sources(LSP_SOURCES)

utils.configure_builtin_diagnostic()
vim.lsp.config("*", {
	capabilities = utils.create_capabilities(),
	on_attach = utils.on_attach,
	---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
	flags = { debounce_text_changes = 150 },
})

vim.lsp.enable(LSP_COMPATIBLE_SOURCES)
