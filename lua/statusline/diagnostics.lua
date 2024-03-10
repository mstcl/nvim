local diag = vim.diagnostic
local diagnostics_color = {
	ERROR = "StatuslineOrange",
	WARN = "StatuslineYellow",
	HINT = "StatuslineRed",
	INFO = "StatuslineBlue",
}
local add_highlight_name = require("statusline.utils").add_highlight_name
local is_color = require("statusline.utils").is_color

return {
	name = "diagnostics",
	event = { "DiagnosticChanged" },
	user_event = {},
	timing = true,
	lazy = false,
	configs = {},
	padding = 1,
	condition = function()
		local ft = vim.api.nvim_buf_get_option(0, "filetype")
		return ft ~= "lazy"
	end,
	update = function()
		local result = {}
		local icons = {
			ERROR = require("user_configs").lsp_signs["Error"],
			WARN = require("user_configs").lsp_signs["Warn"],
			INFO = require("user_configs").lsp_signs["Info"],
			HINT = require("user_configs").lsp_signs["Hint"],
		}
		local order = { "ERROR", "WARN", "INFO", "HINT" }

		for _, key in ipairs(order) do
			local count = #diag.get(0, { severity = diag.severity[key] })
			if count > 0 then
				local color = diagnostics_color[key]
				if color then
					if is_color(color) or type(color) == "table" then
						table.insert(
							result,
							add_highlight_name(icons[key] .. count, "STTUSLINE_DIAGNOSTICS_" .. key)
						)
					else
						table.insert(result, add_highlight_name(icons[key] .. count, color))
					end
				end
			end
		end

		return #result > 0 and table.concat(result, " ") or ""
	end,
}
