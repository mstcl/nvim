-- Plugins that add to nvim LSP functionalities
return {
    {
        -- Configure LSP
        "neovim/nvim-lspconfig",
        lazy = true,
        event = "BufRead",
        dependencies = { "cmp-nvim-lsp" },
        config = function()
            require("configs.lspconfig")
        end,
    },
    {
        -- Breadcrumb bar
        "utilyre/barbecue.nvim",
        lazy = true,
        version = "*",
        even = "BufEnter",
        branch = "main",
        dependencies = { "nvim-web-devicons", "smiteshp/nvim-navic" },
        config = function()
            require("configs.barbecue")
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
            require("configs.outline")
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
        dependencies = "kyazdani42/nvim-web-devicons",
        opts = {
            mode = "workspace_diagnostics",
            padding = false,
        }
    },
    {
        -- Linter manager
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        event = "BufRead",
        config = function()
        	require("configs.null")
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
        }
    },
}
