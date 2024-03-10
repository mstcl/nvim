-- Additional addons go here
return {
	-- "rktjmp/lush.nvim",
	-- "rktjmp/shipwright.nvim",
	{
		"nvim-orgmode/orgmode",
		opts = {
			org_capture_templates = { t = { description = "New task", template = "* TODO %?\n  %u" } },
			org_default_notes_file = "~/sftpgo/notes/Main.org",
		},
	},
}
