return {
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = {
      auto_start = true,
      log_level = "info",
    },
  },
  {
    "amp-extras",
    dir = vim.fn.stdpath("config") .. "/amp-extras",
    dependencies = {
      "sourcegraph/amp.nvim",
      "folke/snacks.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      picker = "snacks",
      data_dir = vim.fn.expand("~/.config/amp-extras"),
    },
    config = function(_, opts)
      require("amp-extras").setup(opts)

      -- Register which-key groups
      local wk = require("which-key")
      wk.add({
        { "<leader>a", group = "Amp", mode = { "n", "v" } },
        { "<leader>aa", group = "Agent" },
        { "<leader>ad", group = "Dash X" },
        { "<leader>adc", group = "Categories" },
        { "<leader>as", group = "Send", mode = { "n", "v" } },
        { "<leader>at", group = "Threads/Tools" },
        { "<leader>al", group = "Login" },
        { "<leader>am", group = "MCP" },
        { "<leader>ama", group = "Add" },
        { "<leader>amd", group = "Doctor" },
        { "<leader>ax", group = "Session" },
        { "<leader>ap", group = "Permissions" },
      })
    end,
    keys = {
      -- Basic Amp keymaps under <leader>a*
      { "<leader>asm", "<cmd>AmpSend<cr>", desc = "Message" },
      { "<leader>asb", "<cmd>AmpSendBuffer<cr>", desc = "Buffer" },
      { "<leader>ash", "<cmd>AmpPromptSelection<cr>", desc = "Highlighted", mode = "v" },
      { "<leader>asl", "<cmd>AmpPromptRef<cr>", desc = "Line Ref", mode = { "n", "v" } },
      { "<leader>asf", "<cmd>AmpPromptFileRef<cr>", desc = "File Ref" },
      { "<leader>ath", "<cmd>AmpThreadsList<cr>", desc = "Threads" },
      { "<leader>ato", "<cmd>AmpToolsList<cr>", desc = "Tools" },
      { "<leader>ali", "<cmd>AmpLogin<cr>", desc = "Amp Login" },
      { "<leader>alo", "<cmd>AmpLogout<cr>", desc = "Amp Logout" },
      { "<leader>au", "<cmd>AmpUpdate<cr>", desc = "Amp Update" },
      { "<leader>amac", "<cmd>AmpMcpAddCommand<cr>", desc = "Add Server (Command)" },
      { "<leader>amai", "<cmd>AmpMcpAddInteractive<cr>", desc = "Add Server (Interactive)" },
      { "<leader>amr", "<cmd>AmpMcpRemove<cr>", desc = "Remove Server" },
      { "<leader>amo", "<cmd>AmpMcpOauth<cr>", desc = "OAuth" },
      { "<leader>amda", "<cmd>AmpMcpDoctorAll<cr>", desc = "All Servers" },
      { "<leader>amds", "<cmd>AmpMcpDoctorSingle<cr>", desc = "Single Server" },
      { "<leader>aml", "<cmd>AmpMcpList<cr>", desc = "List Servers" },
      -- Dash X commands
      { "<leader>ad", "<cmd>AmpDashX<cr>", desc = "Dash X" },
      { "<leader>ada", "<cmd>AmpDashXAdd<cr>", desc = "Add Prompt" },
      { "<leader>adm", "<cmd>AmpDashXManage<cr>", desc = "Manage Prompts" },
      { "<leader>adc", "<cmd>AmpDashXCategories<cr>", desc = "Manage Categories" },
      { "<leader>adx", "<cmd>AmpSessionExecute<cr>", desc = "Quick Execute" },
      -- Session commands
      { "<leader>axb", "<cmd>AmpSessionOpen<cr>", desc = "Blank Session" },
      { "<leader>axm", "<cmd>AmpSessionWithMessage<cr>", desc = "Session with Message" },
      -- Permissions commands
      { "<leader>ape", "<cmd>AmpPermissionsEdit<cr>", desc = "Edit Permissions" },
      { "<leader>apl", "<cmd>AmpPermissionsList<cr>", desc = "List Permissions" },
      { "<leader>apt", "<cmd>AmpPermissionsTest<cr>", desc = "Test Permissions" },
      { "<leader>apa", "<cmd>AmpPermissionsAdd<cr>", desc = "Add Permission" },
    },
  },
}