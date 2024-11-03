return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local function window()
			return vim.api.nvim_win_get_number(0)
		end

		local function getWords()
			if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
				if vim.fn.wordcount().visual_words == 1 then
					return tostring(vim.fn.wordcount().visual_words) .. " word"
				elseif not (vim.fn.wordcount().visual_words == nil) then
					return tostring(vim.fn.wordcount().visual_words) .. " words"
				else
					return tostring(vim.fn.wordcount().words) .. " words"
				end
			else
				return ""
			end
		end

		local function place()
			local colPre = "C:"
			local col = "%c"
			local linePre = " L:"
			local line = "%l/%L"
			return string.format("%s%s%s%s", colPre, col, linePre, line)
		end

		local function get_venv()
			local venv = vim.env.VIRTUAL_ENV
			if venv then
				local env = string.match(venv, "[^/]+$")
				return " " .. env
			else
				return ""
			end
		end

		local ros_distro = vim.fn.expand("$ROS_DISTRO")

		local function get_ros_distro()
			if ros_distro and ros_distro ~= "$ROS_DISTRO" then
				return "󰭆 " .. ros_distro
			else
				return ""
			end
		end

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				icons_enabled = true, -- false
				component_separators = { " ", " " }, -- component_separators = '|',
				section_separators = { left = "", right = "" }, -- section_separators = '',
				disabled_filetypes = { "NvimTree", "packer" },
				--theme = my_lualine_theme,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", icon = "" },
					{
						"diff",
						--source = diff_source,
						color_added = "#a7c080",
						color_modified = "#ffdf1b",
						color_removed = "#ff6666",
					},
				},
				lualine_c = {
					{ "diagnostics", sources = { "nvim_diagnostic" } },
					function()
						return "%="
					end,
					{
						"filename",
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for new created file before first writting
						},
					},
					{
						getWords,
						color = { fg = "#dee2e6", bg = "#393f4a" },
						separator = { left = "", right = "" },
					},
				},
				lualine_x = { { "encoding" }, { "fileformat" }, { "filetype", icon_only = true } },
				lualine_y = { { get_venv }, { get_ros_distro } },
				lualine_z = {
					{ place, padding = { left = 1, right = 1 } },
				},
			},
			inactive_sections = {
				lualine_a = { window },
				lualine_b = {
					{
						"diff",
						--source = diff,
						color_added = "#a7c080",
						color_modified = "#ffdf1b",
						color_removed = "#ff6666",
					},
				},
				lualine_c = {
					function()
						return "%="
					end,
					{
						"filename",
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for new created file before first writting
						},
					},
				},
				lualine_x = {
					{ place, padding = { left = 1, right = 1 } },
				},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "quickfix" },
		})
	end,
}
