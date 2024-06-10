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

  wk.register{
  ["<leader>cr"] = { "<cmd>Lab code run<cr>", "Lab Run" },
  ["<leader>cs"] = { "<cmd>Lab code stop<cr>", "Lab Stop" },
  ["<leader>cp"] = { "<cmd>Lab code panel<cr>", "Lab Panel" },
  ["<leader>cc"] = { "<cmd>Lab code config<cr>", "Lab Panel" },
  }
end

return M
