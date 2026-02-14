-- (typst.nvim) Typst syntax
MiniDeps.later(function() MiniDeps.add("kaarmu/typst.vim") end)

-- (codeowners) CODEOWNERS syntax
MiniDeps.later(function() MiniDeps.add("rhysd/vim-syntax-codeowners") end)

-- (zk-nvim) Markdown note taking assistant
MiniDeps.later(function()
	MiniDeps.add("zk-org/zk-nvim")

	require("zk").setup({
		picker = "fzf_lua",
		auto_attach = {
			enabled = true,
			filetypes = { "markdown" },
		},
		lsp = {},
	})
end)

-- (render-markdown.nvim) Nice markdown rendering
MiniDeps.later(function()
	MiniDeps.add({
		source = "MeanderingProgrammer/render-markdown.nvim",
		depends = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	})

	require("render-markdown").setup({
		---@module 'render-markdown'
		---@type render.md.UserConfig
		completions = { lsp = { enabled = true } },
		anti_conceal = { enabled = true },
		latex = { enabled = false },
		heading = {
			width = "block",
			left_pad = 0,
			right_pad = 1,
			left_margin = 0,
			position = "inline",
			icons = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " },
		},
		sign = { enabled = false },
		code = {
			sign = false,
			language_pad = 1,
			left_pad = 1,
			right_pad = 1,
			width = "block",
			inline_pad = 1,
			min_width = 50,
			border = "thin",
		},
		checkbox = {
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰄲 " },
			custom = {
				todo = {
					raw = "[-]",
					rendered = "󰡖 ",
					highlight = "RenderMarkdownTodo",
					scope_highlight = nil,
				},
			},
		},
		link = {
			footnote = {
				superscript = false,
				prefix = "[",
				suffix = "]",
			},
			image = "󰋩 ",
			email = "󰇮 ",
			hyperlink = "󰌷 ",
			highlight = "RenderMarkdownLink",
			wiki = {
				icon = "󱗖 ",
				highlight = "RenderMarkdownWikiLink",
			},
			custom = {
				web = { pattern = "^http", icon = "󰖟 " },
				discord = { pattern = "discord%.com", icon = "󰙯 " },
				github = { pattern = "github%.com", icon = "󰊤 " },
				gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
				gitea = { pattern = "g%.beee%.ps", icon = " " },
				google = { pattern = "google%.com", icon = "󰊭 " },
				neovim = { pattern = "neovim%.io", icon = " " },
				reddit = { pattern = "reddit%.com", icon = "󰑍 " },
				stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
				wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
				youtube = { pattern = "youtube%.com", icon = "󰗃 " },
			},
		},
		win_options = {
			conceallevel = {
				default = vim.o.conceallevel,
				rendered = 3,
			},
			concealcursor = {
				default = vim.o.concealcursor,
				rendered = "",
			},
		},
		bullet = {
			icons = { "•", "◦", "•", "◦" },
		},
		yaml = { enabled = false },
	})
end)
