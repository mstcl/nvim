-- Custom user commands

-- Yank latest commit hash
-- While we can use Neogit for this it's a bit slow
-- <leader>c -> YY whereas this is a single command
vim.api.nvim_create_user_command("YankCommitHash", function()
	local hash = vim.fn.system("git rev-parse HEAD")
	vim.fn.setreg('"', hash)
	vim.fn.setreg("+", hash)
	vim.notify("Copied commit hash to clipboard", vim.log.levels.INFO)
end, {})

-- Clean register
vim.api.nvim_create_user_command(
	"CleanReg",
	"for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor",
	{ bang = false }
)

-- Recover good old LspInfo
vim.api.nvim_create_user_command(
	"LspInfo",
	function() vim.cmd("checkhealth vim.lsp") end,
	{}
)

-- Replaces the old explorer with Oil
vim.api.nvim_create_user_command("E", "Oil", {})
vim.api.nvim_create_user_command("Ex", "Oil", {})
vim.api.nvim_create_user_command("Explore", "Oil", {})

-- Clear screen with extra stuff
vim.api.nvim_create_user_command("Clear", function()
	vim.cmd("nohlsearch")
	vim.cmd("diffupdate")
	vim.cmd("syntax sync fromstart")
	vim.cmd("normal! <C-l>")
end, {})

local function split_new_terminal()
	if vim.api.nvim_win_get_width(0) >= 350 then
		vim.cmd("vsplit | winc L | vertical resize 150 | term")
	else
		vim.cmd("split | winc J | resize 10 | term")
	end
end

local function split_existing_terminal()
	if vim.api.nvim_win_get_width(0) >= 350 then
		vim.cmd("vert sb " .. vim.t.t_buf .. "| winc L | vertical resize 150")
	else
		vim.cmd("sb" .. vim.t.t_buf .. "| winc J | resize 10")
	end
end

local function open_terminal()
	if vim.fn.bufexists(vim.t.t_buf) ~= 1 then
		split_new_terminal()
		vim.t.t_win_id = vim.fn.win_getid()
		vim.t.t_buf = vim.fn.bufnr("%")
	elseif vim.fn.win_gotoid(vim.t.t_win_id) ~= 1 then
		split_existing_terminal()
		vim.t.t_win_id = vim.fn.win_getid()
	end
end

local function hide_terminal()
	if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then vim.cmd("hide") end
end

-- Unified Toggle command with extensible registry for plugin toggles
_G.toggle_registry = _G.toggle_registry or {}

--- Register a toggle handler for the unified Toggle command
---@param name string The toggle name (what users type)
---@param aliases string[] Optional aliases for the toggle
---@param handler function The function to call when toggled
_G.register_toggle = function(name, aliases, handler)
	_G.toggle_registry[name:lower()] = handler
	if aliases then
		for _, alias in ipairs(aliases) do
			_G.toggle_registry[alias:lower()] = handler
		end
	end
end

