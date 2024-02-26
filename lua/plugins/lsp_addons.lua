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
		cond = cond,
		opts = {
			automatic_installation = true,
		},
	},
	{
		-- Configure LSP
		"neovim/nvim-lspconfig",
		cond = cond,
		lazy = true,
		event = "BufRead",
		dependencies = {
			{
				"cmp-nvim-lsp",
				lazy = true,
				event = "InsertEnter",
				cond = require("user_configs").edit_features.completion,
			},
			{ "kevinhwang91/nvim-ufo" },
		},
		config = function()
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
		config = function()
			local present, barbecue = pcall(require, "barbecue")
			if not present then
				return
			end
			local colors = require("utils.misc").barbecue_theme
			local bg_fg = { bg = colors["bg"], fg = colors["fg"] }
			local bg_mg = { bg = colors["bg"], fg = colors["mg"] }
			local bg_hl = { bg = colors["bg"], fg = colors["hl"] }
			local bg_bl = { bg = colors["bg"], fg = colors["bl"] }
			barbecue.setup({
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
			})
			local barbecue_update = augroup("barbecue", { clear = true })
			autocmd({ "WinResized", "BufWinEnter", "CursorHold", "InsertLeave" }, {
				group = barbecue_update,
				callback = function()
					require("barbecue.ui").update()
				end,
			})
		end,
	},
	{
		-- Code symbol outline
		"stevearc/aerial.nvim",
		cond = cond,
		event = "LspAttach",
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialNavOpen",
			"AerialInfo",
			"AerialClose",
		},
		opts = {
			open_automatic = false,
			placement = "edge",
			attach_mode = "global",
			close_automatic_events = { "unfocus" },
			backends = { "lsp", "treesitter", "markdown", "man" },
			layout = { min_width = 28 },
			show_guides = true,
			lazy_load = true,
			filter_kind = false,
			icons = require("user_configs").lsp_kind_icons,
			guides = {
				mid_item = "├ ",
				last_item = "└ ",
				nested_top = "│ ",
				whitespace = "  ",
			},
			keymaps = {
				["[y"] = "actions.prev",
				["]y"] = "actions.next",
				["[Y"] = "actions.prev_up",
				["]Y"] = "actions.next_up",
				["{"] = false,
				["}"] = false,
				["[["] = false,
				["]]"] = false,
			},
		},
	},
	{
		-- Diagnostic list
		"folke/trouble.nvim",
		cond = cond,
		lazy = true,
		event = "LspAttach",
		opts = {
			fold_open = "▾",
			fold_close = "▸",
			mode = "workspace_diagnostics",
			padding = false,
			use_diagnostic_signs = true,
			icons = false,
		},
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
		event = "VeryLazy",
		config = function()
			local null_ok, null_ls = pcall(require, "null-ls")
			if not null_ok then
				return
			end
			null_ls.setup({
				sources = require("utils.lsp").null_sources,
				on_attach = require("utils.lsp").on_attach,
			})
		end,
	},
	{
		-- Window for previewing LSP locations
		"dnlhc/glance.nvim",
		cond = cond,
		lazy = true,
		event = "LspAttach",
		opts = {
			zindex = 9999,
			detached = true,
			list = {
				width = 0.3,
				position = "left",
			},
		},
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
