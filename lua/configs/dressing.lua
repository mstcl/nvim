require("dressing").setup({
	input = {
		default_prompt = "❯❯ ",
		insert_only = true,
		prompt_align = "left",
		start_in_insert = true,
		relative = "cursor",
		border = "single",
		prefer_width = 20,
		max_width = nil,
		min_width = 10,
		get_config = nil,
		win_options = {
			winblend = 0,
			winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder,FloatTitle:Pmenu",
		},
	},
    override = {
        anchor = "SW",
    },
	select = {
		enabled = false,
	},
})