vim.api.nvim_create_user_command("Toggle", function(opts)
	local arg = opts.args:lower()

	-- Check plugin registry first
	if _G.toggle_registry[arg] then
		_G.toggle_registry[arg]()
		return
	end

	-- Built-in toggles
	if arg == "relative_number" or arg == "relativenumber" or arg == "rnu" then
		vim.opt_local.relativenumber = not vim.wo.relativenumber
		vim.notify(
			"Relative number " .. (vim.wo.relativenumber and "enabled" or "disabled"),
			vim.log.levels.INFO
		)
	elseif arg == "scrolloff" or arg == "so" then
		vim.opt_local.scrolloff = vim.wo.scrolloff == 999 and 0 or 999
		vim.notify("Scrolloff set to " .. vim.wo.scrolloff, vim.log.levels.INFO)
	elseif arg == "tabline" or arg == "tabs" then
		vim.o.showtabline = vim.o.showtabline == 1 and 0 or 1
		vim.notify(
			"Tabline " .. (vim.o.showtabline == 1 and "enabled" or "disabled"),
			vim.log.levels.INFO
		)
	elseif arg == "spell" or arg == "spelling" then
		vim.opt_local.spell = not vim.wo.spell
		vim.notify(
			"Spell check " .. (vim.wo.spell and "enabled" or "disabled"),
			vim.log.levels.INFO
		)
	elseif arg == "list" or arg == "whitespace" or arg == "nontext" then
		vim.opt_local.list = not vim.wo.list
		vim.notify(
			"List chars " .. (vim.wo.list and "enabled" or "disabled"),
			vim.log.levels.INFO
		)
	elseif arg == "cursorline" or arg == "cul" then
		if vim.wo.cursorlineopt == "number" then
			vim.opt_local.cursorlineopt = "both"
			vim.notify("Cursor line enabled (both)", vim.log.levels.INFO)
		else
			vim.opt_local.cursorlineopt = "number"
			vim.notify("Cursor line set to number only", vim.log.levels.INFO)
		end
	elseif arg == "colorcolumn" or arg == "cc" or arg == "col" then
		if vim.wo.colorcolumn ~= "" then
			vim.opt_local.colorcolumn = ""
			vim.notify("Color column disabled", vim.log.levels.INFO)
		else
			vim.opt_local.colorcolumn = "80"
			vim.notify("Color column set to 80", vim.log.levels.INFO)
		end
	elseif arg == "terminal" or arg == "term" or arg == "t" then
		-- Toggle a quake terminal that always changes to the project's working
		-- directory You also have a separate quake per tabpage, so you can work in
		-- multiple projects/working dirs without fussing about with cd
		if vim.fn.win_gotoid(vim.t.t_win_id) == 1 then
			hide_terminal()
		else
			open_terminal()
		end
	else
		-- Build available options list dynamically
		local builtins = {
			"relative_number",
			"scrolloff",
			"tabline",
			"spell",
			"list",
			"cursorline",
			"colorcolumn",
			"terminal",
		}
		local plugins = vim.tbl_keys(_G.toggle_registry)
		vim.notify(
			"Unknown toggle: "
				.. opts.args
				.. ".\nBuilt-in: "
				.. table.concat(builtins, ", ")
				.. (
					#plugins > 0
						and ("\nPlugins: " .. table.concat(plugins, ", "))
					or ""
				),
			vim.log.levels.ERROR
		)
	end
end, {
	nargs = 1,
	complete = function()
		local builtins = {
			"relative_number",
			"scrolloff",
			"tabline",
			"spell",
			"list",
			"cursorline",
			"colorcolumn",
			"terminal",
		}
		local plugins = vim.tbl_keys(_G.toggle_registry)
		return vim.list_extend(builtins, plugins)
	end,
})

-- Unified Mode command with extensible registry
_G.mode_registry = _G.mode_registry or {}

--- Register a mode handler for the unified Mode command
---@param name string The mode name (what users type)
---@param aliases string[] Optional aliases for the mode
---@param handler function The function to call when entering the mode
_G.register_mode = function(name, aliases, handler)
	_G.mode_registry[name:lower()] = handler
	if aliases then
		for _, alias in ipairs(aliases) do
			_G.mode_registry[alias:lower()] = handler
		end
	end
end

-- Minimal mode - hides UI elements
local function minimal_mode()
	vim.b.minianimate_disable = true
	vim.b.miniindentscope_disable = true
	vim.b.indent_guide = false
	vim.opt_local.list = false
	vim.opt_local.foldcolumn = "0"
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.statuscolumn = ""
	vim.opt_local.colorcolumn = ""
	vim.opt_local.signcolumn = "no"
	vim.notify("Minimal mode enabled", vim.log.levels.INFO)
end

