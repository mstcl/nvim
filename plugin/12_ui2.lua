-- Test the new experimental UI2
_G.helpers.now(function()
	if vim.version.ge(vim.version(), { 0, 12, 0 }) then
		require("vim._core.ui2").enable({
			enable = true,
			msg = {
				targets = {
					[""] = "msg",
					empty = "msg",
					bufwrite = "msg",
					echo = "msg",
					echomsg = "msg",
					shell_ret = "msg",
					undo = "msg",
					wmsg = "msg",
					completion = "msg",
					confirm = "dialog",
					confirm_sub = "dialog",
					echoerr = "msg",
					emsg = "msg",
					list_cmd = "pager",
					lua_error = "msg",
					lua_print = "msg",
					progress = "msg",
					quickfix = "msg",
					rpc_error = "msg",
					search_cmd = "msg",
					search_count = "msg",
					shell_cmd = "msg",
					shell_err = "msg",
					shell_out = "msg",
					typed_cmd = "msg",
					verbose = "pager",
					wildlist = "msg",
				},
				dialog = { height = 0.5 },
				msg = { height = 0.5 },
				messagesopt = { maxheight = 0.5, timeout = 2000 },
				pager = { height = 0.8 },
			},
		})
	end
end)
