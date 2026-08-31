---@diagnostic disable-next-line: param-type-not-match
-- Configure builtin diagnostics

_G.helpers.later(function()
	local lsp_status_signs = {
		[vim.diagnostic.severity.ERROR] = config.signs.lsp.Error,
		[vim.diagnostic.severity.WARN] = config.signs.lsp.Warn,
		[vim.diagnostic.severity.INFO] = config.signs.lsp.Info,
		[vim.diagnostic.severity.HINT] = config.signs.lsp.Hint,
	}

	local lsp_status_hl_map = {
		[vim.diagnostic.severity.ERROR] = "DiagnosticError",
		[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
		[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
		[vim.diagnostic.severity.HINT] = "DiagnosticHint",
	}

	vim.diagnostic.config({
		---@type vim.diagnostic.Opts
		virtual_lines = false,
		virtual_text = false,
		underline = false,
		update_in_insert = false,
		severity_sort = true,

		signs = {},

		status = {
			format = function(severity_counts)
				local items = {}
				for severity in ipairs(vim.diagnostic.severity) do
					local count = severity_counts[severity] or 0
					if count ~= 0 then
						table.insert(
							items,
							("%%#%s#%s:%s"):format(
								lsp_status_hl_map[severity],
								lsp_status_signs[severity],
								count
							)
						)
					end
				end
				return table.concat(items, " ")
			end,
		},

		float = {
			close_events = {
				"BufLeave",
				"CursorMoved",
				"InsertEnter",
				"FocusLost",
			},
			border = config.border,
			source = "always",
			focus = false,
		},
	})
end)
