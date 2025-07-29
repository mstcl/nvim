---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/terraform-ls"), "serve" },
	filetypes = { "terraform", "terraform-vars" },
	root_markers = { "main.tf", ".terraform", ".git" },
	settings = {},
}
