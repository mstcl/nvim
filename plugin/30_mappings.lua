-- Custom user mappings
local keymap_set = vim.keymap.set

_G.helpers.later(function()
	-- Alias : to <space>
	-- Normally I still use : a lot out of habit but sometimes if your pinky is
	-- fatigued having this is accessible is great
	keymap_set(
		{ "n", "v" },
		"<space>",
		":",
		{ remap = false, desc = "Command", silent = true }
	)

	-- <C-L> on steroids
	keymap_set("n", "<leader>l", function() vim.cmd("Clear") end, {
		desc = "Clear",
		noremap = false,
		silent = true,
	})

	-- Searching with nicer focus so you can actually follow it
	keymap_set("n", "n", "nzz", { desc = "Search previous result" })
	keymap_set("n", "N", "Nzz", { desc = "Search next result" })
	keymap_set("n", "*", "*zz", { desc = "Search matching forward (word)" })
	keymap_set("n", "#", "#zz", { desc = "Search matching backward (word)" })
	keymap_set("n", "g*", "g*zz", { desc = "Search matching backward" })
	keymap_set("n", "g#", "g#zz", { desc = "Search matching backward" })

	-- Quicker indenting (can hit multiple > or < in succession)
	keymap_set("x", "<", "<gv", { desc = "Unindent" })
	keymap_set("x", ">", ">gv", { desc = "Indent" })

	-- Quicker fold toggle
	keymap_set("n", "<S-Tab>", "za", { desc = "Fold" })

	-- Enhanced tab mappings
	keymap_set(
		"n",
		"<C-W>N",
		function() vim.cmd("tabnew") end,
		{ desc = "Open new tab" }
	)
	keymap_set(
		"n",
		"<C-W>C",
		function() vim.cmd("tabclose") end,
		{ desc = "Close current tab" }
	)

	keymap_set(
		"n",
		"<C-Space>",
		function() vim.cmd("Toggle terminal") end,
		{ desc = "Quake terminal", noremap = false, silent = true }
	)
	keymap_set(
		"t",
		"<C-Space>",
		[[<C-Bslash><C-n>:Toggle terminal<CR>]],
		{ silent = true }
	)

	-- Zoom window
	-- (different to <C-W>| in that it's toggleable and the window is floating so
	-- doesn't ruin your splits)
	keymap_set(
		{ "n", "v" },
		"<C-W>Z",
		require("mini.misc").zoom,
		{ desc = "Zoom window", remap = false, silent = true }
	)

	-- Yank latest commit hash
	-- Used relatively often so it's handy to have a keymap
	keymap_set(
		"n",
		"<leader>x",
		function() vim.cmd("YankCommitHash") end,
		{ desc = "Hash", noremap = false, silent = true }
	)

	-- Go to special files
	local function open_project_file(names)
		local file = vim.fs.find(names, {
			upward = true,
			path = vim.api.nvim_buf_get_name(0),
		})[1]

		if file then vim.cmd.edit(vim.fn.fnameescape(file)) end
	end

	keymap_set(
		"n",
		"<leader>qp",
		function() open_project_file("pyproject.toml") end,
		{ desc = "pyproject.toml" }
	)

	keymap_set(
		"n",
		"<leader>qg",
		function() open_project_file(".gitignore") end,
		{ desc = ".gitignore" }
	)

	keymap_set(
		"n",
		"<leader>qr",
		function() open_project_file("README.md") end,
		{ desc = "README.md" }
	)

	keymap_set(
		"n",
		"<leader>qd",
		function() open_project_file({ "Dockerfile", "Containerfile" }) end,
		{ desc = "Dockerfile" }
	)
end)
