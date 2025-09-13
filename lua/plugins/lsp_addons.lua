local on_attach = require("lsp.utils").on_attach
local conf = require("core.variables")
local condition = conf.lsp_enabled
local HOVER_SOURCES = conf.hover_sources
local DIAGNOSTICS_COMPATIBLE_SOURCES = conf.get_compatible_sources(conf.diagnostics_sources)
local CODE_ACTION_COMPATIBLE_SOURCES = conf.get_compatible_sources(conf.code_action_sources)

-- Plugins that add to nvim LSP functionalities
return {
	{ -- (mason.nvim) Code tools forge
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
		cond = condition,
		opts = {
			log_level = vim.log.levels.ERROR,
			ui = {
				backdrop = 100,
				height = 0.8,
				icons = {
					package_installed = "●",
					package_pending = "○",
					package_uninstalled = "○",
				},
			},
		},
	},
	{ -- (mason-tool-installer.nvim) Mason tool install
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- cmd = { "MasonToolsUpdate", "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdateSync" },
		lazy = false,
		-- cond = condition,
		config = function()
			require("mason-tool-installer").setup({
				run_on_start = true,
				ensure_installed = conf.all_mason_sources,
			})
		end,
	},
	{ -- (none-ls.nvim) Linter/diagnostic
		"nvimtools/none-ls.nvim",
		cond = condition,
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			local null_ls = require("null-ls")
			local null_sources = {}

			for _, source in ipairs(HOVER_SOURCES) do
				table.insert(null_sources, null_ls.builtins.hover[source])
			end

			for _, source in ipairs(DIAGNOSTICS_COMPATIBLE_SOURCES) do
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
				elseif source == "golangci_lint" then
					table.insert(
						null_sources,
						null_ls.builtins.diagnostics[source].with({
							args = { "run", "--fix=false", "--out-format=json", "--concurency=4" },
							extra_args = { "--enable", "goconst,gocritic,gosec,wsl,sloglint,unconvert,unparam" },
						})
					)
				else
					table.insert(null_sources, null_ls.builtins.diagnostics[source])
				end
			end

			for _, source in ipairs(CODE_ACTION_COMPATIBLE_SOURCES) do
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
	{ -- (otter.nvim) LSP completion in code blocks
		"jmbuhr/otter.nvim",
		cond = condition,
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "quarto", "markdown" },
		opts = function()
			return {
				lsp = {
					hover = {
						border = conf.border,
					},
				},
				buffers = {
					set_filetype = true,
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("otter").setup(opts)
			end
		end,
	},
}
