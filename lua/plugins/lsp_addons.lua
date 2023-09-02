-- Plugins that add to nvim LSP functionalities
return {
	{
		-- Configure LSP
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "BufRead",
		dependencies = { "cmp-nvim-lsp" },
		config = function()
			require("configs.lsp.lspconfig")
		end,
	},
	{
		-- Breadcrumb bar
		"utilyre/barbecue.nvim",
		lazy = true,
		version = "*",
		event = "BufEnter",
		branch = "main",
		dependencies = { "smiteshp/nvim-navic" },
		config = function()
			require("configs.lsp.barbecue")
		end,
	},
	{
		-- Panel for viewing code symbols
		"simrat39/symbols-outline.nvim",
		lazy = true,
		cmd = {
			"SymbolsOutline",
			"SymbolsOutlineOpen",
			"SymbolsOutlineClose",
		},
		config = function()
			require("configs.lsp.outline")
		end,
	},
	{
		-- Easy texlab configuration
		"f3fora/nvim-texlabconfig",
		lazy = true,
		opts = {},
		ft = { "tex", "bib" },
		build = "go build",
	},
	{
		-- Diagnostic list
		"folke/trouble.nvim",
		lazy = true,
		event = "LspAttach",
		opts = {
			fold_open = "▸",
			fold_closed = "▼",
			mode = "workspace_diagnostics",
			padding = false,
			use_diagnostic_signs = true,
			icons = false,
		},
	},
	{
		-- Linter manager
		"jose-elias-alvarez/null-ls.nvim",
		lazy = true,
		event = "BufRead",
		config = function()
			require("configs.lsp.null")
		end,
	},
	{
		-- Window for previewing LSP locations
		"dnlhc/glance.nvim",
		lazy = true,
		event = "LspAttach",
		opts = {
			list = {
				width = 0.5,
			},
		},
	},
}
