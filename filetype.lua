vim.filetype.add({
	extension = {
		sbat = "sh",
		conf = "config",
		rasi = "css",
		tmpl = "gotmpl",
	},
	pattern = {
		["~/%.config/mutt/%a*"] = "muttrc",
		[".*/tasks/.*.yml"] = "yaml.ansible",
		[".*/main.yml"] = "yaml.ansible",
		[".*/playbooks/.*.yml"] = "yaml.ansible",
		[".*/docker-compose.yml"] = "yaml",
		[".*/fontconfig/%a*"] = "xml",
	},
})