-- Big file mode - performance optimizations for large files
local function bigfile_mode()
	---@diagnostic disable-next-line: unnecessary-if
	-- disable matchparen
	if vim.fn.exists(":DoMatchParen") ~= 2 then return end
	vim.cmd("NoMatchParen")

	-- defer disable lsp
	_G.augroup("bigfile_deferred", {
		"LspAttach",
		{
			desc = "detach client for big files",
			callback = function(args)
				local bufnr = args.buf
				vim.schedule(
					function() vim.lsp.buf_detach_client(bufnr, args.data.client_id) end
				)
			end,
		},
	}, {
		"BufReadPost",
		{
			desc = "deferred actions for big files",
			callback = function()
				vim.cmd("syntax clear")
				vim.opt_local.syntax = "OFF"
				vim.opt_local.filetype = ""
			end,
		},
	})

	-- disable swap
	vim.opt_local.swapfile = false

	-- turn off expr fold
	vim.opt_local.foldmethod = "manual"

	-- disable undotree
	vim.opt_local.undolevels = -1
	vim.opt_local.undoreload = 0

	-- turn on minimal mode
	minimal_mode()
	vim.notify("Big file mode enabled", vim.log.levels.INFO)
end

-- Copy mode - clean UI for copying text
local function copy_mode()
	-- Get the number of the current buffer.
	local current_buf = vim.api.nvim_get_current_buf()

	-- Open a new tab and create a new window within it.
	vim.cmd("tabnew")
	local new_win = vim.api.nvim_get_current_win()

	-- Load the original buffer into the new window.
	vim.api.nvim_win_set_buf(new_win, current_buf)

	vim.g.pastemode = true
	minimal_mode()

	vim.keymap.set(
		"n",
		"q",
		function() vim.cmd("tabclose") end,
		{ buffer = true, desc = "quit copy mode and return to previous tab" }
	)
	vim.notify("Copy mode enabled (press 'q' to quit)", vim.log.levels.INFO)
end

-- Pair programming mode; turns on useful features to make sure yuo pair
-- buddy don't get lost
local function pair_mode_enter()
	vim.opt.cursorlineopt = "both"
	vim.cmd("NvimTreeOpen")
	vim.cmd("wincmd p")
	vim.g.pair_mode_active = true
	vim.notify("Pair mode enabled", vim.log.levels.INFO)
end

local function pair_mode_leave()
	vim.opt.cursorlineopt = "number"
	vim.cmd("NvimTreeClose")
	vim.g.pair_mode_active = false
	vim.notify("Pair mode disabled", vim.log.levels.INFO)
end

local function pair_mode_toggle()
	if vim.g.pair_mode_active then
		pair_mode_leave()
	else
		pair_mode_enter()
	end
end

-- Unified mode command
vim.api.nvim_create_user_command("Mode", function(opts)
	local args = vim.split(opts.args, " ", { plain = true, trimempty = true })
	local cmd = args[1] and args[1]:lower() or ""
	local subcmd = args[2] and args[2]:lower() or ""

	-- Check plugin registry first
	if _G.mode_registry[cmd] then
		_G.mode_registry[cmd](subcmd)
		return
	end

	-- Built-in modes
	if cmd == "minimal" or cmd == "min" then
		minimal_mode()
	elseif cmd == "bigfile" or cmd == "big" or cmd == "bf" then
		bigfile_mode()
	elseif cmd == "copy" or cmd == "cp" then
		copy_mode()
	elseif cmd == "pair" then
		if subcmd == "enter" or subcmd == "on" or subcmd == "1" then
			pair_mode_enter()
		elseif subcmd == "leave" or subcmd == "off" or subcmd == "0" then
			pair_mode_leave()
		elseif subcmd == "toggle" or subcmd == "" then
			pair_mode_toggle()
		else
			vim.notify(
				"Invalid pair mode argument. Use: enter | leave | toggle",
				vim.log.levels.ERROR
			)
		end
	else
		local builtins = { "minimal", "bigfile", "copy", "pair" }
		local plugins = vim.tbl_keys(_G.mode_registry)
		vim.notify(
			"Unknown mode: "
				.. cmd
				.. ".\nBuilt-in: "
				.. table.concat(builtins, ", ")
				.. (
					#plugins > 0
						and ("\nPlugins: " .. table.concat(plugins, ", "))
					or ""
				),
			vim.log.levels.ERROR
		)
	end
end, {
	nargs = "*",
	complete = function(_arglead, cmdline)
		local args = vim.split(cmdline, " ", { plain = true, trimempty = true })
		local builtins = { "minimal", "bigfile", "copy", "pair" }
		local plugins = vim.tbl_keys(_G.mode_registry)
		local all = vim.list_extend(builtins, plugins)

		if #args <= 2 then
			return all
		elseif args[2] == "pair" then
			return { "enter", "leave", "toggle" }
		end
		return {}
	end,
})

