local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cond = require("user_configs").lsp_enabled

-- Plugins that add to nvim LSP functionalities
return {
	{
		-- Configure LSP
		"neovim/nvim-lspconfig",
		cond = cond,
		lazy = true,
		event = "BufRead",
		dependencies = {
			{ "cmp-nvim-lsp",          lazy = true, event = "InsertEnter" },
			{ "kevinhwang91/nvim-ufo", lazy = true, event = "VeryLazy" },
		},
		config = function()
			local on_attach = require("utils.lsp").on_attach
			local handlers = require("utils.lsp").handlers
			local capabilities = require("utils.lsp").capabilities
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local lsp_ok, lsp = pcall(require, "lspconfig")
			if not lsp_ok then
				return
			end
			for _, server in ipairs(require("user_configs").lsp_sources) do
				if server == "typst_lsp" then
					lsp[server].setup({
						settings = {
							exportPdf = "onSave",
							experimentalFormatterMode = "On",
						},
					})
				end
				if server == "gopls" then
					lsp[server].setup({
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
				end
				if server == "lua_ls" then
					lsp[server].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
						cmd = { "/usr/bin/lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
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
				end
				if server == "texlab" then
					lsp[server].setup({
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
									args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-shell-escape" },
									executable = "latexmk",
									forwardSearchAfter = true,
									onSave = true,
								},
								chktex = {
									onEdit = true,
									onOpenAndSave = true,
								},
								diagnosticsDelay = 300,
								formatterLineLength = 80,
								forwardSearch = {
									executable = "sioyek",
									args = {
										"--reuse-window",
										"--inverse-search",
										[[nvim-texlabconfig -file %1 -line %2]],
										"--forward-search-file",
										"%f",
										"--forward-search-line",
										"%l",
										"%p",
									},
								},
								latexFormatter = "latexindent",
								latexindent = {
									modifyLineBreaks = false,
								},
							},
						},
					})
				end
				if server == "marksman" then
					lsp[server].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = { "markdown", "quarto" },
						root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
					})
				end
				if server == "ruff_lsp" then
					lsp[server].setup({
						capabilities = capabilities,
						handlers = handlers,
						flags = {
							debounce_text_changes = 150,
						},
					})
				end
				lsp[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = handlers,
					flags = {
						debounce_text_changes = 150,
					},
				})
			end
		end,
	},
	{
		-- Breadcrumb bar
		"utilyre/barbecue.nvim",
		cond = cond,
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
			local bg = require("utils.misc").barbecue_theme["bg"]
			local fg = require("utils.misc").barbecue_theme["fg"]
			local mg = require("utils.misc").barbecue_theme["mg"]
			local bg_fg = { bg = bg, fg = fg }
			local bg_mg = { bg = bg, fg = mg }
			barbecue.setup({
				create_autocmd = false,
				theme = {
					normal = bg_fg,
					context = bg_fg,
					basename = bg_fg,
					ellipsis = bg_mg,
					separator = bg_mg,
					modified = bg_fg,
					dirname = bg_fg,
				},
				show_dirname = true,
				show_basename = true,
				symbols = {
					separator = "⟫",
					ellipsis = "…",
					modified = "●",
				},
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
		-- Easy texlab configuration
		"f3fora/nvim-texlabconfig",
		cond = cond,
		lazy = true,
		opts = {},
		ft = { "tex", "bib" },
		build = "go build",
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
		-- Linter manager
		"nvimtools/none-ls.nvim",
		cond = cond,
		lazy = true,
		event = "VeryLazy",
		dependencies = { "kevinhwang91/nvim-ufo", lazy = true, event = "VeryLazy" },
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
		cond = cond,
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
		cond = require("user_configs").lsp_features.show_usage and cond,
		event = "BufReadPre",
		opts = {
			hl = { link = "StatusLineNC" },
			vt_position = "above",
		},
	},
	{
		--  Stop inactive lsp servers until the buffer recover the focus.
		"hinell/lsp-timeout.nvim",
		cond = cond,
		event = "LspAttach",
		init = function()
			vim.g["lsp-timeout-config"] = {
				stopTimeout = 1000 * 60 * 10,
				startTimeout = 2000,
				silent = true,
			}
		end,
	},
}
