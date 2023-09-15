local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local wk = require("which-key")
local M = {}

map("n", "Q", "", opts)
map("n", "gQ", "", opts)

map("n", "<Up>", "", opts)
map("n", "<Down>", "", opts)
map("n", "<Left>", "", opts)
map("n", "<Right>", "", opts)

map("n", "<space>", ":", opts)
map("v", "<space>", ":", opts)

wk.register({
	["<C-S>"] = { name = "Split commands" },
})
opts.desc = "Split vertical"
map("n", "<C-S>v", ":vs<CR>", opts)
opts.desc = "Split horizontal"
map("n", "<C-S>h", ":sp<CR>", opts)

-- Normal-mode commands
opts.desc = "Move lines up"
map("n", "<A-j>", ":MoveLine(1)<CR>", opts)
opts.desc = "Move lines down"
map("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
opts.desc = "Move char left"
map("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
opts.desc = "Move char right"
map("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
opts.desc = "Move word forward"
map("n", "<A-f>", ":MoveWord(1)<CR>", opts)
opts.desc = "Move word backward"
map("n", "<A-b>", ":MoveWord(-1)<CR>", opts)

-- Visual-mode commands
opts.desc = "Move lines up"
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
opts.desc = "Move lines down"
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
opts.desc = "Move char left"
vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
opts.desc = "Move char right"
vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)

-- Toggling UI components
opts.desc = "Toggle line number"
map("n", "<C-N>", "<cmd>call SetNumber()<CR>", opts)
opts.desc = "Toggle non-text characters"
map("n", "<C-L>", "<cmd>set list!<CR>", opts)
opts.desc = "Toggle cursorline"
map("n", "<C-J>", "<cmd>set cursorline!<CR>", opts)
opts.desc = "Clear search highlight"
map("n", "<C-P>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>", opts)
opts.desc = "Toggle code minimap"
map("n", "<C-B>", ":lua MiniMap.toggle() <CR>", opts)

opts.desc = "Next search result"
map("n", "n", "nzz", opts)
opts.desc = "Previous search result"
map("n", "N", "Nzz", opts)
opts.desc = "Search matching"
map("n", "*", "*zz", opts)
opts.desc = "Display matching"
map("n", "#", "#zz", opts)
opts.desc = "Search matching"
map("n", "g*", "g*zz", opts)
opts.desc = "Display matching"
map("n", "g#", "g#zz", opts)

opts.desc = "Unindent"
map("x", "<", "<gv", opts)
opts.desc = "Indent"
map("x", ">", ">gv", opts)

opts.desc = "Toggle foldcolumn"
map("n", "<leader>a", ":call FoldColumnToggle()<CR>", opts)
opts.desc = "Open all folds (UFO)"
map("n", "zR", require("ufo").openAllFolds)
opts.desc = "Close all folds (UFO)"
map("n", "zM", require("ufo").closeAllFolds)
opts.desc = "Toggle current fold"
map("n", "<Tab>", "za", opts)

opts.desc = "Show buffer list"
map("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)

opts.desc = "Toggle colorizing hex colors"
map("n", "<leader>c", ":ColorizerToggle<CR>", opts)

wk.register({
	["<leader>d"] = { name = "Diff commands" },
})
opts.desc = "Open diff mode"
map("n", "<leader>dd", "<cmd>DiffviewOpen<CR>", opts)
opts.desc = "Close diff mode"
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", opts)
opts.desc = "Open diff history mode"
map("n", "<leader>df", "<cmd>DiffviewFileHistory<CR>", opts)

wk.register({
	["<leader>e"] = { name = "DAP commands" },
})
opts.desc = "Show DAP commands"
map("n", "-", "<cmd>Telescope dap commands<CR>", opts)
opts.desc = "Show DAP variables"
map("n", "<leader>ev", "<cmd>Telescope dap variables<CR>", opts)
opts.desc = "DAP: continue"
map("n", "<S->", "<cmd>lua require'dap'.continue()<CR>", opts)
opts.desc = "DAP: step over"
map("n", "<PageUp>", "<cmd>lua require'dap'.step_over()<CR>", opts)
opts.desc = "DAP: step into"
map("n", "<PageDown>", "<cmd>lua require'dap'.step_into()<CR>", opts)
opts.desc = "DAP: step out"
map("n", "<End>", "<cmd>lua require'dap'.step_out()<CR>", opts)
opts.desc = "DAP: toggle breakpoint"
map("n", "<Home>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
opts.desc = "DAP: set breakpoint condition"
map("n", "<leader>ec", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
opts.desc = "DAP: set breakpoint with log message"
map("n", "<leader>ef", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

opts.desc = "Show files in current path"
map("n", "<leader>f", "<cmd>Telescope find_files path=%:p:h<CR>", opts)

wk.register({
	["<leader>g"] = { name = "Git commands" },
})
opts.desc = "Show git status"
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts)
opts.desc = "Show git commits (repository)"
map("n", "<leader>gb", "<cmd>Telescope git_bcommits<CR>", opts)
opts.desc = "Show git commits (buffer)"
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
opts.desc = "Toggle gitsigns"
map("n", "<leader>gl", "<cmd>Gitsigns toggle_signs<CR>", opts)
opts.desc = "Preview git hunk"
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", opts)
opts.desc = "Stage hunk"
map("n", "<leader>gS", "<cmd>Gitsigns stage_hunk<CR>", opts)
map("v", "<leader>gS", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

opts.desc = "Show history"
map("n", "<leader>h", "<cmd>Telescope oldfiles<CR>", opts)

opts.desc = "Invert value"
map("n", "<leader>i", require("nvim-toggler").toggle, opts)

opts.desc = "Show last used Telescope picker"
map("n", "<leader>j", "<cmd>Telescope resume<CR>", opts)

opts.desc = "Show document code symbols (float)"
map("n", "<leader>k", "<cmd>Telescope lsp_document_symbols<CR>", opts)

opts.desc = "Toggle completion window (cmp)"
map("n", "<leader>l", ":call ToggleCmp()<CR>", opts)

opts.desc = "Show available keymappings"
map("n", "<leader>m", "<cmd>Telescope keymaps<CR>", opts)

opts.desc = "Show all Telescope pickers"
map("n", "<leader>n", "<cmd>Telescope builtin<CR>", opts)

opts.desc = "Show document code symbols (sidebar)"
map("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)

opts.desc = "Show plugin list"
map("n", "<leader>p", "<cmd>Telescope lazy<CR>", opts)

wk.register({
	["<leader>s"] = { name = "Spell checking" },
})
opts.desc = "Toggle spell checking"
map("n", "<leader>sp", ":setlocal spell! spelllang=en_gb<CR>", opts)
opts.desc = "Show spell suggestion"
map("n", "<leader>sf", "<cmd>Telescope spell_suggests<CR>", opts)

opts.desc = "Show recent files"
map("n", "<leader>t", "<cmd>Telescope frecency<CR>", opts)

opts.desc = "Show undo tree"
map("n", "<leader>u", "<cmd>Telescope undo<CR>", opts)

wk.register({
	["<leader>v"] = { name = "Treesitter toggles" },
})
opts.desc = "Toggle rainbow parentheses"
map("n", "<leader>vr", "<cmd>TSBufToggle rainbow<CR>", opts)
opts.desc = "Toggle syntax highlighting with TS"
map("n", "<leader>vh", "<cmd>TSBufToggle highlight<CR>", opts)

opts.desc = "Trip whitespace in file"
map("n", "<leader>w", ":call TrimWhiteSpace()<CR>", opts)

opts.desc = "Show workspace diagnostic (trouble)"
map("n", "<leader>x", "<cmd>Trouble workspace_diagnostics<CR>", opts)

opts.desc = "Browse files in current directory"
map("n", "<leader>y", "<cmd>Telescope file_browser path=%:p:h<CR>", opts)

opts.desc = "Enter Zen mode"
map("n", "<leader>z", "<cmd>ZenMode<CR>", opts)

opts.desc = "Live grep workspace"
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", opts)

opts.desc = "Live grep buffer"
map("n", "<leader>\\", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)

opts.desc = "Go to next git hunk"
map("n", "]p", "<cmd>Gitsigns next_hunk<CR>", opts)
opts.desc = "Go to previous git hunk"
map("n", "[p", "<cmd>Gitsigns prev_hunk<CR>", opts)

opts.desc = "Go to previous buffer"
map("n", "<Left>", "<cmd>BufferPrevious<CR>", opts)
opts.desc = "Go to next buffer"
map("n", "<Right>", "<cmd>BufferNext<CR>", opts)

opts.desc = "Move to previous buffer"
map("n", "<A-<>", "<cmd>BufferMovePrevious<CR>", opts)
opts.desc = "Move to next buffer"
map("n", "<A->>", "<cmd>BufferMoveNext<CR>", opts)
opts.desc = "Go to buffer 1"
map("n", "<A-1>", "<cmd>BufferGoto 1<CR>", opts)
opts.desc = "Go to buffer 2"
map("n", "<A-2>", "<cmd>BufferGoto 2<CR>", opts)
opts.desc = "Go to buffer 3"
map("n", "<A-3>", "<cmd>BufferGoto 3<CR>", opts)
opts.desc = "Go to buffer 4"
map("n", "<A-4>", "<cmd>BufferGoto 4<CR>", opts)
opts.desc = "Go to buffer 5"
map("n", "<A-5>", "<cmd>BufferGoto 5<CR>", opts)
opts.desc = "Go to buffer 6"
map("n", "<A-6>", "<cmd>BufferGoto 6<CR>", opts)
opts.desc = "Go to buffer 7"
map("n", "<A-7>", "<cmd>BufferGoto 7<CR>", opts)
opts.desc = "Go to buffer 8"
map("n", "<A-8>", "<cmd>BufferGoto 8<CR>", opts)
opts.desc = "Go to last buffer"
map("n", "<A-9>", "<cmd>BufferLast<CR>", opts)
opts.desc = "Pin buffer"
map("n", "<A-t>", "<cmd>BufferPin<CR>", opts)
opts.desc = "Close buffer"
map("n", "<A-c>", "<cmd>BufferClose<CR>", opts)
opts.desc = "Pick buffer"
map("n", "<A-u>", "<cmd>BufferPick<CR>", opts)

opts.desc = "Dismiss notification popup"
map("n", "<A-BS>", ":Noice dismiss<CR>", opts)

function M.lsp_keymaps(client, bufnr)
	local function bmap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	wk.register({
		["<leader>q"] = { name = "More LSP commands" },
	})
	if client.server_capabilities.codeActionProvider then
		opts.desc = "Show referencces"
		map("n", "<leader>qr", "<cmd>Glance references<CR>", opts)
		opts.desc = "Show definition"
		map("n", "<leader>qd", "<cmd>Glance definitions<CR>", opts)
		opts.desc = "Show implementations"
		map("n", "<leader>qi", "<cmd>Glance implementations<CR>", opts)
		opts.desc = "Show type definitions"
		map("n", "<leader>qt", "<cmd>Glance type_definitions<CR>", opts)
	end
	if client.server_capabilities.codeActionProvider then
		opts.desc = "Show code actions"
		map({ "n", "v" }, "<leader>qc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	end
	if client.server_capabilities.hoverProvider then
		opts.desc = "Documentation"
		bmap("n", "<C-K>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	end
	if client.server_capabilities.definitionProvider then
		opts.desc = "Buffer declaration"
		bmap("n", "<Leader>qq", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	end
	if client.server_capabilities.documentFormattingProvider then
		opts.desc = "Format buffer"
		bmap("n", "<Leader><space>", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
	end
	if client.server_capabilities.renameProvider then
		opts.desc = "Rename object"
		bmap("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end
	opts.desc = "Next diagnostic"
	bmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ wrap = false, float = false })<CR>", opts)
	opts.desc = "Previous diagnostic"
	bmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ wrap = false, float = false })<CR>", opts)
end

return M
