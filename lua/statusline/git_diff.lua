local order = { "added", "changed", "removed" }
local icons = {
	added = "+",
	changed = "~",
	removed = "-",
}
local diff_colors = {
	added = "StatuslineGreen",
	changed = "StatuslineMagenta",
	removed = "StatuslineRed",
}
local add_highlight_name = require("statusline.utils").add_highlight_name
local is_color = require("statusline.utils").is_color

return {
	"git-diff",
	{
		name = "git_diff",
		event = { "BufWritePost", "VimResized", "BufEnter" },
		user_event = { "GitSignsUpdate" },
		timing = true,
		lazy = false,
		configs = {
			icons = icons,
			order = order,
		},
		padding = 1,
		colors = { "StatuslineAlt" },
		condition = function()
			return vim.b.gitsigns_status_dict ~= nil and vim.o.columns > 70
		end,
		update = function()
			local git_status = vim.b.gitsigns_status_dict
			local result = {}
			if git_status == nil then
				return "n/a"
			elseif git_status["added"] == 0 and git_status["changed"] == 0 and git_status["removed"] == 0 then
				return "clean"
			else
				for _, v in ipairs(order) do
					if git_status[v] and git_status[v] > 0 then
						local color = diff_colors[v]

						if color then
							if is_color(color) or type(color) == "table" then
								table.insert(
									result,
									add_highlight_name(icons[v] .. git_status[v], "STTUSLINE_GIT_DIFF_" .. v)
								)
							else
								table.insert(result, add_highlight_name(icons[v] .. git_status[v], color))
							end
						end
					end
				end
				return #result > 0 and table.concat(result, " ") or ""
			end
		end,
	},
}
