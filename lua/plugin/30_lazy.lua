require("lazy").setup({
	spec = {
		{ import = "specs" },
		{ import = "specs.override" },
	},
	default = { lazy = true },
	dev = {
		path = "~/projects",
		patterns = _G.config.dev_plugins,
		fallback = false,
	},
	install = {
		missing = true,
		colorscheme = { "tavern_extended" },
	},
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "rounded",
		title = " Plugin manager ",
		title_pos = "center", ---@type "center" | "left" | "right"
		pills = true, ---@type boolean
		icons = {
			cmd = "⌘",
			config = "[C]",
			event = "[E]",
			ft = "[F]",
			init = "[IN]",
			import = "[IM]",
			keys = "[K]",
			lazy = "[L]",
			loaded = "●",
			not_loaded = "○",
			plugin = "",
			runtime = "[RTP]",
			require = "",
			source = "",
			start = "",
			task = "",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
		browser = nil, ---@type string?
		throttle = 20,
		backdrop = 100,
	},
	diff = {},
	checker = {
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true,
		frequency = 3600,
		check_pinned = false,
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			reset = true,
			---@type string[]
			paths = {},
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				"gzip",
				"zip",
				"zipPlugin",
				"netrw",
				"netrw_nogx",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tar",
				"tarPlugin",
				"getscript",
				"getscriptPlugin",
				"vimballPlugin",
				"2html_plugin",
				"spellfile_plugin",
				"tutor_mode_plugin",
				"matchit",
				"tutor",
				"tohtml",
				"matchparen",
			},
		},
	},
	readme = {
		enabled = false,
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		skip_if_doc_exists = true,
	},
	state = vim.fn.stdpath("state") .. "/lazy/state.json",
	build = {
		warn_on_override = true,
	},
	profiling = {
		loader = false,
		require = false,
	},
})
