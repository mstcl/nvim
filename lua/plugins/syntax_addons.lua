local augroup = require("core.utils").augroup
local conf = require("core.variables")

-- Plugins to extend syntax, either natively or with treesitter
return {
	{ -- (nvim-treesitter) Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		version = false,
		lazy = vim.fn.argc(-1) == 0,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
		keys = {
			{
				"<leader>xt",
				function()
					vim.cmd("TSBufToggle highlight")
				end,
				desc = "treesitter highlight toggle",
			},
		},
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		opts = function()
			local ensure_installed = conf.treesitter_sources
			local function add(lang)
				if type(ensure_installed) == "table" then
					table.insert(ensure_installed, lang)
				end
			end
			add("git_config")
			add("rasi")
			return {
				ensure_installed = conf.treesitter_sources,
				sync_install = false,
				highlight = {
					enable = true,
					use_languagetree = true,
					additional_vim_regex_highlighting = { "org" },
					disable = { "latex" },
					is_supported = function()
						if require("core.utils").big(vim.fn.expand("%")) then
							return false
						else
							return true
						end
					end,
				},
				autopairs = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = false,
						node_incremental = "an",
						scope_incremental = "aN",
						node_decremental = "in",
					},
				},
				indent = {
					enable = false,
					disable = { "yaml", "yaml.ansible", "template" },
				},
				tree_setter = {
					enable = true,
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25,
					persist_queries = false,
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
				textobjects = {
					select = {
						enabled = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "outer function" },
							["if"] = { query = "@function.inner", desc = "inner function" },
							["ac"] = { query = "@conditional.outer", desc = "outer conditional" },
							["ic"] = { query = "@conditional.inner", desc = "inner conditional" },
							["al"] = { query = "@conditional.outer", desc = "outer loop" },
							["il"] = { query = "@conditional.inner", desc = "inner loop" },
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]k"] = { query = "@block.outer", desc = "next block start" },
							["]f"] = { query = "@function.outer", desc = "next function start" },
							["]a"] = { query = "@parameter.inner", desc = "next parameter start" },
						},
						goto_next_end = {
							["]K"] = { query = "@block.outer", desc = "next block end" },
							["]F"] = { query = "@function.outer", desc = "next function end" },
							["]A"] = { query = "@parameter.inner", desc = "next parameter end" },
						},
						goto_previous_start = {
							["[k"] = { query = "@block.outer", desc = "previous block start" },
							["[f"] = { query = "@function.outer", desc = "previous function start" },
							["[a"] = { query = "@parameter.inner", desc = "previous parameter start" },
						},
						goto_previous_end = {
							["[K"] = { query = "@block.outer", desc = "previous block end" },
							["[F"] = { query = "@function.outer", desc = "previous function end" },
							["[A"] = { query = "@parameter.inner", desc = "previous parameter end" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							[">K"] = { query = "@block.outer", desc = "swap next block" },
							[">F"] = { query = "@function.outer", desc = "swap next function" },
							[">A"] = { query = "@parameter.inner", desc = "swap next parameter" },
						},
						swap_previous = {
							["<K"] = { query = "@block.outer", desc = "swap previous block" },
							["<F"] = { query = "@function.outer", desc = "swap previous function" },
							["<A"] = { query = "@parameter.inner", desc = "swap previous parameter" },
						},
					},
				},
			}
		end,
		config = function(_, opts)
			-- Add configured syntax to ensure installed
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end

			if opts then
				require("nvim-treesitter.configs").setup(opts)
			end
		end,
	},
	{
		-- (nvim-treesitter-textobjects) Textobjects
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			-- Globally map Tree-sitter text object binds
			local function textobj_map(key, query)
				local outer = "@" .. query .. ".outer"
				local inner = "@" .. query .. ".inner"
				function get_opts(type)
					return {
						desc = type .. " " .. query,
						silent = true,
					}
				end
				vim.keymap.set("x", "i" .. key, function()
					vim.cmd.TSTextobjectSelect(inner)
				end, get_opts("Inner"))
				vim.keymap.set("x", "a" .. key, function()
					vim.cmd.TSTextobjectSelect(outer)
				end, get_opts("Outer"))
				vim.keymap.set("o", "i" .. key, function()
					vim.cmd.TSTextobjectSelect(inner)
				end, get_opts("Inner"))
				vim.keymap.set("o", "a" .. key, function()
					vim.cmd.TSTextobjectSelect(outer)
				end, get_opts("Outer"))
			end

			textobj_map("f", "function")
			textobj_map("c", "conditional")
			textobj_map("l", "loop")
		end,
	},
	{ -- (tex-coneal) Concealing in latex files
		"KeitaNakamura/tex-conceal.vim",
		ft = { "tex" },
	},
	{ -- (quarto-nvim) Quarto syntax
		"quarto-dev/quarto-nvim",
		dev = false,
		ft = { "quarto" },
		dependencies = { "jmbuhr/otter.nvim" },
		opts = {
			lspFeatures = {
				languages = { "python", "bash", "html", "lua" },
			},
			chunks = "all",
			diagnostics = {
				enabled = true,
				trigger = { "BufWritePost" },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},
	{ -- (typst.nvim) Typst syntax
		"kaarmu/typst.vim",
		event = "Filetype typst",
		config = function()
			vim.g.typst_pdf_viewer = "sioyek"
		end,
	},
	{ -- (zk-nvim) Markdown note taking assistant
		"zk-org/zk-nvim",
		ft = "markdown",
		keys = {
			{
				"<leader>nn",
				function()
					vim.cmd("ZkNotes")
				end,
				desc = "note entries",
			},
			{
				"<leader>nl",
				function()
					vim.cmd("ZkLinks")
				end,
				desc = "note links",
			},
			{
				"<leader>nb",
				function()
					vim.cmd("ZkBacklinks")
				end,
				desc = "note backlinks",
			},
			{
				"<leader>nt",
				function()
					vim.cmd("ZkTags")
				end,
				desc = "note tags",
			},
			{
				"<leader>n",
				":'<,'>ZkNewFromTitleSelection<cr>",
				desc = "new note from selection",
				mode = "v",
			},
		},
		config = function()
			require("zk").setup({
				picker = "fzf_lua",
				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
				lsp = {},
			})
		end,
	},
	{ -- (d2-vim) D2 diagram
		"terrastruct/d2-vim",
		ft = { "d2" },
	},
}
