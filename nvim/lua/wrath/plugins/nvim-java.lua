local Util = require("wrath.utils.lazy")
local M = {
  {
    "nvim-java/nvim-java",
    ft = "java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "mfussenegger/nvim-dap",
      "MunifTanjim/nui.nvim",
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        opts = {
          -- make sure mason installs the server
          servers = {
            jdtls = {
              keys = {
                -- Workaround for the lack of a DAP strategy in neotest-java
                {
                  "<leader>tjd",
                  function()
                    require("java").dap.config_dap()
                    require("java").test.debug_current_method()
                  end,
                  desc = "Debug Nearest (Java)",
                },
              },
            },
          },
        },
      },
    },
  },
}

return M
