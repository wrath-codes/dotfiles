return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"mfussenegger/nvim-dap-python",
	},
	cmd = "VenvSelect",
	opts = {
		dap_enabled = true,
	},
	keys = { { "<leader>vs", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
}
