local present, starter = pcall(require, "mini.starter")
if not present then
	return
end

local plugins_gen = io.popen('echo "$(find ~/.local/share/nvim/lazy -maxdepth 1 -type d | wc -l) - 1" | bc')
local plugins = plugins_gen:read("*a")
plugins_gen:close()

local telescope = function()
	return function()
		return {
			{ action = "Telescope oldfiles", name = "History", section = "Actions" },
			{ action = "Telescope frecency", name = "Frecency", section = "Actions" },
			{ action = "Telescope find_files", name = "Files", section = "Actions" },
			{ action = "Telescope file_browser", name = "Browser", section = "Actions" },
			{ action = "Telescope live_grep", name = "Live grep", section = "Actions" },
		}
	end
end

local plugin_actions = function()
	return function()
		return {
			{ action = "Lazy show", name = "Overview", section = "Plugins" },
			{ action = "Lazy check", name = "Fetch", section = "Plugins" },
			{ action = "Lazy update", name = "Update", section = "Plugins" },
		}
	end
end

local greetings = function()
	local hour = tonumber(vim.fn.strftime("%H"))
	-- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
	local part_id = math.floor((hour + 4) / 8) + 1
	local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
	local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

	return ("Good %s, %s"):format(day_part, username)
end

local time = greetings()

starter.setup({
	items = {
		starter.sections.recent_files(6, false, false),
		telescope(),
		plugin_actions(),
		starter.sections.builtin_actions(),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.aligning("center", "center"),
	},
	footer = "Total number of plugins: " .. plugins,
	header = "███╗   ██╗███████╗ ██████╗ ██████╗ ██╗███╗   ███╗\n████╗  ██║██╔════╝██╔═══██╗██╔══██╗██║████╗ ████║\n██╔██╗ ██║█████╗  ██║   ██║██████╔╝██║██╔████╔██║\n██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██║██║╚██╔╝██║\n██║ ╚████║███████╗╚██████╔╝██████╔╝██║██║ ╚═╝ ██║\n╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝     ╚═╝\n"
		.. time,
})
