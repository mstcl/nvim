---@type vim.lsp.Config
return {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
	root_markers = { "main.tf", ".terraform", ".git" },
	settings = {},
}
