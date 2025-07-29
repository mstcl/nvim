local lsp_defaults = require("lsp.utils")
local on_attach = lsp_defaults.on_attach
local border = require("core.variables").border

local conf = require("core.variables")
local cond = conf.lsp_enabled

-- Plugins that add to nvim LSP functionalities
return {
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
