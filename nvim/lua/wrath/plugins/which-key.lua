local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

function M.config()
	local mappings = {
		{ "<leader>q", "<cmd>confirm q<CR>", "Quit" },
		{ "<leader>nh", "<cmd>nohlsearch<CR>", "NOHL" },
		{ "<leader>;", "<cmd>tabnew | terminal<CR>", "Term" },
		{ "<leader>b", group = "Buffers" },
		{ "<leader>d", group = "Debug" },
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git" },
		{ "<leader>h", group = "Harpoon" },
		{ "<leader>l", group = "LSP" },
		{ "<leader>L", group = "Lazy" },
		{ "<leader>m", group = "Move" },
		{ "<leader>p", group = "Pop" },
		{ "<leader>t", group = "Test" },
		{ "<leader>T", group = "Toggle" },
		{ "<leader>s", group = "Treesitter" },
		{ "<leader>c", group = "Lab" },
		{ "<leader>w", group = "Window" },
		{ "<leader>ws", group = "Split" },
		{ "<leader>wsv", "<C-w>v", "Vertical" },
		{ "<leader>wsh", "<C-w>s", "Horizontal" },
		{ "<leader>wse", "<C-w>=", "Equal" },
		{ "<leader>wsc", "<cmd>close<CR>", "Close" },
		{ "<leader>wt", group = "Tab" },
		{ "<leader>wtc", "<cmd>tabclose<CR>", "Close" },
		{ "<leader>wtn", "<cmd>$tabnew<cr>", "New Empty Tab" },
		{ "<leader>wtN", "<cmd>tabnew %<cr>", "New Tab" },
		{ "<leader>wto", "<cmd>tabonly<cr>", "Only" },
		{ "<leader>wth", "<cmd>-tabmove<cr>", "Move Left" },
		{ "<leader>wtl", "<cmd>+tabmove<cr>", "Move Right" },
	}

	local which_key = require("which-key")
	which_key.setup({
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		window = {
			border = "rounded",
			position = "bottom",
			padding = { 2, 2, 2, 2 },
		},
		ignore_missing = true,
		show_help = false,
		show_keys = false,
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
	}

	which_key.add(mappings, opts)
  which_key.add({
    {"<Tab>", "<cmd>tabn<CR>", desc = "Go to next tab"},
    {"<S-Tab>", "<cmd>tabp<CR>", desc = "Go to previous tab"},
  }, opts)
end
  

return M
