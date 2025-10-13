---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/gitlab-ci-ls") },
	filetypes = { "yaml.gitlab" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(_G.lsp.root_pattern(".git", ".gitlab*")(fname))
	end,
	settings = {},
}
