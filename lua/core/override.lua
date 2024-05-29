-- Override settings in `lua/settings` here
vim.cmd.colorscheme("ivory_extended")

vim.keymap.set("n", "<leader>kn", function()
	vim.ui.input({ prompt = "Enter path: " },
	function (input)
		local rel = ""
		local title = ""
		for k, v in string.gmatch(input, "(.*)/(.*)") do
			rel = k
			title = v
		end
		local cmd = "zk new " .. rel .. " -p -t " .. title
		local output = vim.fn.system(cmd)
		output = output:gsub("[\n]", "")
		vim.notify("Created " .. output, vim.log.levels.INFO)
		vim.cmd("edit " .. output)
	end
	)
	---@diagnostic disable-next-line: undefined-field
end, {
	desc = "New note",
	noremap = true,
	silent = true,
})
