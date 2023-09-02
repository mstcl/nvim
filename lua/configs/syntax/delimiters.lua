local present, rainbow = pcall(require, "rainbow-delimiters")
if not present then
	return
end

require("rainbow-delimiters.setup")({
	strategy = {
		[""] = rainbow.strategy["global"],
		latex = function()
			if vim.fn.line("$") > 10000 then
				return nil
			elseif vim.fn.line("$") > 1000 then
				return rainbow.strategy["global"]
			end
			return rainbow.strategy["local"]
		end,
	},
	query = {
		[""] = "rainbow-delimiters",
		latex = "rainbow-blocks",
		lua = "rainbow-blocks",
	},
	highlight = {
		"TSRainbowRed",
		"TSRainbowBlue",
		"TSRainbowCyan",
		"TSRainbowGreen",
		"TSRainbowviolet",
		"TSRainbowYellow",
	},
})
