local present, orgmode = pcall(require, "orgmode")
if not present then
	return
end

orgmode.setup({
	org_agenda_files = { "~/sftpgo/orgzly/*", "~/sftpgo/shared/orgzly/*" },
	win_split_mode = "float",
	org_hide_emphasis_markers = true,
})
orgmode.setup_ts_grammar()
