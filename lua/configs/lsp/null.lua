local present, null_ls = pcall(require, "none-ls")
local navic = require("nvim-navic")
if not present then
	return
end

local function applyFoldsAndThenCloseAllFolds(bufnr, providerName)
	require("async")(function()
		bufnr = bufnr or vim.api.nvim_get_current_buf()
		require("ufo").attach(bufnr)
		local ok, ranges = pcall(await, require("ufo").getFolds(bufnr, providerName))
		if ok and ranges then
			ok = require("ufo").applyFolds(bufnr, ranges)
		end
	end)
end

local on_attach = function(client, bufnr)
	applyFoldsAndThenCloseAllFolds(bufnr, "indent")
	require("utils.mappings").lsp_keymaps(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

local sources = {
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.formatting.black,
	null_ls.builtins.diagnostics.chktex,
	null_ls.builtins.diagnostics.cppcheck,
	null_ls.builtins.diagnostics.codespell,
	null_ls.builtins.diagnostics.vint,
	null_ls.builtins.diagnostics.revive,
	null_ls.builtins.diagnostics.proselint,
	null_ls.builtins.diagnostics.mypy,
	null_ls.builtins.diagnostics.pylint,
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.latexindent.with({
		args = { "-m", "-l", "~/downloads/textwrap.yaml", "-" },
	}),
	null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({
	sources = sources,
	log = {
		enable = true,
		level = "error",
		use_console = "async",
	},
	on_attach = on_attach,
})
