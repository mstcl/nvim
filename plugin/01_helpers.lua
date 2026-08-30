-- add padding around inlay hint
-- thanks https://github.com/nickkadutskyi/nvim/blob/0a06aaba3d0ac77256e0bf30842d1cb6ea742fe7/lua/ide/lsp/inlay_hint.lua
_G.helpers = {}
_G.helpers.lsp = {}

---Setup inlay hints
---@return table
_G.helpers.lsp.setup_inlay_hints = function()
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

---LSP capabilities
---@return table
_G.helpers.lsp.setup_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
			completionItem = {
				snippetSupport = true,
			},
		},
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	})

	return capabilities
end

-- now/deferred
_G.helpers.now = function(f) require("mini.misc").safely("now", f) end
_G.helpers.later = function(f) require("mini.misc").safely("later", f) end
_G.helpers.now_if_args = vim.fn.argc(-1) > 0 and _G.helpers.now or _G.helpers.later

---Helper to highlight str with group hl in string representation
---@param str string
---@param hl string
---@return string
_G.helpers.set_hl = function(str, hl, restore)
	restore = restore == nil or restore
	return restore
			and table.concat({
				"%#",
				hl,
				"#",
				str or "",
				"%*",
			})
		or table.concat({ "%#", hl, "#", str or "" })
end

---Shortcut syntax to create autocmd with augroup @param group string @vararg { [1]: string|string[], [2]: vim.api.keyset.create_autocmd }
---@return nil
_G.helpers.new_autocmd = function(group, ...)
	local id = vim.api.nvim_create_augroup(group, { clear = true })
	for _, a in ipairs({ ... }) do
		a[2].group = id
		---@diagnostic disable-next-line: missing-parameter
		vim.api.nvim_create_autocmd(unpack(a))
	end
end

---Detecting big file size (> 400 KB)
---Normally we want to pass `vim.fn.expand("%")`
---@param filepath string
---@return boolean
_G.helpers.is_big_file = function(filepath)
	if vim.fn.getfsize(filepath) > (400 * 1024) then return true end
	return false
end

-- Define custom `vim.pack.add()` hook helper. See `:h vim.pack-events`.
_G.helpers.on_packchanged = function(plugin_name, kinds, callback, desc)
	local f = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
			return
		end
		if not ev.data.active then vim.cmd.packadd(plugin_name) end
		callback()
	end
	_G.helpers.new_autocmd("deps", {
		"PackChanged",
		{
			pattern = "*",
			callback = f,
			desc = desc,
		},
	})
end

--- Register a toggle handler for the unified Toggle command
---@param name string The toggle name (what users type)
---@param aliases string[] Optional aliases for the toggle
---@param handler function The function to call when toggled
_G.helpers.register_toggle = function(name, aliases, handler)
	_G.toggle_registry[name:lower()] = handler
	if aliases then
		for _, alias in ipairs(aliases) do
			_G.toggle_registry[alias:lower()] = handler
		end
	end
end

--- Register a mode handler for the unified Mode command
---@param name string The mode name (what users type)
---@param aliases string[] Optional aliases for the mode
---@param handler function The function to call when entering the mode
_G.helpers.register_mode = function(name, aliases, handler)
	_G.mode_registry[name:lower()] = handler
	if aliases then
		for _, alias in ipairs(aliases) do
			_G.mode_registry[alias:lower()] = handler
		end
	end
end