-- Unified LSP symbols command
vim.api.nvim_create_user_command("Symbols", function(opts)
	local scope = opts.args:lower()

	if scope == "workspace" or scope == "ws" or scope == "w" then
		vim.lsp.buf.workspace_symbol()
	elseif scope == "document" or scope == "doc" or scope == "d" or scope == "" then
		vim.lsp.buf.document_symbol()
	else
		vim.notify(
			"Unknown scope: "
				.. opts.args
				.. ". Available: workspace (ws), document (doc)",
			vim.log.levels.ERROR
		)
	end
end, {
	nargs = "?",
	complete = function() return { "workspace", "document" } end,
})

-- Unified diagnostics command
vim.api.nvim_create_user_command("Diagnostics", function(opts)
	local scope = opts.args:lower()

	if scope == "workspace" or scope == "ws" or scope == "w" then
		vim.diagnostic.setqflist()
	elseif scope == "document" or scope == "doc" or scope == "d" or scope == "" then
		vim.diagnostic.setloclist()
	else
		vim.notify(
			"Unknown scope: "
				.. opts.args
				.. ". Available: workspace (ws), document (doc)",
			vim.log.levels.ERROR
		)
	end
end, {
	nargs = "?",
	complete = function() return { "workspace", "document" } end,
})

-- Unified syntax highlighting command
vim.api.nvim_create_user_command("Syntax", function(opts)
	local args = vim.split(opts.args, " ", { plain = true, trimempty = true })
	local target = args[1] and args[1]:lower() or ""
	local action = args[2] and args[2]:lower() or ""

	local function set_treesitter(enable)
		if enable then
			vim.treesitter.start()
			vim.notify("Treesitter enabled", vim.log.levels.INFO)
		else
			vim.treesitter.stop()
			vim.notify("Treesitter disabled", vim.log.levels.INFO)
		end
	end

	local function set_semantic(enable)
		vim.lsp.semantic_tokens.enable(enable, { bufnr = 0 })
		vim.notify(
			"Semantic tokens " .. (enable and "enabled" or "disabled"),
			vim.log.levels.INFO
		)
	end

	if target == "treesitter" or target == "ts" then
		if action == "enable" or action == "on" or action == "1" or action == "" then
			set_treesitter(true)
		elseif action == "disable" or action == "off" or action == "0" then
			set_treesitter(false)
		elseif action == "toggle" then
			-- Check if treesitter is active by looking for highlighter
			local has_ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
				~= nil
			set_treesitter(not has_ts)
		else
			vim.notify(
				"Invalid action. Use: enable | disable | toggle",
				vim.log.levels.ERROR
			)
		end
	elseif target == "semantic" or target == "sem" or target == "tokens" then
		if action == "enable" or action == "on" or action == "1" or action == "" then
			set_semantic(true)
		elseif action == "disable" or action == "off" or action == "0" then
			set_semantic(false)
		elseif action == "toggle" then
			-- Check if semantic tokens are enabled
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local enabled = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.semanticTokensProvider then
					enabled = true
					break
				end
			end
			set_semantic(not enabled)
		else
			vim.notify(
				"Invalid action. Use: enable | disable | toggle",
				vim.log.levels.ERROR
			)
		end
	elseif target == "all" or target == "" then
		if action == "enable" or action == "on" or action == "1" or action == "" then
			vim.treesitter.start()
			vim.lsp.semantic_tokens.enable(true, { bufnr = 0 })
			vim.notify("All syntax highlighting enabled", vim.log.levels.INFO)
		elseif action == "disable" or action == "off" or action == "0" then
			vim.treesitter.stop()
			vim.lsp.semantic_tokens.enable(false, { bufnr = 0 })
			vim.notify("All syntax highlighting disabled", vim.log.levels.INFO)
		else
			vim.notify("Invalid action. Use: enable | disable", vim.log.levels.ERROR)
		end
	else
		vim.notify(
			"Unknown syntax target: "
				.. target
				.. ". Available: treesitter, semantic, all",
			vim.log.levels.ERROR
		)
	end
end, {
	nargs = "*",
	complete = function(_arglead, cmdline)
		local args = vim.split(cmdline, " ", { plain = true, trimempty = true })
		local targets = { "treesitter", "semantic", "all" }
		local actions = { "enable", "disable", "toggle" }

		if #args <= 2 then
			return targets
		elseif #args == 3 then
			return actions
		end
		return {}
	end,
})

