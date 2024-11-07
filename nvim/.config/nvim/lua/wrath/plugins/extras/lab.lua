local M = {
	"0x100101/lab.nvim",
	build = "cd js && npm ci",
}

function M.config()
	local lab = require("lab")
	lab.setup({
		code_runner = {
			enabled = true,
		},
		quick_data = {
			enabled = false,
		},
	})

	local wk = require("which-key")

	wk.add({
		{ "<leader>cr", "<cmd>Lab code run<cr>", desc = "Lab Run" },
		{ "<leader>cs", "<cmd>Lab code stop<cr>", desc = "Lab Stop" },
		{ "<leader>cp", "<cmd>Lab code panel<cr>", desc = "Lab Panel" },
		{ "<leader>cc", "<cmd>Lab code config<cr>", desc = "Lab Panel" },
	})
end

return M
