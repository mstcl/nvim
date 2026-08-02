---@type vim.lsp.Config
return {
	settings = {
		ansible = {
			ansible = {
				useFullyQualifiedCollectionNames = true,
				path = "ansible",
			},
			executionEnvironment = {
				enabled = false,
			},
			python = {
				interpreterPath = "python",
			},
			validation = {
				enabled = true,
				lint = {
					enabled = true,
					path = "ansible-lint",
				},
			},
		},
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
}
