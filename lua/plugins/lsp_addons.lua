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
		event = "LspAttach",
		branch = "main",
		dependencies = { { "smiteshp/nvim-navic", lazy = true, event = "VeryLazy" } },
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
		"nvimtools/none-ls.nvim",
		lazy = true,
		event = "VeryLazy",
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
	{
		-- Inlay hints
		"lvimuser/lsp-inlayhints.nvim",
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
		event = "BufReadPre",
		opts = {
			hl = { link = "StatusLineNC" },
			vt_position = "above",
		},
	},
}
