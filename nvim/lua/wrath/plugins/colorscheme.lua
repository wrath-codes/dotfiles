local M = {
	-- -- "LunarVim/primer.nvim",
	-- "folke/tokyonight.nvim",
	-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- priority = 1000, -- make sure to load this before all the other start plugins
	-- opts = {
	-- 	style = "moon",
	-- 	transparent = true,
	-- 	styles = {
	-- 		sidebars = "transparent",
	-- 		floats = "transparent",
	-- 	},
	-- },
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "auto", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "frappe",
		},
		transparent_background = true, -- disables setting the background color.
		show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
		term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = true, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		no_underline = false, -- Force no underline
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
		},
		color_overrides = {},
		custom_highlights = {},
		default_integrations = true,
		integrations = {
			aerial = true,
			alpha = true,
			cmp = true,
			dap_ui = true,
			diffview = true,
			fidget = true,
			gitsigns = true,
			harpoon = true,
			hop = true,
			headlines = true,
			indent_blankline = true,
			illuminate = true,
			lsp_trouble = true,
			mason = true,
			markdown = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			navic = { enabled = true, custom_bg = "lualine" },
			neogit = true,
			neotest = true,
			nvimtree = true,
			noice = true,
			notify = true,
			octo = true,
			rainbow_delimiters = true,
			sandwich = true,
			semantic_tokens = true,
			telekasten = true,
			telescope = true,
			treesitter = true,
			treesitter_context = true,
			which_key = true,
		},
	},
}

function M.config()
	vim.cmd.colorscheme("catppuccin")
end

return M
