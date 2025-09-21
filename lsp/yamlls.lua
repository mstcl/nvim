---@type vim.lsp.Config
return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	root_markers = { ".git" },
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			keyOrdering = false,
			format = {
				enable = true,
				singleQuote = true,
				printWidth = 120,
			},
			hover = true,
			completion = true,
			validate = true,
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
				["https://json.schemastore.org/chart.json"] = "Chart.yaml",
				["https://json.schemastore.org/taskfile.json"] = "Taskfile*.yml",
				["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/master/docs/content/en/schemas/v2beta26.json"] = "skaffold.yaml",
				["https://raw.githubusercontent.com/rancher/k3d/main/pkg/config/v1alpha3/schema.json"] = "k3d.yaml",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
					"docker-compose.yml",
				},
				["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-requirements-schema.json"] = {
					"requirements.yml",
				},
				["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-meta-schema.json"] = {
					"**/meta/main.yml",
				},
				["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-vars-schema.json"] = {
					"**/vars/*.yml",
					"**/defaults/*.yml",
					"**/host_vars/*.yml",
					"**/group_vars/*.yml",
				},
				["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-tasks-schema.json"] = {
					"**/tasks/*.yml",
					"**/handlers/*.yml",
				},
				["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-playbook-schema.json"] = {
					"**/playbooks/*.yml",
					"main.yml",
					"site.yml",
				},
			},
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/json",
			},
		},
	},
}
