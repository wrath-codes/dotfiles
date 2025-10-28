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
    end,
    keys = {
      -- Basic Amp keymaps under <leader>a*
      { "<leader>a", "<cmd>AmpPanel<cr>", desc = "Amp Panel" },
      { "<leader>aa", "<cmd>AmpSend ", desc = "Amp Send Message" },
      { "<leader>ab", "<cmd>AmpSendBuffer<cr>", desc = "Amp Send Buffer" },
      { "<leader>as", "<cmd>AmpPromptSelection<cr>", desc = "Amp Selection to Prompt", mode = "v" },
      { "<leader>ar", "<cmd>AmpPromptRef<cr>", desc = "Amp Reference to Prompt", mode = { "n", "v" } },
      { "<leader>at", "<cmd>AmpToolsList<cr>", desc = "Amp Tools List" },
    },
  },
}
