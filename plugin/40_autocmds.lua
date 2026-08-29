-- Custom user autocommands
-- this file is basically self-documenting and honestly it's a bit messy so
-- I won't be documenting every single one of them

_G.augroup("formatoptions", {
	"BufEnter",
	{
		pattern = "*",
		desc = "set the format options globally",
		callback = function()
			local vals = { "c", "r", "o" }
			for _, val in ipairs(vals) do
				vim.opt_local.formatoptions:remove(val)
			end
		end,
	},
})

_G.augroup("clean", {
	{ "BufRead", "BufEnter", "BufReadPre", "FileType" },
	{
		desc = "disable some buffer noise for special buftypes/filetypes",
		pattern = { "*" },
		callback = function()
			local special_buftype = {
				nofile = true,
				help = true,
				quickfix = true,
				prompt = true,
				acwrite = true,
			}
			local special_filetype = {
				ipynb = true,
			}
			if
				special_buftype[vim.bo.buftype]
				or special_filetype[vim.bo.filetype]
			then
				vim.wo.colorcolumn = ""
				vim.opt_local.list = false
			end
		end,
	},
})

_G.augroup("prose", {
	{ "BufNewFile", "BufRead" },
	{
		desc = "enable text editing options, spellcheck and spell correction on certain filetypes",
		pattern = { "*.md", "*.txt", "*.tex", "*.org", "*.qmd", "*.typ" },
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.list = false
			vim.opt_local.spell = true

			-- Set keymap for spell autocorrect
			vim.keymap.set(
				"i",
				"<C-L>",
				"<c-g>u<Esc>[s1z=`]a<c-g>u",
				{ noremap = true, silent = true }
			) -- autocorrect last spelling error
		end,
	},
})

_G.augroup("help", {
	{ "Filetype" },
	{
		desc = "open help in vertical split",
		pattern = "help",
		callback = function()
			vim.bo.bufhidden = "unload"
			vim.cmd.wincmd("L")
			vim.cmd("vertical resize 81")
		end,
	},
})

_G.augroup("root", {
	{ "BufEnter" },
	{
		desc = "set cwd to project root directory",
		callback = function(args)
			local root = vim.fs.root(args.buf, {
				".git",
				"pyproject.toml",
				"README.md",
				"go.mod",
				"Cargo.toml",
			})
			if root and root ~= "." then pcall(vim.cmd.tcd, root) end
		end,
	},
})

_G.augroup("bigfile", {
	{ "BufReadPre" },
	{
		desc = "set settings for really big files",
		pattern = "*",
		callback = function()
			if _G.big(vim.fn.expand("%")) then vim.cmd("Mode bigfile") end
		end,
	},
})

_G.augroup("terminal", {
	{ "TermOpen", "BufWinEnter", "WinEnter" },
	{
		desc = "set settings for terminal",
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "terminal" and vim.bo.filetype == "" then
				vim.cmd("Mode minimal")
			end
		end,
	},
}, {
	{ "TermLeave" },
	{
		desc = "reload buffers when leaving terminal",
		pattern = "*",
		callback = function() vim.cmd.checktime() end,
	},
})

_G.augroup("lsp", {
	"LspAttach",
	{
		desc = "on attach for LSP",
		callback = function(args)
			local bufnr = args.buf
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

			-- Set semantic tokens priority
			vim.hl.priorities.semantic_tokens = 125
			if client and vim.bo[args.buf].filetype == "python" then
				client.server_capabilities.semanticTokensProvider = nil
			end

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
				desc = "Definition",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, {
				desc = "Type definition",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "grr", vim.lsp.buf.references, {
				desc = "References",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
				desc = "Implementation",
				noremap = true,
				silent = true,
				buffer = bufnr,
			})

			if client.server_capabilities.inlayHintProvider then
				vim.keymap.set("n", "<leader>i", function()
					---@diagnostic disable-next-line: missing-parameter
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, {
					desc = "Inlay hints",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
			end

			if client.server_capabilities.codeActionProvider then
				vim.keymap.set("n", "gra", vim.lsp.buf.code_action, {
					desc = "Code actions",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
				vim.keymap.set(
					"v",
					"gra",
					":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
					{
						desc = "Code actions",
						noremap = true,
						silent = true,
						buffer = bufnr,
					}
				)
			end

			if client.server_capabilities.codeLensProvider then
				vim.keymap.set({ "n" }, "grl", vim.lsp.codelens.run, {
					desc = "Code lens",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
			end

			if client.server_capabilities.declarationProvider then
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
					desc = "Declaration",
					noremap = true,
					silent = true,
					buffer = bufnr,
				})
			end

			-- inlay hints
			if client.server_capabilities.inlayHintProvider then
				setup_inlay_hints()
				vim.lsp.inlay_hint.enable(_G.config.lsp.features.inlay_hints)
			end

			-- code lens
			if client.server_capabilities.codeLensProvider then
				vim.lsp.codelens.enable(true, { buffer = bufnr, client = client })
				_G.augroup("codeLensRefresh", {
					{ "BufEnter", "CursorHold", "InsertLeave" },
					{
						buffer = bufnr,
						callback = function()
							vim.lsp.codelens.enable(true, {
								buffer = bufnr,
								client = client,
							})
						end,
					},
				})
			end
		end,
	},
})

-- add padding around inlay hint
-- thanks https://github.com/nickkadutskyi/nvim/blob/0a06aaba3d0ac77256e0bf30842d1cb6ea742fe7/lua/ide/lsp/inlay_hint.lua
function setup_inlay_hints()
	local inlay_hint = require("vim.lsp._capability").all.inlay_hint
	if inlay_hint.pill_renderer then return end
	inlay_hint.pill_renderer = true

	function inlay_hint:on_win(topline, botline)
		local api = vim.api
		local buf_versions = require("vim.lsp.util").buf_versions

		for _, state in pairs(self.client_state) do
			local current_result = state.current_result
			if current_result.version == buf_versions[self.bufnr] then
				if not current_result.namespace_cleared then
					api.nvim_buf_clear_namespace(self.bufnr, state.namespace, 0, -1)
					current_result.namespace_cleared = true
				end

				local hints = assert(current_result.hints)
				for lnum = topline, botline do
					local hint_virtual_texts = {}
					local line_hints = hints[lnum]
					if line_hints and not line_hints.applied then
						line_hints.applied = true
						for _, hint in pairs(line_hints.hints) do
							local label = hint.label
							local text = type(label) == "string" and label
								or vim.iter(label)
									:map(function(part) return part.value end)
									:join("")
							local virtual_text = hint_virtual_texts[hint.position.character]
								or {}

							virtual_text[#virtual_text + 1] = { "▐", "NonText" }
							virtual_text[#virtual_text + 1] =
								{ text, "LspInlayHint" }
							virtual_text[#virtual_text + 1] = { "▌", "NonText" }

							hint_virtual_texts[hint.position.character] =
								virtual_text
						end
					end

					for position, virtual_text in pairs(hint_virtual_texts) do
						api.nvim_buf_set_extmark(
							self.bufnr,
							state.namespace,
							lnum,
							position,
							{
								virt_text_pos = "inline",
								ephemeral = false,
								virt_text = virtual_text,
							}
						)
					end
				end
			end
		end
	end
end
