local augroup = require("core.utils").augroup
local conf = require("core.variables")
-- Plugins to extend syntax, either natively or with treesitter
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		version = false,
		lazy = vim.fn.argc(-1) == 0,
		keys = {
			{
				"<C-M>t",
				function()
					vim.cmd("TSBufToggle highlight")
					vim.notify("Toggled treesitter highlighting", vim.log.levels.INFO)
				end,
				desc = "Toggle treesitter highlighting",
			},
			{
				"an",
				desc = "Increment TS node",
				mode = { "o", "x" },
			},
			{
				"aN",
				desc = "Increment TS scope",
				mode = { "o", "x" },
			},
			{
				"in",
				desc = "Decrement TS node",
				mode = { "o", "x" },
			},
		},
		cmd = {
			"TSInstall",
			"TSInstallSync",
			"TSInstallInfo",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSBufEnable",
			"TSBufToggle",
			"TSEnable",
			"TSToggle",
			"TSModuleInfo",
			"TSEditQuery",
			"TSEditQueryUserAfter",
		},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
			augroup("Treesitter", {
				{ "VimEnter" },
				{
					pattern = "*.zsh",
					command = "silent! TSBufDisable highlight",
				},
			})
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
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]k"] = { query = "@block.outer", desc = "Next block start" },
							["]f"] = { query = "@function.outer", desc = "Next function start" },
							["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
						},
						goto_next_end = {
							["]K"] = { query = "@block.outer", desc = "Next block end" },
							["]F"] = { query = "@function.outer", desc = "Next function end" },
							["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
						},
						goto_previous_start = {
							["[k"] = { query = "@block.outer", desc = "Previous block start" },
							["[f"] = { query = "@function.outer", desc = "Previous function start" },
							["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
						},
						goto_previous_end = {
							["[K"] = { query = "@block.outer", desc = "Previous block end" },
							["[F"] = { query = "@function.outer", desc = "Previous function end" },
							["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
						},
					},
					swap = {
						enable = true,
						swap_next = {
							[">K"] = { query = "@block.outer", desc = "Swap next block" },
							[">F"] = { query = "@function.outer", desc = "Swap next function" },
							[">A"] = { query = "@parameter.inner", desc = "Swap next parameter" },
						},
						swap_previous = {
							["<K"] = { query = "@block.outer", desc = "Swap previous block" },
							["<F"] = { query = "@function.outer", desc = "Swap previous function" },
							["<A"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
						},
					},
				},
			}
		end,
		config = function(_, opts)
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
			vim.schedule(function()
				require("lazy").load({ plugins = { "nvim-treesitter-textobjects" } })
			end)
		end,
	},
	{
		-- Concealing in tex
		"KeitaNakamura/tex-conceal.vim",
		cond = conf.syntax_features.tex,
		ft = { "tex" },
	},
	{
		-- Quarto syntax
		"quarto-dev/quarto-nvim",
		dev = false,
		cond = conf.syntax_features.quarto,
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
	{
		-- Typst syntax
		"kaarmu/typst.vim",
		cond = conf.syntax_features.typst,
		event = "Filetype",
		config = function()
			vim.g.typst_pdf_viewer = "sioyek"
		end,
	},
	{
		-- Python notebooks
		"benlubas/molten-nvim",
		ft = "quarto",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		keys = {
			{
				"me",
				":<C-u>MoltenEvaluateVisual<cr>gv",
				mode = "v",
				desc = "Evaluate cell (visual)",
				buffer = true,
			},
			{ "md", "<cmd>MoltenDelete<cr>",            desc = "Delete cell",      buffer = true },
			{ "mh", "<cmd>MoltenHideOutput<cr>",        desc = "Hide cell output", buffer = true },
			{ "mo", ":noautocmd MoltenEnterOutput<cr>", desc = "Open cell output", buffer = true },
			{ "]e", "<cmd>MoltenNext<cr>",              desc = "Next cell",        buffer = true },
			{ "[e", "<cmd>MoltenPrev<cr>",              desc = "Next cell",        buffer = true },
		},
		cond = conf.syntax_features.quarto,
		init = function()
			vim.g.molten_image_provider = "none"
			vim.g.molten_wrap_output = true
			vim.g.molten_auto_open_output = false
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_output_virt_lines = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_text_max_lines = 10
			vim.g.molten_output_crop_border = 10
			vim.g.molten_output_win_style = "minimal"
			vim.g.molten_output_win_cover_gutter = false
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_output_win_border = "none"
			local imb = function(e)
				vim.schedule(function()
					local kernels = vim.fn.MoltenAvailableKernels()
					local try_kernel_name = function()
						local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
						return metadata.kernelspec.name
					end
					local ok, kernel_name = pcall(try_kernel_name)
					if not ok or not vim.tbl_contains(kernels, kernel_name) then
						kernel_name = nil
						local venv = os.getenv("VIRTUAL_ENV")
						if venv ~= nil then
							kernel_name = string.match(venv, "/.+/(.+)")
						end
					end
					if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
						vim.cmd(("MoltenInit %s"):format(kernel_name))
					end
					vim.cmd("MoltenImportOutput")
				end)
			end
			vim.api.nvim_create_autocmd("BufAdd", {
				pattern = { "*.ipynb" },
				callback = imb,
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.ipynb" },
				callback = function(e)
					if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
						imb(e)
					end
				end,
			})
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.ipynb" },
				callback = function()
					if require("molten.status").initialized() == "Molten" then
						vim.cmd("MoltenExportOutput!")
					end
				end,
			})
		end,
	},
	{
		-- Convert ipython notebooks to something sane
		"GCBallesteros/jupytext.nvim",
		event = "VeryLazy",
		cond = conf.syntax_features.quarto,
		opts = {
			style = "quarto",
			output_extension = "qmd",
			force_ft = "quarto",
		},
	},
	{
		-- Git conflicts helper
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre",
		keys = {
			{
				"co",
				"<Plug>(git-conflict-ours)",
				desc = "Choose ours (conflict)",
			},
			{
				"ct",
				"<Plug>(git-conflict-theirs)",
				desc = "Choose theirs (conflict)",
			},
			{
				"cb",
				"<Plug>(git-conflict-both)",
				desc = "Choose both (conflict)",
			},
			{
				"cn",
				"<Plug>(git-conflict-none)",
				desc = "Choose none (conflict)",
			},
			{
				"]x",
				"<Plug>(git-conflict-next-conflict)",
				desc = "Next conflict",
			},
			{
				"[x",
				"<Plug>(git-conflict-prev-conflict)",
				desc = "Previous conflict",
			},
		},
		opts = function()
			return {
				default_mappings = false,
				disable_diagnostics = true,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
					ancestor = "DiffChange"
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("git-conflict").setup(opts)
			end
		end,
	},
	{
		-- Display wordcount under section header
		"dimfeld/section-wordcount.nvim",
		ft = { "markdown", "quarto" },
		cond = conf.syntax_features.markdown,
		opts = {
			highlight = "NonText",
			virt_text_pos = "eol",
		},
		config = function(_, opts)
			if opts then
				require("section-wordcount").setup(opts)
			end
			require("section-wordcount").wordcounter({})
		end,
	},
	{
		-- Markdown note taking assistant
		"zk-org/zk-nvim",
		ft = "markdown",
		cond = conf.syntax_features.markdown,
		keys = {
			{
				"<leader>ne",
				"<cmd>ZkNotes<cr>",
				desc = "Note entries",
			},
			{
				"<leader>nn",
				function()
					vim.ui.input({ prompt = "Enter path/title: " }, function(input)
						if input == nil then
							return
						end
						local rel = ""
						local title = ""
						for k, v in string.gmatch(input, "(.*)/(.*)") do
							rel = k
							title = v
						end
						require("zk.commands").get("ZkNew")({
							dir = rel,
							title = title,
						})
					end)
				end,
				desc = "New note",
			},
			{
				"<leader>nl",
				"<cmd>ZkLinks<cr>",
				desc = "Note links",
			},
			{
				"<leader>nb",
				"<cmd>ZkBacklinks<cr>",
				desc = "Note backlinks",
			},
			{
				"<leader>nt",
				"<cmd>ZkTags<cr>",
				desc = "Note tags",
			},
			{
				"<leader>n",
				":'<,'>ZkNewFromTitleSelection<cr>",
				desc = "New note from selection",
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
				lsp = {
					config = {
						cmd = { "zk", "lsp" },
						name = "kz",
						on_attach = require("lsp.utils").on_attach,
						capabilities = require("lsp.utils").capabilities,
						handlers = require("lsp.utils").handlers,
						flags = {
							debounce_text_changes = 150,
						},
					},
				},
			})
		end,
	},
	{
		-- D2 diagram
		"terrastruct/d2-vim",
		ft = { "d2" },
	},
}
