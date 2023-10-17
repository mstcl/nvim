local present, cmp = pcall(require, "cmp")
if not present then
	return
end
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local kind_icons = {
	Namespace = "ξ",
	Text = "☰",
	Method = "ƒ",
	Function = "ƒ",
	Constructor = "☂",
	Field = "⊟",
	Variable = "Ψ",
	Class = "⁐",
	Interface = "♺",
	Module = "◫",
	Property = "✓",
	Unit = "$",
	Value = "λ",
	Enum = "ζ",
	Keyword = "★",
	Snippet = "&",
	Color = "%",
	File = "⊡",
	Reference = "⇒",
	Folder = "+",
	EnumMember = "@",
	Constant = "π",
	Struct = "◧",
	Event = "!",
	Operator = "⁑",
	TypeParameter = "⊞",
	Table = "☷",
	Object = "☁",
	Tag = "#",
	Array = "☷",
	Boolean = "◕",
	Number = "#",
	Null = "∅",
	String = "T",
	Calendar = "◪",
	Watch = "◔",
	Package = "◫",
	Copilot = "",
}

local has_any_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local press = function(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

local buffer_opts = {
	get_bufnrs = function()
		local bufs = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			bufs[vim.api.nvim_win_get_buf(win)] = true
		end
		return vim.tbl_keys(bufs)
	end,
}

cmp.setup({
	enabled = function()
		return vim.g.cmp_toggle
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	preselect = cmp.PreselectMode.None,
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
	cmp.setup.filetype({ "markdown" }, {
		sources = {
			{ name = "path" },
			{ name = "luasnip",  priority = 9 },
			{ name = "nvim_lsp", priority = 8, group_index = 1 },
			{
				name = "buffer",
				options = buffer_opts,
			},
		},
	}),
	cmp.setup.filetype({ "quarto" }, {
		sources = {
			{ name = "path" },
			{ name = "luasnip",          priority = 9 },
			{ name = "nvim_lsp",         priority = 8, group_index = 1 },
			{ name = "pandoc_references" },
			{
				name = "buffer",
				options = buffer_opts,
			},
		},
	}),
	cmp.setup.filetype({ "org" }, {
		sources = {
			{ name = "orgmode" },
			{ name = "path" },
			{ name = "luasnip", priority = 9 },
			{ name = "nvim_lsp" },
			{
				name = "buffer",
				options = buffer_opts,
			},
		},
	}),
	sorting = {
		priority_weight = 1.0,
	},
	sources = cmp.config.sources({
		{ name = "luasnip",  priority = 9 },
		{ name = "path" },
		{ name = "nvim_lsp", priority = 8,    group_index = 1 },
		{ name = "buffer",   group_index = 2, keyword_length = 5, max_item_count = 3 },
	}),
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-i>"] = function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif has_any_words_before() then
				press("<Space>")
			else
				fallback()
			end
		end,
		["<Tab>"] = function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end,
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			local icon = kind_icons[item.kind]
			icon = " " .. icon .. " "
			item.menu = "   (" .. item.kind .. ")"
			item.kind = icon
			item.abbr = string.sub(item.abbr, 1, 20)
			return item
		end,
	},
	window = {
		completion = {
			side_padding = 0,
			scrollbar = false,
		},
		documentation = {
			border = "single",
			winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
			max_width = 120,
			max_height = math.floor(vim.o.lines * 0.3),
		},
	},
	experimental = {
		ghost_text = false,
	},
})

vim.g.cmp_toggle = true
