_G.tabline = {}
_G.tabline.get = function()
	local s = ""

	for i = 1, vim.fn.tabpagenr("$") do
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. "%" .. i .. "T"

		local tab_cwd = vim.fn.getcwd(-1, i)
		local dir_display = vim.fn.fnamemodify(tab_cwd, ":t")

		s = s .. " " .. i .. ": " .. dir_display .. " "
	end

	s = s .. "%#TabLineFill#%T"

	return s
end

_G.tabline.set = function() vim.o.tabline = "%!v:lua.tabline.get()" end

_G.tabline.set()
