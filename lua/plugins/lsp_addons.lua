local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cond = require("user_configs").lsp_enabled
local cond2 = require("user_configs").lsp_features
local sources = require("user_configs").lsp_sources

-- Plugins that add to nvim LSP functionalities
return {
	{
		-- Code tools forge
		"williamboman/mason.nvim",
		lazy = true,
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
		opts = {},
	},
	{
		-- Bridge nvim-lspconfig and mason
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
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
		lazy = true,
		event = "BufRead",
		-- keys = {
		-- 	{ "zR", require("ufo").openAllFolds,  "Open all folds" },
		-- 	{ "zM", require("ufo").closeAllFolds, "Close all folds" },
		-- },
		dependencies = {
			{
				"cmp-nvim-lsp",
				lazy = true,
				event = "InsertEnter",
				cond = require("user_configs").edit_features.completion,
			},
			{ "kevinhwang91/nvim-ufo" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- Builtin diagnostics
			vim.diagnostic.config({
				inlay_hints = {
					enabled = true,
				},
				virtual_text = {
					enabled = true,
					spacing = 4,
					prefix = "",
					format = function(diagnostic)
						return string.format(require("user_configs").lsp_vt_signs[diagnostic.severity])
					end,
					suffix = " ",
				},
				signs = true, -- only for the colored number column
				underline = false,
				update_in_insert = false,
				float = {
					header = false,
					focusable = false,
					prefix = " ",
					suffix = " ",
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "single",
					source = "if_many",
					scope = "cursor",
					focus = false,
				},
				severity_sort = true,
			})
			vim.cmd([[
				sign define DiagnosticSignError text=
				sign define DiagnosticSignWarn text=
				sign define DiagnosticSignInfo text=
				sign define DiagnosticSignHint text=
				sign define DiagnosticSignWarn text=
				sign define DiagnosticSignInfo text=
				sign define DiagnosticSignHint text=
			]])
			local on_attach = require("utils.lsp").on_attach
			local handlers = require("utils.lsp").handlers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if require("user_configs").edit_features.completion then
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			end
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local lsp_ok, lsp = pcall(require, "lspconfig")
			if not lsp_ok then
				return
			end
			for _, server in ipairs(sources) do
				lsp[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = handlers,
					flags = {
						debounce_text_changes = 150,
					},
				})
			end
			lsp.yamlls.setup = {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "yaml", "yml", "yaml.ansible" },
				settings = {
					yaml = {
						format = {
							enable = true,
							singleQuote = true,
							printWidth = 120,
						},
						hover = true,
						completion = true,
						validate = true,
						schemas = {
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
								"docker-compose*",
							},
							["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-requirements-schema.json"] = {
								"requirements.yml",
							},
							["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-meta-schema.json"] = {
								"meta/main.yml",
							},
							["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-vars-schema.json"] = {
								"vars/*.yml",
								"defaults/*.yml",
								"host_vars/*.yml",
								"group_vars/*.yml",
							},
							["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-tasks-schema.json"] = {
								"tasks/*.yml",
								"handlers/*.yml",
							},
							["https://raw.githubusercontent.com/ansible-community/ansible-lint/schemas/src/ansiblelint/f/ansible-playbook-schema.json"] = {
								"playbooks/*.yml",
							},
						},
						schemaStore = {
							enable = true,
							url = "https://www.schemastore.org/json",
						},
					},
				},
			}
			lsp.typst_lsp.setup({
				settings = {
					exportPdf = "onSave",
					experimentalFormatterMode = "On",
				},
			})
			lsp.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				handlers = handlers,
				flags = {
					debounce_text_changes = 150,
				},
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})
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
					vim.fn.expand("$HOME/.local/share/nvim/mason/packages/lua-language-server/libexec/main.lua"),
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
							executable = "pdflatex",
							forwardSearchAfter = true,
							onSave = true,
						},
						diagnosticsDelay = 300,
						formatterLineLength = 80,
						forwardSearch = {
							executable = "zathura",
							args = {
								"--synctex-forward",
								"%l:1:%f",
								"%p",
							},
						},
					},
				},
			})
			lsp.marksman.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "markdown", "quarto" },
				root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
			})
			lsp.ruff_lsp.setup({
				capabilities = capabilities,
				handlers = handlers,
				flags = {
					debounce_text_changes = 150,
				},
			})
		end,
	},
	{
		-- Breadcrumb bar
		"utilyre/barbecue.nvim",
		cond = cond2.breadcrumbs and cond,
		lazy = true,
		version = "*",
		event = "LspAttach",
		branch = "main",
		dependencies = { { "smiteshp/nvim-navic", lazy = true, event = "VeryLazy" } },
		opts = function()
			local colors = require("utils.misc").barbecue_theme
			local bg_fg = { bg = colors["bg"], fg = colors["fg"] }
			local bg_mg = { bg = colors["bg"], fg = colors["mg"] }
			local bg_hl = { bg = colors["bg"], fg = colors["hl"] }
			local bg_bl = { bg = colors["bg"], fg = colors["bl"] }
			return {
				create_autocmd = false,
				theme = {
					normal = bg_fg,
					context = bg_fg,
					basename = bg_hl,
					ellipsis = bg_mg,
					separator = bg_mg,
					modified = bg_hl,
					dirname = bg_bl,
				},
				show_dirname = false,
				show_basename = false,
				symbols = {
					separator = "⟫",
					ellipsis = "…",
					modified = "●",
				},
				exclude_filetypes = { "netrw", "toggleterm" },
				exclude_buftypes = { "terminal" },
				show_modified = true,
				kinds = require("user_configs").lsp_kind_icons,
			}
		end,
		config = function(_, opts)
			require("barbecue").setup(opts)
			autocmd({ "WinResized", "BufWinEnter", "CursorHold", "InsertLeave" }, {
				group = augroup("barbecue", { clear = true }),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
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
		-- Linter manager
		"nvimtools/none-ls.nvim",
		cond = cond,
		lazy = true,
		event = "BufRead",
		opts = function()
			return {
				sources = require("utils.lsp").null_sources,
				on_attach = require("utils.lsp").on_attach,
			}
		end,
		config = function(_, opts)
			require("null-ls").setup(opts)
		end,
	},
	{
		-- Inlay hints
		"lvimuser/lsp-inlayhints.nvim",
		cond = cond2.inlay_hints and cond,
		lazy = true,
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
		lazy = true,
		event = "BufReadPre",
		opts = {
			hl = { link = "StatusLineNC" },
			vt_position = "above",
		},
	},
}
