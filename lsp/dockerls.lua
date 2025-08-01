---@type vim.lsp.Config
return {
	cmd = { "$HOME/.local/share/nvim/mason/bin/docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile", "Containerfile" },
	settings = {
		docker = {
			languageserver = {
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
}
