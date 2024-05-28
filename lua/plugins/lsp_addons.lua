local lsp_defaults = require("lsp.utils")
local on_attach = lsp_defaults.on_attach
local handlers = lsp_defaults.handlers
local capabilities = lsp_defaults.capabilities

local conf = require("core.variables")
local cond = conf.lsp_enabled
local sources = conf.lsp_sources

-- Plugins that add to nvim LSP functionalities
return {
	{
		"linrongbin16/lsp-progress.nvim",
		event = "LspAttach",
		cond = cond,
		opts = {
			series_format = function(title, message, percentage, _)
				local builder = {}
				local has_title = false
				local has_message = false
				if type(message) == "string" and string.len(message) > 0 then
					has_message = true
				end
				if type(title) == "string" and string.len(title) > 0 then
					has_title = true
				end
				if percentage and (has_title or has_message) then
					table.insert(builder, string.format("%.0f%%", percentage))
				end
				return table.concat(builder, " ")
			end,
			client_format = function(client_name, _, series_messages)
				return #series_messages > 0 and client_name .. " " .. table.concat(series_messages, " ") .. " " or nil
			end,
			format = function(client_messages)
				if #client_messages > 0 then
					return table.concat(client_messages, " ")
				end
				if #vim.lsp.get_clients() > 0 then
					return ""
				end
				return ""
			end,
		},
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
									["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/master/docs/content/en/schemas/v2beta26.json"] =
									"skaffold.yaml",
									["https://raw.githubusercontent.com/rancher/k3d/main/pkg/config/v1alpha3/schema.json"] =
									"k3d.yaml",
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
				elseif server == "ltex" then
					local spell_words = {}
					for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
						table.insert(spell_words, word)
					end
					lsp.ltex.setup({
						settings = {
							ltex = {
								language = "en-GB",
								enabled = true,
								dictionary = {
									["en-GB"] = spell_words,
								},
							},
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
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
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
				elseif server == "ansiblels" then
					lsp.ansiblels.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							ansible = {
								ansible = {
									useFullyQualifiedCollectionNames = true,
								},
							},
							redhat = {
								telemetry = {
									enabled = false,
								},
							},
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
		dependencies = { "nvim-lua/plenary.nvim" },
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
		-- LSP completion in code blocks
		"jmbuhr/otter.nvim",
		cond = cond,
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "quarto", "markdown" },
		keys = {
			{
				"<C-K>",
				"<cmd>lua require('otter').ask_hover<cr>",
				desc = "Otter hover",
				buffer = true,
			},
			{
				"god",
				"<cmd>lua require('otter').ask_definition<cr>",
				desc = "Otter definition",
				buffer = true,
			},
			{
				"gop",
				"<cmd>lua require('otter').ask_type_definition<cr>",
				desc = "Otter type definition",
				buffer = true,
			},
			{
				"goR",
				"<cmd>lua require('otter').ask_definition<cr>",
				desc = "Otter rename",
				buffer = true,
			},
			{
				"gor",
				"<cmd>lua require('otter').ask_definition<cr>",
				desc = "Otter references",
				buffer = true,
			},
			{
				"goF",
				"<cmd>lua require('otter').ask_definition<cr>",
				desc = "Otter format code",
				buffer = true,
			},
		},
		opts = function()
			return {
				lsp = {
					hover = {
						border = "single",
					},
				},
				buffers = {
					set_filetype = true,
				},
			}
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.register({
				["go"] = { name = "Otter (code block) symbols" },
			})
			if opts then
				require("otter").setup(opts)
			end
		end,
	},
	{
		-- LSP symbol components
		"SmiteshP/nvim-navic",
		event = "BufReadPre",
		cond = cond,
		opts = function()
			local function get_kinds()
				local kinds = conf.lsp_kind_icons
				local new_kinds = {}
				for k, _ in pairs(kinds) do
					new_kinds[k] = ""
				end
				return new_kinds
			end
			return {
				icons = get_kinds(),
				depth_limit = 4,
				highlight = true,
			}
		end,
		config = function(_, opts)
			if opts then
				require("nvim-navic").setup(opts)
			end
		end,
	},
}
