---@type vim.lsp.Config
return {
	single_file_support = true,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				requirePattern = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				library = {
					"$VIMRUNTIME",
					"$LLS_Addons/luvit",
					"$HOME/.local/share/nvim/site/pack/deps/opt",
				},
				ignoreGlobs = { "**/*_spec.lua" },
			},
		},
	},
}
