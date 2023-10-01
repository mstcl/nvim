local present, ts = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end

ts.setup({
	ensure_installed = {
		"python",
		"html",
		"c",
		"cpp",
		"bibtex",
		"css",
		"json",
		"vim",
		"java",
		"javascript",
		"cmake",
		"latex",
		"lua",
		"markdown_inline",
		"bash",
		"diff",
		"dockerfile",
		"gitignore",
		"ini",
		"passwd",
		"php",
		"rasi",
		"scss",
		"sxhkdrc",
		"yaml",
		"toml",
		"comment",
		"org",
		"rust",
		"xml",
		"go",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = { "org" },
		disable = { "latex" },
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
	},
	tree_setter = {
		enable = true,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})

require('utils.autocmds.treesitter')
