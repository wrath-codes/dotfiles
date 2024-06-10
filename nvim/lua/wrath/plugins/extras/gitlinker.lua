local M = {
  "linrongbin16/gitlinker.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  event = "VeryLazy",
}
-- GitLink: generate git link and copy to clipboard.
-- GitLink!: generate git link and open in browser.
-- GitLink blame: generate the /blame url and copy to clipboard.
-- GitLink! blame: generate the /blame url and open in browser.

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>gy"] = { "<cmd>GitLink!<cr>", "Git link" },
    ["<leader>gY"] = { "<cmd>GitLink blam<cr>", "Git link blame" },
  }

  require("gitlinker").setup {
    -- print message in command line
    message = true,

    -- write logs to console(command line)
    console_log = true,
  }
end

return M
