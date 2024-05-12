local augroup = require("utils.misc").augroup

-- Plugins to extend syntax, either natively or with treesitter
return {
	{
		-- Treesitter engine
		"nvim-treesitter/nvim-treesitter",
		version = false,
		keys = {
			{
				"<C-M>t",
				function()
					vim.cmd("TSBufToggle highlight")
					vim.notify("Toggled treesitter highlighting", vim.log.levels.INFO)
				end,
				desc = "Toggle treesitter highlighting",
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
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		init = function(plugin)
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
		opts = {
			ensure_installed = require("user_configs").treesitter_sources,
			sync_install = false,
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = { "org" },
				disable = { "latex", "yaml", "yaml.ansible" },
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
		},
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
		end,
	},
	{
		-- Highlight argument's definition and usage
		"m-demare/hlargs.nvim",
		ft = {
			"c",
			"cpp",
			"c_sharp",
			"go",
			"java",
			"javascript",
			"jsx",
			"julia",
			"kotlin",
			"lua",
			"nix",
			"php",
			"python",
			"r",
			"ruby",
			"rust",
			"solidity",
			"tsx",
			"typescript",
			"vim",
			"zig",
		},
		cond = require("user_configs").syntax_features.hlargs,
		opts = {
			color = "#87591a",
			hl_priority = 200,
		},
	},
	{
		-- Highlight parenthesis
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufRead" },
		cond = require("user_configs").syntax_features.rainbow,
		opts = {
			query = {
				[""] = "rainbow-delimiters",
				latex = "rainbow-blocks",
				lua = "rainbow-blocks",
			},
			highlight = {
				"TSRainbowRed",
				"TSRainbowBlue",
				"TSRainbowCyan",
				"TSRainbowGreen",
				"TSRainbowviolet",
				"TSRainbowYellow",
			},
		},
		config = function(_, opts)
			if opts then
				vim.g.rainbow_delimiters = opts
			end
		end,
	},
	{
		-- Concealing in tex
		"KeitaNakamura/tex-conceal.vim",
		cond = require("user_configs").syntax_features.tex,
		ft = { "tex" },
	},
	{
		-- An angry reviewer in your latecx files
		"anufrievroman/vim-angry-reviewer",
		cmd = "AngryReviewer",
		cond = require("user_configs").syntax_features.tex,
		config = function()
			vim.g.AngryReviewerEnglish = "british"
		end,
	},
	{
		-- Orgmode syntax
		"nvim-orgmode/orgmode",
		cond = require("user_configs").syntax_features.org,
		event = { "BufReadPre", "BufEnter *.org", "BufWinEnter *.org" },
		opts = {
			mappings = {
				org = {
					org_return = false,
				},
			},
			org_agenda_files = require("user_configs").org_agenda_files,
			win_split_mode = "vsplit",
			win_border = "single",
			org_highlight_latex_and_related = "entities",
			org_hide_emphasis_markers = true,
		},
		config = function(_, opts)
			if opts then
				require("orgmode").setup(opts)
			end
		end,
		init = function()
			local wk = require("which-key")
			wk.register({
				["<leader>o"] = { name = "Org mode actions" },
			})
		end,
	},
	{
		-- Org bullet
		"akinsho/org-bullets.nvim",
		cond = require("user_configs").syntax_features.org,
		event = { "BufReadPre", "BufEnter *.org", "BufWinEnter *.org" },
		opts = function()
			return {
				indent = true,
				symbols = {
					list = "•",
					headlines = { "◎", "○", "●", "◌" },
					checkboxes = {
						half = { "-", "OrgTSCheckboxHalfChecked" },
						done = { "✓", "OrgDone" },
						todo = { "✗", "OrgTODO" },
					},
				},
			}
		end,
		config = function(_, opts)
			if opts then
				require("org-bullets").setup(opts)
			end
		end,
	},
	{
		-- QUARTO setup
		"quarto-dev/quarto-nvim",
		dev = false,
		cond = require("user_configs").syntax_features.quarto,
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
		cond = require("user_configs").syntax_features.typst,
		event = "FileType",
		config = function()
			vim.g.typst_pdf_viewer = "sioyek"
		end,
	},
	{
		-- Ansible syntax
		"pearofducks/ansible-vim",
		cond = require("user_configs").syntax_features.ansible,
		event = { "BufReadPre *.j2", "BufReadPre *.yml" },
		config = function()
			vim.g.ansible_template_syntaxes = {
				["*.rb.j2"] = "ruby",
				["*.sh.j2"] = "sh",
				["*.conf.j2"] = "config",
				["*.yml.j2"] = "yaml",
				["*.yaml.j2"] = "yaml",
				["*.css.j2"] = "css",
				["*.json.j2"] = "json",
			}
			vim.g.ansible_unindent_after_newline = true
			vim.g.ansible_extra_keywords_highlight = true
		end,
	},
	{
		-- Python notebooks
		"benlubas/molten-nvim",
		ft = "quarto",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		cond = require("user_configs").syntax_features.quarto,
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
		-- Display images inside (kinda broken on Arch)
		"3rd/image.nvim",
		build = "luarocks --local install magick --lua-version=5.1",
		ft = { "markdown", "org", "ipynb", "quarto" },
		-- cond = vim.fn.expand("$SSH_CLIENT") == "$SSH_CLIENT",
		cond = false,
		opts = {
			integrations = {
				markdown = {
					filetypes = { "markdown", "vimwiki", "quarto" },
				},
				neorg = {
					filetypes = { "org" },
				},
			},
			backend = "ueberzug",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		-- Convert ipython notebooks to something sane
		"GCBallesteros/jupytext.nvim",
		event = "VeryLazy",
		cond = require("user_configs").syntax_features.quarto,
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
			}
		end,
		config = function(_, opts)
			if opts then
				require("git-conflict").setup(opts)
			end
		end,
	},
}
