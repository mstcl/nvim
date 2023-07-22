local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "Q", "", opts)
map("n", "gQ", "", opts)

map("n", "<Up>", "", opts)
map("n", "<Down>", "", opts)
map("n", "<Left>", "", opts)
map("n", "<Right>", "", opts)

map("n", "<space>", ":", opts)
map("v", "<space>", ":", opts)

opts.desc = "Split vertical"
map("n", "<C-S>v", ":vs<CR>", opts)
opts.desc = "Split horizontal"
map("n", "<C-S>h", ":sp<CR>", opts)

--[[ map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
map("n", "<A-j>", ":<c-u>execute 'move +'. v:count1<CR>", opts)
map("n", "<A-k>", ":<c-u>execute 'move -1-'. v:count1<CR>", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts) ]]

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
map("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
opts.desc = "Move word backward"
map("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)

-- Visual-mode commands
opts.desc = "Move lines up"
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
opts.desc = "Move lines down"
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
opts.desc = "Move char left"
vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
opts.desc = "Move char right"
vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)

opts.desc = "Toggle terminal"
map("n", "<F1>", "<cmd>lua require'FTerm'.toggle()<CR>", opts)

-- map("n", "<C-T>", "<cmd>NvimTreeToggle<CR>", opts)
opts.desc = "Toggle line number"
map("n", "<C-N>", "<cmd>call SetNumber()<CR>", opts)
opts.desc = "Toggle non-text characters"
map("n", "<C-L>", "<cmd>set list!<CR>", opts)
opts.desc = "Toggle cursorline"
map("n", "<C-J>", "<cmd>set cursorline!<CR>", opts)
opts.desc = "Clear search highlight"
map("n", "<C-P>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>", opts)

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

opts.desc = "Quick comma"
map("i", ",,", ",", opts)

opts.desc = "Unindent"
map("x", "<", "<gv", opts)
opts.desc = "Indent"
map("x", ">", ">gv", opts)

opts.desc = "Toggle foldcolumn"
map("n", "<leader>a", ":call FoldColumnToggle()<CR>", opts)
opts.desc = "Open all folds"
map("n", "zR", require("ufo").openAllFolds)
opts.desc = "Close all folds"
map("n", "zM", require("ufo").closeAllFolds)

opts.desc = "Show buffer list"
map("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)

opts.desc = "Toggle colorizing hex colors"
map("n", "<leader>c", ":ColorizerToggle<CR>", opts)

opts.desc = "Open diff mode"
map("n", "<leader>dd", "<cmd>DiffviewOpen<CR>", opts)
opts.desc = "Close diff mode"
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", opts)
opts.desc = "Open diff history mode"
map("n", "<leader>df", "<cmd>DiffviewFileHistory<CR>", opts)

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

opts.desc = "Show history"
map("n", "<leader>h", "<cmd>Telescope oldfiles<CR>", opts)

opts.desc = "Toggle indent lines"
map("n", "<leader>i", "<cmd>IndentBlanklineToggle<CR>", opts)

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

opts.desc = "Show referencces"
map("n", "<leader>qr", "<cmd>Glance references<CR>", opts)
opts.desc = "Show definition"
map("n", "<leader>qd", "<cmd>Glance definitions<CR>", opts)
opts.desc = "Show implementations"
map("n", "<leader>qi", "<cmd>Glance implementations<CR>", opts)
opts.desc = "Show type definitions"
map("n", "<leader>qt", "<cmd>Glance type_definitions<CR>", opts)
opts.desc = "Show code actions"
map({ "n", "v" }, "<leader>qc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

opts.desc = "Toggle code minimap"
map("n", "<leader>sb", ":lua MiniMap.toggle() <CR>", opts)
opts.desc = "Toggle spell checking"
map("n", "<leader>sp", ":setlocal spell! spelllang=en_gb<CR>", opts)
opts.desc = "Show spell suggestion"
map("n", "<leader>sf", "<cmd>Telescope spell_suggests<CR>", opts)

opts.desc = "Show recent files"
map("n", "<leader>t", "<cmd>Telescope frecency<CR>", opts)
opts.desc = "Show undo tree"
map("n", "<leader>u", "<cmd>Telescope undo<CR>", opts)

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
