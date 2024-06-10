
local M = {
    "folke/zen-mode.nvim",
  event = "VeryLazy",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>Tzm"] = { "<cmd>ZenMode<cr>", "Toggle Zen Mode" },
  }

  require("zen-mode").setup {
    -- write logs to console(command line)
  }
end

return M
