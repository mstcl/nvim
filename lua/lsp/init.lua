local utils = require("lsp.utils")
local SOURCES = require("core.variables").lsp_sources

utils.configure_builtin_diagnostic()
vim.lsp.config("*", {
	capabilities = utils.create_capabilities(),
	on_attach = utils.on_attach,
	handler = utils.handlers,
	flags = { debounce_text_changes = 150 },
})

vim.lsp.enable(SOURCES)
