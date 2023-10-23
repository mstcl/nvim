local gl = require("galaxyline")
local noice = require("noice")
local condition = require("galaxyline.condition")
local fileinfo = require('galaxyline.provider_fileinfo')
local gls = gl.section
local vi_mode = require("utils.misc").statusline_vi_mode

gl.short_line_list = require("user_configs").statusline_short_ft

gls.left[2] = {
    ViMode = {
        provider = require("utils.misc").statusline_vi_mode,
        highlight = "GalaxyFg",
    },
}

gls.left[5] = {
    FileName = {
        provider = function()
            return fileinfo.get_current_file_name("●","✗")
        end,
        condition = condition.buffer_not_empty,
        highlight = "GalaxyFgAlt",
        icon = " ",
    },
}

gls.left[9] = {
    BranchSpace = {
        provider = function()
            return " "
        end,
        highlight = "GalaxyFgAlt2",
    },
}

gls.left[10] = {
    DiffAdd = {
        provider = "DiffAdd",
        icon = " +",
        highlight = "GalaxyGreen",
    },
}

gls.left[11] = {
    DiffModified = {
        provider = "DiffModified",
        icon = " ~",
        highlight = "GalaxyMagenta",
    },
}

gls.left[12] = {
    DiffRemove = {
        provider = "DiffRemove",
        icon = " -",
        highlight = "GalaxyRed",
    },
}

gls.left[13] = {
    GitIcon = {
        provider = function()
            return " ∫"
        end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = "GalaxyFgAlt2",
        highlight = "GalaxyFgAlt2",
    },
}

gls.left[14] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        highlight = "GalaxyFgAlt2",
    },
}

gls.mid[1] = {
    FilePath = {
        provider = function()
            return vim.fn.getcwd()
        end,
        condition = condition.buffer_not_empty,
        highlight = "GalaxyFgAlt2",
    },
}

gls.right[7] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = " ✗",
        highlight = "GalaxyRed",
    },
}

gls.right[8] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = " !",
        highlight = "GalaxyOrange",
    },
}

gls.right[9] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = " ?",
        highlight = "GalaxyYellow",
    },
}

gls.right[10] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = " i",
        highlight = "GalaxyBlue",
    },
}

gls.right[13] = {
    LineInfo = {
        provider = "LineColumn",
        separator = "",
        separator_highlight = "GalaxyFgAlt2",
        highlight = "GalaxyFgAlt2",
        icon = "⊕ ",
    },
}

gls.right[14] = {
    LinePercent = {
        separator = "@",
        separator_highlight = "GalaxyFgAlt2",
        provider = "LinePercent",
        highlight = "GalaxyFgAlt2",
    },
}

gls.right[15] = {
    Macro = {
        provider = function()
            return noice.api.statusline.mode.get()
        end,
        condition = noice.api.status.mode.has(),
        icon = " ❖ ",
        highlight = "GalaxyGreen",
    },
}

gls.right[16] = {
    Whitespace = {
        provider = "WhiteSpace",
        icon = " ⇆ ",
        separator = "",
        separator_highlight = "GalaxyFgAlt2",
        highlight = "GalaxyYellow",
    },
}

gls.right[17] = {
    Search = {
        provider = function()
            return noice.api.statusline.search.get()
        end,
        condition = noice.api.statusline.search.has(),
        highlight = "GalaxyBlue",
    },
}

gls.short_line_left[1] = {
    ViMode = {
        provider = function()
            return vi_mode()
        end,
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
