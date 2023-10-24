local gl = require("galaxyline")
local noice = require("noice")
local condition = require("galaxyline.condition")
local buffer = require("galaxyline.provider_buffer")
local vcs = require("galaxyline.provider_vcs")
local gls = gl.section
local vi_mode = require("utils.misc").statusline_vi_mode

gl.short_line_list = require("user_configs").statusline_short_ft

gls.left[1] = {
	ViMode = {
		provider = require("utils.misc").statusline_vi_mode,
		highlight = "GalaxyFg",
	},
}

-- gls.left[2] = {
-- 	FileName = {
-- 		provider = function()
-- 			return fileinfo.get_current_file_name("●", "✗")
-- 		end,
-- 		condition = condition.buffer_not_empty,
-- 		highlight = "GalaxyFgAlt",
-- 		icon = " ",
-- 	},
-- }

gls.left[2] = {
	FileFormat = {
		provider = function()
			return buffer.get_buffer_filetype()
		end,
		highlight = "GalaxyFgAlt",
		icon = "  ",
		separator_highlight = "GalaxyFgAlt",
		separator = " ",
	},
}

-- gls.left[3] = {
-- 	GitTag = {
-- 		provider = function()
-- 			return "GIT "
-- 		end,
-- 		condition = condition.check_git_workspace,
-- 		highlight = "GalaxyFgAlt2I",
-- 		separator_highlight = "GalaxyFgAlt2I",
-- 		icon = " "
-- 	}
-- }

-- gls.left[7] = {
-- 	BranchSpace = {
-- 		provider = function()
-- 			return " "
-- 		end,
-- 		highlight = "GalaxyFgAlt2",
-- 	},
-- }

gls.left[4] = {
	GitBranch = {
		provider = function()
			if vcs.get_git_branch() == nil then
				return ""
			else
				return "[" .. vcs.get_git_branch() .. "]"
			end
		end,
		condition = condition.check_git_workspace,
		highlight = "GalaxyFgAlt2",
		icon = " ",
		-- separator_highlight = "GalaxyFgAlt2",
		-- separator = " ",
	},
}

gls.left[5] = {
	DiffAdd = {
		provider = "DiffAdd",
		icon = "  +",
		highlight = "GalaxyGreen",
		separator_highlight = "GalaxyFgAlt2",
		separator = "",
	},
}

gls.left[6] = {
	DiffModified = {
		provider = "DiffModified",
		icon = "  ~",
		highlight = "GalaxyMagenta",
		separator_highlight = "GalaxyFgAlt2",
		separator = "",
	},
}

gls.left[7] = {
	DiffRemove = {
		provider = vcs.diff_remove,
		icon = "  -",
		highlight = "GalaxyRed",
		separator_highlight = "GalaxyFgAlt2",
		separator = "",
	},
}

gls.left[8] = {
	Extra1 = {
		provider = function()
			if vcs.diff_remove() == nil and vcs.diff_add() == nil and vcs.diff_modified() == nil then
				return ""
			else
				return " "
			end
		end,
		separator_highlight = "GalaxyFgAlt2",
		highlight = "GalaxyFgAlt2",
		-- condition = condition.check_git_workspace,
		-- separator = " ",
	},
}

gls.left[12] = {
	LspTag = {
		provider = function()
			if condition.check_git_workspace() then
				return ""
			else
				return " "
			end
		end,
		highlight = "GalaxyFgAlt2",
	},
}

gls.left[13] = {
	LspClient = {
		provider = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
			if next(clients) == nil then
				return "[No client detected]"
			end
			local clients_str = "["
			local first = true
			local padding = ""
			for _, client in ipairs(clients) do
				if not first then
					padding = " "
				end
				clients_str = clients_str .. padding .. client.name
				if first then
					first = false
				end
			end
			return clients_str .. "]"
		end,
		highlight = "GalaxyFgAlt2",
		-- icon = " ",
		-- separator_highlight = "GalaxyFgAlt2",
		-- separator = " ",
	},
}

gls.left[14] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ✗",
		highlight = "GalaxyRed",
	},
}

gls.left[15] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  !",
		highlight = "GalaxyOrange",
		-- separator_highlight = "GalaxyFgAlt2",
		-- separator = " ",
	},
}

gls.left[16] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ?",
		highlight = "GalaxyBlue",
		-- separator_highlight = "GalaxyFgAlt2",
		-- separator = " ",
	},
}

gls.left[17] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "  i",
		highlight = "GalaxyMagenta",
		-- separator_highlight = "GalaxyFgAlt2",
		-- separator = " ",
	},
}

gls.mid[18] = {
	Macro = {
		provider = noice.api.statusline.mode.get,
		condition = noice.api.status.mode.has(),
		highlight = "GalaxyFgAlt2",
		-- icon = "  ",
	},
}

-- gls.right[1] = {
-- 	CwdTag = {
-- 		provider = function()
-- 			return " CWD "
-- 		end,
-- 		highlight = "GalaxyFgAlt2I",
-- 		icon = " "
-- 	}
-- }

gls.right[1] = {
	VimOpts = {
		provider = function()
			local indent_mode = "TAB"
			if vim.o.expandtab then
				indent_mode = "SHIFT"
			end
			return "[" .. indent_mode .. ": " .. vim.o.shiftwidth .. "]"
		end,
		highlight = "GalaxyFgAlt2",
		-- separator = " ",
		-- separator_highlight = "GalaxyFgAlt2",
	},
}

gls.right[2] = {
	FilePath = {
		provider = function()
			return "[" .. vim.fn.getcwd() .. "]"
		end,
		condition = condition.buffer_not_empty,
		highlight = "GalaxyFgAlt2",
		-- separator = " ",
		-- separator_highlight = "GalaxyFgAlt2",
	},
}

-- gls.right[3] = {
-- 	PaddingRight = {
-- 		provider = function ()
-- 			return " "
-- 		end,
-- 		highlight = "GalaxyFgAlt2",
-- 	}
-- }

gls.mid[1] = {
	Search = {
		provider = noice.api.statusline.search.get,
		condition = noice.api.statusline.search.has(),
		highlight = "GalaxyFgAlt2",
		separator = " ",
		separator_highlight = "GalaxyFgAlt2",
	},
}

gls.mid[3] = {
	Whitespace = {
		provider = "WhiteSpace",
		highlight = "GalaxyFgAlt2",
		-- icon = "⇆ ",
		separator = " ",
		separator_highlight = "GalaxyFgAlt2",
	},
}

gls.short_line_left[1] = {
	ViMode = {
		provider = vi_mode,
		highlight = "GalaxyFg",
	},
}

gls.short_line_left[3] = {
	BufferType = {
		provider = "FileTypeName",
		icon = "  ",
		highlight = "GalaxyFgAlt2",
	},
}
