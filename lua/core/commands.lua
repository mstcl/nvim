local create = vim.api.nvim_create_user_command
create("WipeReg", "for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor", { bang = false })
create("E", "Oil", {})
create("Msg", "lua require('mini.notify').show_history()", {})
