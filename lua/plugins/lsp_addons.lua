local lsp_defaults = require("utils.lsp")
local on_attach = lsp_defaults.on_attach
local handlers = lsp_defaults.handlers
local capabilities = lsp_defaults.capabilities

local conf = require("user_configs")
local cond = conf.lsp_enabled
local cond2 = conf.lsp_features
local sources = conf.lsp_sources

-- Plugins that add to nvim LSP functionalities
return {
	{
		"linrongbin16/lsp-progress.nvim",
		event = "LspAttach",
		cond = cond,
		opts = {},
	},
	{
		-- Code tools forge
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = {
			"MasonInstall",
			"MasonUpdate",
			"Mason",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		cond = cond,
		opts = {
			log_level = vim.log.levels.ERROR,
			ui = {
				icons = {
					package_installed = "●",
					package_pending = "○",
					package_uninstalled = "○",
				},
			},
		},
	},
	{
		-- Bridge nvim-lspconfig and mason
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
		},
		cond = cond,
		opts = {
			ensure_installed = sources,
			automatic_installation = true,
		},
	},
	{
		-- Configure LSP
		"neovim/nvim-lspconfig",
		cond = cond,
		event = "BufRead",
		dependencies = {
			{
				"cmp-nvim-lsp",
				event = "InsertEnter",
				cond = conf.edit_features.completion,
			},
			{ "kevinhwang91/nvim-ufo" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			lsp_defaults.configure_builtin_diagnostic()
			local lsp = require("lspconfig")
			for _, server in ipairs(sources) do
				if server == "yamlls" then
					lsp.yamlls.setup = {
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = { "yaml.ansible" },
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
				elseif server == "typst_lsp" then
					lsp.typst_lsp.setup({
						settings = {
							exportPdf = "onSave",
							experimentalFormatterMode = "On",
						},
					})
				elseif server == "gopls" then
					lsp.gopls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
						settings = {
							gopls = {
								gofumpt = true,
								codelenses = {
									gc_details = false,
									generate = true,
									regenerate_cgo = true,
									run_govulncheck = true,
									test = true,
									tidy = true,
									upgrade_dependency = true,
									vendor = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								analyses = {
									fieldalignment = true,
									nilness = true,
									unusedparams = true,
									unusedwrite = true,
									useany = true,
								},
								usePlaceholders = true,
								completeUnimported = true,
								staticcheck = true,
								directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
								semanticTokens = true,
							},
						},
					})
				elseif server == "lua_ls" then
					lsp.lua_ls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
						cmd = {
							vim.fn.expand(
								"$HOME/.local/share/nvim/mason/packages/lua-language-server/libexec/bin/lua-language-server"
							),
							"-E",
							vim.fn.expand(
								"$HOME/.local/share/nvim/mason/packages/lua-language-server/libexec/main.lua"
							),
						},
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									path = "/usr/bin/luajit",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = {
									enable = false,
								},
							},
						},
					})
				elseif server == "texlab" then
					lsp.texlab.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
						cmd = { "texlab" },
						filetypes = { "tex", "bib" },
						settings = {
							texlab = {
								auxDirectory = ".",
								bibtexFormatter = "texlab",
								build = {
									args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
									executable = "miktex-pdflatex",
									forwardSearchAfter = true,
									onSave = true,
								},
								diagnosticsDelay = 300,
								formatterLineLength = 80,
								forwardSearch = {
									executable = "qpdfview",
									args = {
										"--unique",
										"%p#src:%f:%l:0",
									},
								},
							},
						},
					})
				elseif server == "marksman" then
					lsp.marksman.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = { "markdown", "quarto" },
						root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
					})
				elseif server == "ruff_lsp" then
					lsp.ruff_lsp.setup({
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
					})
				elseif server == "gopls" then
					lsp.gopls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							gopls = {
								experimentalPostfixCompletions = true,
								analyses = {
									unusedparams = true,
									shadow = true,
								},
								staticcheck = true,
							},
						},
						init_options = {
							usePlaceholders = true,
						},
					})
				else
					lsp[server].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
					})
				end
			end
		end,
	},
	{
		-- Bridge none-ls and mason
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cond = cond,
		opts = {
			ensure_installed = nil,
			automatic_installation = true,
		},
	},
	{
		-- Linter/formatter/diagnostic manager
		"nvimtools/none-ls.nvim",
		cond = cond,
		event = "BufRead",
		opts = function()
			local null_ls = require("null-ls")
			local null_sources = {}
			local fmt_sources = conf.null_formatting_sources
			local hover_sources = conf.null_hover_sources
			local diagnostics_sources = conf.null_diagnostics_sources
			local code_action_sources = conf.null_code_action_sources
			for _, source in ipairs(fmt_sources) do
				if source == "mdformat" then
					table.insert(
						null_sources,
						null_ls.builtins.formatting[source].with({
							filetypes = { "markdown", "quarto" },
						})
					)
				elseif source == "cbfmt" then
					table.insert(
						null_sources,
						null_ls.builtins.formatting[source].with({
							filetypes = { "markdown", "quarto", "org" },
						})
					)
				else
					table.insert(null_sources, null_ls.builtins.formatting[source])
				end
			end
			for _, source in ipairs(hover_sources) do
				table.insert(null_sources, null_ls.builtins.hover[source])
			end
			for _, source in ipairs(diagnostics_sources) do
				if source == "commitlint" then
					table.insert(
						null_sources,
						null_ls.builtins.diagnostics[source].with({
							filetypes = { "NeogitCommitMessage", "gitcommit" },
							env = {
								NODE_PATH = vim.fn.expand(
									"$HOME/.local/share/nvim/mason/packages/commitlint/node_modules"
								),
							},
							extra_args = { "--extends", "@commitlint/config-conventional" },
						})
					)
				elseif source == "proselint" then
					table.insert(
						null_sources,
						null_ls.builtins.diagnostics[source].with({
							filetypes = { "markdown", "quarto", "org", "tex" },
						})
					)
				else
					table.insert(null_sources, null_ls.builtins.diagnostics[source])
				end
			end
			for _, source in ipairs(code_action_sources) do
				if source == "proselint" then
					table.insert(
						null_sources,
						null_ls.builtins.code_actions[source].with({
							filetypes = { "markdown", "quarto", "org", "tex" },
						})
					)
				else
					table.insert(null_sources, null_ls.builtins.code_actions[source])
				end
			end
			return {
				sources = null_sources,
				on_attach = on_attach,
			}
		end,
		config = function(_, opts)
			if opts then
				require("null-ls").setup(opts)
			end
		end,
	},
	{
		-- Inlay hints
		"lvimuser/lsp-inlayhints.nvim",
		cond = cond2.inlay_hints and cond,
		event = "LspAttach",
		opts = {
			inlay_hints = {
				parameter_hints = {
					show = false,
				},
				type_hints = {
					show = true,
					prefix = "\t",
					separator = " ",
					remove_colon_start = false,
					remove_color_end = false,
				},
				highlight = "NonText",
			},
		},
	},
	{
		-- Virtual text to show usage
		"Wansmer/symbol-usage.nvim",
		cond = cond2.usage and cond,
		event = "BufReadPre",
		opts = {
			hl = { link = "StatusLineNC" },
			vt_position = "above",
		},
	},
	{
		-- LSP completion in code blocks
		"jmbuhr/otter.nvim",
		cond = cond,
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "quarto", "markdown" },
		opts = {
			lsp = {
				hover = {
					border = "single",
				},
			},
			buffers = {
				set_filetype = true,
			},
		},
	},
}
