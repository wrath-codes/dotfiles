return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dpm", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dpc", function() require('dap-python').test_class() end,  desc = "Debug Class" },
      },
		config = function()
			local path = require("mason-registry").get_package("debugpy"):get_install_path()
			require("dap-python").setup(path .. "/venv/bin/python")
		end,
	},
}
