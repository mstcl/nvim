---@type vim.lsp.Config
return {
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