-- Unified Pack command
-- Usage: Pack add <url1>, <url2> | Pack del <plugin1>, <plugin2> | Pack update
vim.api.nvim_create_user_command("Pack", function(opts)
	local args = vim.split(opts.args, " ", { plain = true, trimempty = true })
	local cmd = args[1] and args[1]:lower() or ""
	local rest = table.concat(args, " ", 2)

	if cmd == "update" or cmd == "up" then
		if rest == "" then
			vim.pack.update()
		else
			-- Parse comma-separated list of plugin names/URLs to update
			local plugins = {}
			for name in rest:gmatch("([^,]+)") do
				name = vim.trim(name)
				if name ~= "" then table.insert(plugins, name) end
			end
			if #plugins == 0 then
				vim.notify("No valid plugin names provided", vim.log.levels.ERROR)
				return
			end
			vim.pack.update(plugins)
			vim.notify("Updated " .. #plugins .. " plugin(s)", vim.log.levels.INFO)
		end
	elseif cmd == "add" then
		if rest == "" then
			vim.notify("Usage: Pack add <url1>, <url2>, ...", vim.log.levels.ERROR)
			return
		end
		-- Parse comma-separated list of URLs
		local plugins = {}
		for url in rest:gmatch("([^,]+)") do
			url = vim.trim(url)
			if url ~= "" then table.insert(plugins, url) end
		end
		if #plugins == 0 then
			vim.notify("No valid plugin URLs provided", vim.log.levels.ERROR)
			return
		end
		vim.pack.add(plugins)
		vim.notify("Added " .. #plugins .. " plugin(s)", vim.log.levels.INFO)
	elseif cmd == "del" or cmd == "delete" or cmd == "rm" or cmd == "remove" then
		if rest == "" then
			vim.notify(
				"Usage: Pack del <plugin1>, <plugin2>, ...",
				vim.log.levels.ERROR
			)
			return
		end
		-- Parse comma-separated list of plugin names/URLs
		local plugins = {}
		for name in rest:gmatch("([^,]+)") do
			name = vim.trim(name)
			if name ~= "" then table.insert(plugins, name) end
		end
		if #plugins == 0 then
			vim.notify("No valid plugin names provided", vim.log.levels.ERROR)
			return
		end
		vim.pack.del(plugins)
		vim.notify("Removed " .. #plugins .. " plugin(s)", vim.log.levels.INFO)
	else
		vim.notify(
			"Unknown pack command: " .. cmd .. ". Available: add, del, update",
			vim.log.levels.ERROR
		)
	end
end, {
	nargs = "*",
	complete = function(_arglead, cmdline)
		local args = vim.split(cmdline, " ", { plain = true, trimempty = true })
		if #args <= 2 then return { "add", "del", "update" } end
		return {}
	end,
})
