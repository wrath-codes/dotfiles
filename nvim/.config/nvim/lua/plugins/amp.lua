return {
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = {
      auto_start = true,
      log_level = "info",
    },
    config = function(_, opts)
      require("amp").setup(opts)

      -- Setup custom Amp commands
      require("utils.amp.commands").setup()

      -- Register which-key groups
      local wk = require("which-key")
      wk.add({
        { "<leader>a", group = "Amp" },
        { "<leader>aa", group = "Amp Agent" },
        { "<leader>at", group = "Amp Threads" },
        { "<leader>al", group = "Amp Login" },
      })
    end,
    keys = {
      -- Basic Amp keymaps under <leader>a*
      { "<leader>am", "<cmd>AmpSend ", desc = "Amp Send Message" },
      { "<leader>ab", "<cmd>AmpSendBuffer<cr>", desc = "Amp Send Buffer" },
      { "<leader>as", "<cmd>AmpPromptSelection<cr>", desc = "Amp Selection to Prompt", mode = "v" },
      { "<leader>ar", "<cmd>AmpPromptRef<cr>", desc = "Amp Reference to Prompt", mode = { "n", "v" } },
      { "<leader>aat", "<cmd>AmpToolsList<cr>", desc = "Amp Tools List" },
      { "<leader>atl", "<cmd>AmpThreadsList<cr>", desc = "Amp Threads List" },
      { "<leader>ali", "<cmd>AmpLogin<cr>", desc = "Amp Login" },
      { "<leader>alo", "<cmd>AmpLogout<cr>", desc = "Amp Logout" },
    },
  },
}
