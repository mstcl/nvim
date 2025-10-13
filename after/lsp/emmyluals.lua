---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/emmylua_ls") },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".emmyrc.json", ".luacheckrc", ".git" },
	single_file_support = true,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", requirePattern = { "lua/?.lua", "lua/?/init.lua" } },
			workspace = {
				library = { "$VIMRUNTIME", "$LLS_Addons/luvit", "$HOME/.local/share/nvim/lazy" },
				ignoreGlobs = { "**/*_spec.lua" },
			},
		},
	},
}
