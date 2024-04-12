return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = "catppuccin",
				section_separators = "",
				component_separators = "|",
			},
			sections = {
				-- left
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },

				-- right
				lualine_x = { "g:zoom#statustext", "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
