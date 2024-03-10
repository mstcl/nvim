local M = {}
local highlight = require("sttusline.highlight")

M.add_highlight_name = highlight.add_highlight_name
M.is_color = function(color)
	return type(color) == "string" and color:match("^#%x%x%x%x%x%x$")
end

return M
