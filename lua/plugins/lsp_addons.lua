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
		cond = _G.config.features.lsp.enabled,
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
		-- cond = _G.config.features.lsp.enabled,
		config = function()
			require("mason-tool-installer").setup({
				run_on_start = true,
				ensure_installed = _G.config.sources.mason,
			})
		end,
	},
	{ -- (nvim-lint)
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = {
				lua = { "selene" },
				dockerfile = { "hadolint", "trivy" },
				terraform = { "trivy", "terraform_validate" },
				ansible = { "ansible_lint" },
				go = { "golangcilint" },
			}

			augroup("lint", {
				{ "BufEnter", "BufWritePost", "InsertLeave" },
				{
					desc = "run linter",
					callback = function()
						require("lint").try_lint()
						require("lint").try_lint("codespell")
					end,
				},
			})
		end,
	},
	{ -- (otter.nvim) LSP completion in code blocks
		"jmbuhr/otter.nvim",
		cond = _G.config.features.lsp.enabled,
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "quarto", "markdown" },
		opts = function()
			return {
				lsp = {
					hover = {
						border = _G.config.border,
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
