local M = {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	lazy = false,
	branch = "regexp", -- This is the regexp branch, use this for the new version
}

function M.config()
	local mappings = {
		{ "<leader>v", group = "VenvSelector" },
		{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Pick a virtual environment for the current project" },
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Retrieve the venv from a cache" },
	}
	local which_key = require("which-key")

	which_key.add(mappings)
	local venv_selector = require("venv-selector")
	venv_selector.setup({
		poetry_path = "~/.cache/pypoetry/virtualenvs",
		search = {
			my_venvs = {
				command = "fd python$ ~/Code",
			},
		},
	})
end

return M
