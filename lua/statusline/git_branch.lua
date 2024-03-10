local get_branch = function()
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir ~= "" then
		local head_file = io.open(git_dir .. "/HEAD", "r")
		if head_file then
			local content = head_file:read("*all")
			head_file:close()
			return content:match("ref: refs/heads/(.-)%s*$")
		end
		return ""
	end
	return ""
end

return {
	name = "git_branch",
	event = { "BufEnter" },
	user_event = { "VeryLazy", "GitSignsUpdate" },
	timing = false,
	lazy = true,
	configs = {},
	padding = 0,
	colors = "StatuslineAlt",
	condition = function()
		return vim.api.nvim_buf_get_option(0, "buflisted")
	end,
	update = function()
		local branch = get_branch()
		local result = ""
		if branch == "" then
			result = "n/a "
		else
			result = branch .. " │"
		end
		return result
	end,
}
