local border = require("core.variables").border
local condition = require("core.variables").lsp_enabled
local on_attach = require("lsp.utils").on_attach
local LSP_SOURCES = require("core.variables").lsp_sources
local FORMATTING_SOURCES = require("core.variables").formatting_sources
local HOVER_SOURCES = require("core.variables").hover_sources
local DIAGNOSTICS_SOURCES = require("core.variables").diagnostics_sources
local CODE_ACTION_SOURCES = require("core.variables").code_action_sources

local FORMATTING_MASON_SOURCES = require("core.variables").get_mason_sources(FORMATTING_SOURCES)
local DIAGNOSTICS_MASON_SOURCES = require("core.variables").get_mason_sources(DIAGNOSTICS_SOURCES)
local CODE_ACTION_MASON_SOURCES = require("core.variables").get_mason_sources(CODE_ACTION_SOURCES)
local LSP_MASON_SOURCES = require("core.variables").get_mason_sources(LSP_SOURCES)

local DIAGNOSTICS_COMPATIBLE_SOURCES = require("core.variables").get_compatible_sources(DIAGNOSTICS_SOURCES)
local CODE_ACTION_COMPATIBLE_SOURCES = require("core.variables").get_compatible_sources(CODE_ACTION_SOURCES)

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
		cmd = { "MasonToolsUpdate", "MasonToolsInstall" },
		cond = condition,
		config = function()
			require("mason-tool-installer").setup({
				run_on_start = true,
				ensure_installed = vim.tbl_deep_extend(
					"force",
					FORMATTING_MASON_SOURCES,
					DIAGNOSTICS_MASON_SOURCES,
					CODE_ACTION_MASON_SOURCES,
					LSP_MASON_SOURCES
				),
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
		keys = {
			{
				"<C-K>",
				"<cmd>lua require('otter').ask_hover<cr>",
				desc = "Otter symbol documentation",
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
						border = border,
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
