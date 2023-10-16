local present, noice = pcall(require, "noice")
if not present then
	return
end

local notify = require("notify")

noice.setup({
	lsp = {
		progress = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		-- command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	messages = {
		view_search = false,
	},
	views = {
		notify = {
			border = {
				style = "none",
			},
		},
		cmdline_popup = {
			position = {
				row = 8,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
			border = {
				style = "none",
				padding = { 1, 2 },
			},
			filter_options = {},
			win_options = {
				winhighlight = { Normal = "Pmenu", FloatBorder = "Pmenu" },
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 11,
				col = "50%",
			},
			size = {
				width = 60,
				height = 10,
			},
			border = {
				style = "none",
				padding = { 1, 2 },
			},
			win_options = {
				winhighlight = { Normal = "Pmenu", FloatBorder = "Pmenu" },
			},
		},
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "lua_error",
				find = "UfoFallbackException",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "[w]",
			},
			opts = { skip = true },
		},
		{
			view = "split",
			filter = { event = "msg_show", min_height = 20 },
		},
	},
	cmdline = {
		enabled = true,
		format = {
			cmdline = {
				icon = "➤",
			},
			search_up = {
				icon = "↑",
			},
			search_down = {
				icon = "↓",
			},
			filter = {
				icon = "⊞",
			},
			help = {
				icon = "?",
			},
		},
	},
})

notify.setup({
	fps = 144,
	icons = {
		DEBUG = "*",
		ERROR = "✗",
		INFO = "i",
		TRACE = ">",
		WARN = "!",
	},
	minimum_width = 40,
	render = "compact",
	top_down = false,
})
