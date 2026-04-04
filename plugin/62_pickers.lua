-- Custom fzf-lua pickers

local context_picker = function()
	-- Getter functions for context items
	local function get_prefix() return "@" end

	local function get_buffers()
		local prefix = get_prefix()
		local bufs = {}
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
				local name = vim.api.nvim_buf_get_name(buf)
				if name ~= "" then
					table.insert(bufs, prefix .. vim.fn.fnamemodify(name, ":."))
				end
			end
		end
		return table.concat(bufs, "\n")
	end

	local function get_file()
		local file = vim.fn.expand("%:.")
		if file == "" then return nil end
		return get_prefix() .. file
	end

	local function get_file_absolute()
		local file = vim.fn.expand("%:p")
		if file == "" then return nil end
		return file
	end

	local function get_selection_range()
		local mode = vim.fn.mode()
		if mode ~= "v" and mode ~= "V" and mode ~= "\22" then return nil end

		local start_pos = vim.fn.getpos("v")
		local end_pos = vim.fn.getpos(".")
		local start_row, start_col = start_pos[2], start_pos[3]
		local end_row, end_col = end_pos[2], end_pos[3]

		if start_row > end_row or (start_row == end_row and start_col > end_col) then
			start_row, end_row = end_row, start_row
			start_col, end_col = end_col, start_col
		end

		return {
			mode = mode,
			start_row = start_row,
			start_col = start_col,
			end_row = end_row,
			end_col = end_col,
		}
	end

	local function format_position(file, range)
		if range then
			if range.start_row == range.end_row then
				return string.format(
					"%s:%d:%d-%d",
					file,
					range.start_row,
					range.start_col,
					range.end_col
				)
			else
				return string.format(
					"%s:%d-%d",
					file,
					range.start_row,
					range.end_row
				)
			end
		end
		local cursor = vim.api.nvim_win_get_cursor(0)
		return string.format("%s:%d", file, cursor[1])
	end

	local function get_position()
		local file = get_file()
		if not file then return nil end
		return format_position(file, get_selection_range())
	end

	local function get_position_absolute()
		local file = get_file_absolute()
		if not file then return nil end
		return format_position(file, get_selection_range())
	end

	local function get_line() return vim.api.nvim_get_current_line() end

	local function get_selection()
		local range = get_selection_range()
		if not range then return nil end

		local lines =
			vim.api.nvim_buf_get_lines(0, range.start_row - 1, range.end_row, false)
		if #lines == 0 then return nil end

		if range.mode == "V" then
			return table.concat(lines, "\n")
		elseif range.mode == "\22" then
			for i, line in ipairs(lines) do
				lines[i] = line:sub(range.start_col, range.end_col)
			end
			return table.concat(lines, "\n")
		else
			if #lines == 1 then
				lines[1] = lines[1]:sub(range.start_col, range.end_col)
			else
				lines[1] = lines[1]:sub(range.start_col)
				lines[#lines] = lines[#lines]:sub(1, range.end_col)
			end
			return table.concat(lines, "\n")
		end
	end

	local function format_diagnostic(d, bufnr)
		local severity = vim.diagnostic.severity[d.severity] or "UNKNOWN"
		local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":.")
		local end_line = d.end_lnum and d.end_lnum + 1 or d.lnum + 1
		return string.format(
			"[%s] %s @%s:%d-%d",
			severity,
			d.message,
			file,
			d.lnum + 1,
			end_line
		)
	end

	local function get_diagnostics()
		local buf = vim.api.nvim_get_current_buf()
		local diags = vim.diagnostic.get(buf)
		if #diags == 0 then return nil end
		local lines = {}
		for _, d in ipairs(diags) do
			table.insert(lines, format_diagnostic(d, buf))
		end
		return table.concat(lines, "\n")
	end

	local function get_diagnostics_all()
		local all_diags = vim.diagnostic.get()
		if #all_diags == 0 then return nil end

		local diags_by_buf = {}
		for _, d in ipairs(all_diags) do
			local bufnr = d.bufnr
			if not diags_by_buf[bufnr] then diags_by_buf[bufnr] = {} end
			table.insert(diags_by_buf[bufnr], d)
		end

		local lines = {}
		for bufnr, diags in pairs(diags_by_buf) do
			for _, d in ipairs(diags) do
				table.insert(lines, format_diagnostic(d, bufnr))
			end
		end
		return table.concat(lines, "\n")
	end

	-- Build context items
	local items = {}
	local getters = {
		{ name = "buffers", desc = "List of all open buffers", get = get_buffers },
		{ name = "file", desc = "Current file path (relative)", get = get_file },
		{
			name = "file_absolute",
			desc = "Current file path (absolute)",
			get = get_file_absolute,
		},
		{
			name = "position",
			desc = "Cursor position (relative)",
			get = get_position,
		},
		{
			name = "position_absolute",
			desc = "Cursor position (absolute)",
			get = get_position_absolute,
		},
		{ name = "line", desc = "Current line content", get = get_line },
		{ name = "selection", desc = "Visual selection", get = get_selection },
		{
			name = "diagnostics",
			desc = "Diagnostics for current buffer",
			get = get_diagnostics,
		},
		{
			name = "diagnostics_all",
			desc = "All workspace diagnostics",
			get = get_diagnostics_all,
		},
	}

	for _, ctx in ipairs(getters) do
		local value = ctx.get()
		if value and value ~= "" then
			table.insert(items, {
				name = ctx.name,
				desc = ctx.desc,
				value = value,
			})
		end
	end

	-- Build display and lookup
	local display = {}
	local lookup = {}

	for _, item in ipairs(items) do
		local preview_text = item.value:gsub("\n", " ")
		local line = string.format("%-16s %s", item.name, preview_text)
		table.insert(display, line)
		lookup[line] = item
	end

	-- picker
	require("fzf-lua").fzf_exec(display, {
		winopts = {
			title = " Context ",
			title_pos = "center",
			width = 0.35,
			height = 0.21,
		},
		actions = {
			["default"] = function(selected)
				if selected and selected[1] then
					local item = lookup[selected[1]]
					if item.value then
						vim.fn.setreg("+", item.value)
						vim.notify(
							"Copied to clipboard: " .. item.name,
							vim.log.levels.INFO
						)
					end
				end
			end,
		},
	})
end

local zoxide_picker = function()
	require("fzf-lua").fzf_exec("zoxide query -l", {
		winopts = {
			title = " Zoxide ",
			title_pos = "center",
			preview = {
				horizontal = "right:30%",
			},
			width = 0.5,
		},
		fzf_opts = { ["--no-multi"] = "" },
		preview = {
			fn = function(args)
				return string.format(
					"eza --color=always --group-directories-first -TDa --git --git-ignore -L 1 %s | head -200",
					vim.fn.shellescape(args[1])
				)
			end,
			type = "cmd",
		},
		actions = {
			["ctrl-o"] = {
				fn = function(selected) require("oil").open(selected[1]) end,
				desc = "open-oil",
				header = "open oil in selected directory",
			},
			["ctrl-s"] = {
				fn = function(selected)
					require("fzf-lua").files({ cwd = selected[1] })
				end,
				desc = "search-files",
				header = "search files in selected directory",
			},
			["default"] = function(selected) vim.cmd("cd " .. selected[1]) end,
		},
	})
end

vim.keymap.set(
	"n",
	"<leader>z",
	function() zoxide_picker() end,
	{ desc = "Zoxide", noremap = false, silent = true }
)

vim.keymap.set(
	{ "n", "v" },
	"<leader>x",
	function() context_picker() end,
	{ desc = "Context picker", noremap = false, silent = true }
)
