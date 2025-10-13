---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/ansible-language-server"), "--stdio" },
	filetypes = { "yaml.ansible" },
	root_markers = { "ansible.cfg", ".ansible-lint" },
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
