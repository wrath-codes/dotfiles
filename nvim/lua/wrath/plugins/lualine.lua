local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
}

function M.config()
	-- File Type Component
	local filetype = {
		"filetype",
		colored = true, -- Displays filetype icon in color if set to true
		icon_only = true, -- Display only an icon for filetype
		icon = { align = "right" },
		function()
			local filetype = vim.bo.filetype
			local upper_case_filetypes = {
				"json",
				"jsonc",
				"yaml",
				"toml",
				"css",
				"scss",
				"html",
				"xml",
				"xhtml",
			}

			if vim.tbl_contains(upper_case_filetypes, filetype) then
				return filetype:upper()
			end

			return filetype
		end,
	}

	-- File Name Component
	local filename = {
		"filename",
		file_status = true, -- Displays file status (readonly status, modified status)
		newfile_status = true, -- Display new file status (new file means no write after created)
		path = 3, -- 0: Just the filename
		-- 1: Relative path
		-- 2: Absolute path
		-- 3: Absolute path, with tilde as the home directory
		-- 4: Filename and parent dir, with tilde as the home directory

		shorting_target = 40, -- Shortens path to leave 40 spaces in the window
		-- for other components. (terrible name, any suggestions?)
		symbols = {
			modified = "[+]", -- Text to show when the file is modified.
			readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
			unnamed = "[No Name]", -- Text to show for unnamed buffers.
			newfile = "[New]", -- Text to show for newly created file before first write
		},
	}

	-- Harpoon Component
	local harpoon = require("harpoon")

	-- define visual settings for harpoon tabline
	local harpoon_colors = {
		active = {
			text = "#cba6f7",
			number = "#fab387",
		},
		inactive = {
			text = "#797C91",
			number = "#d5b9a8",
		},
		grey = "#797C91",
		transparent = nil,
	}

	vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = harpoon_colors.inactive.text, bg = harpoon_colors.transparent })
	vim.api.nvim_set_hl(0, "HarpoonActive", { fg = harpoon_colors.active.text, bg = harpoon_colors.transparent })
	vim.api.nvim_set_hl(
		0,
		"HarpoonNumberActive",
		{ fg = harpoon_colors.active.number, bg = harpoon_colors.transparent }
	)
	vim.api.nvim_set_hl(
		0,
		"HarpoonNumberInactive",
		{ fg = harpoon_colors.inactive.number, bg = harpoon_colors.transparent }
	)
	vim.api.nvim_set_hl(0, "HarpoonEmpty", { fg = harpoon_colors.grey, bg = harpoon_colors.transparent })
	vim.api.nvim_set_hl(0, "HarpoonNumberEmpty", { fg = harpoon_colors.grey, bg = harpoon_colors.transparent })
	vim.api.nvim_set_hl(0, "TabLineFill", { fg = harpoon_colors.transparent, bg = harpoon_colors.transparent })

	local function harpoon_files()
		local contents = {}
		local marks_length = harpoon:list():length()
		local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
		local letters = { "H", "T", "N", "S" }
		for index = 1, marks_length do
			local harpoon_file_path = harpoon:list():get(index).value
			local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

			if current_file_path == harpoon_file_path then
				contents[index] = string.format(" %%#HarpoonNumberActive#%s %%#HarpoonActive#%s ", "[󰛢]", file_name)
			else
				contents[index] =
					string.format(" %%#HarpoonNumberInactive#%s %%#HarpoonInactive#%s ", letters[index], file_name)
			end
		end

		for index = marks_length + 1, 4 do
			contents[index] = string.format("%%#HarpoonNumberEmpty# %s %%#HarpoonEmpty#%s ", "[+]", "[Empty]")
		end

		return table.concat(contents)
	end

	-- Theme
	local colors = {
		teal = "#94e2d5",
		yellow = "#f9e2af",
		mauve = "#cba6f7",
		transparent = nil,
		peach = "#fab387",
		white = "#c6c6c6",
		green = "#a6e3a1",
		violet = "#d183e8",
		grey = "#303030",
	}

	local bubbles_theme = {
		normal = {
			a = { fg = colors.grey, bg = colors.teal },
			b = { fg = colors.teal, bg = colors.grey },
			c = { fg = colors.white, bg = colors.transparent },
		},

		insert = {
			a = { fg = colors.grey, bg = colors.green },
			b = { fg = colors.green, bg = colors.grey },
			c = { fg = colors.white, bg = colors.transparent },
		},
		visual = {
			a = { fg = colors.grey, bg = colors.mauve },
			b = { fg = colors.mauve, bg = colors.grey },
			c = { fg = colors.white, bg = colors.transparent },
		},
		replace = {
			a = { fg = colors.grey, bg = colors.peach },
			b = { fg = colors.peach, bg = colors.grey },
			c = { fg = colors.white, bg = colors.transparent },
		},
		command = {
			a = { fg = colors.grey, bg = colors.yellow },
			b = { fg = colors.yellow, bg = colors.grey },
			c = { fg = colors.white, bg = colors.transparent },
		},

		inactive = {
			a = { fg = colors.white, bg = colors.transparent },
			b = { fg = colors.white, bg = colors.transparent },
			c = { fg = colors.white, bg = colors.transparent },
		},
	}

	require("lualine").setup({
		options = {
			theme = bubbles_theme,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			ignore_focus = { "NvimTree" },
			-- Define custom colors for regular and active indicators
		},
		tabline = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { filename },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		sections = {
			lualine_a = { { "mode", icon = "" } },
			lualine_b = { { "branch", icon = "" } },
			lualine_c = {
				"%=",
				{
					harpoon_files,
				},
			},
			lualine_x = { filetype, "encoding" },
			lualine_y = { "copilot" },
			lualine_z = { "progress", "location" },
		},
		extensions = { "quickfix", "man", "fugitive", "oil" },
	})
end

return M
