return {
  "wrath-codes/amp-extras.nvim",
  dependencies = {
    "folke/snacks.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    autostart = true,
    picker = "snacks",
    paths = {
      saved_threads = "~/amp/saved_threads",
    },
  },
  config = function(_, opts)
    require("amp-extras").setup(opts)

    -- Register which-key groups
    local wk = require("which-key")
    wk.add({
      { "<leader>a", group = "Amp", mode = { "n", "v" } },
      { "<leader>ad", group = "Prompts" },
      { "<leader>adc", group = "Categories" },
      { "<leader>as", group = "Send", mode = { "n", "v" } },
      { "<leader>at", group = "Threads/Tools" },
      { "<leader>al", group = "Account" },
      { "<leader>am", group = "MCP" },
      { "<leader>ama", group = "Add" },
      { "<leader>amd", group = "Doctor" },
      { "<leader>ax", group = "Session" },
      { "<leader>ap", group = "Permissions" },
    })
  end,
  keys = {
    -- Send commands
    { "<leader>asm", "<cmd>AmpExtrasSend<cr>", desc = "Message" },
    { "<leader>asb", "<cmd>AmpExtrasSendBuffer<cr>", desc = "Buffer" },
    { "<leader>ash", "<cmd>AmpExtrasPromptSelection<cr>", desc = "Selection", mode = "v" },
    { "<leader>asl", "<cmd>AmpExtrasPromptRef<cr>", desc = "Line Ref", mode = { "n", "v" } },
    { "<leader>asf", "<cmd>AmpExtrasPromptFileRef<cr>", desc = "File Ref" },
    
    -- Thread commands
    { "<leader>ath", "<cmd>AmpExtrasThreadsList<cr>", desc = "Threads" },
    
    -- Tools commands
    { "<leader>ato", "<cmd>AmpExtrasToolsList<cr>", desc = "Tools" },
    
    -- Account commands
    { "<leader>ali", "<cmd>AmpExtrasLogin<cr>", desc = "Login" },
    { "<leader>alo", "<cmd>AmpExtrasLogout<cr>", desc = "Logout" },
    { "<leader>au", "<cmd>AmpExtrasUpdate<cr>", desc = "Update" },
    
    -- MCP commands
    { "<leader>amac", "<cmd>AmpExtrasMcpAddCommand<cr>", desc = "Add Server (Command)" },
    { "<leader>amai", "<cmd>AmpExtrasMcpAddInteractive<cr>", desc = "Add Server (Interactive)" },
    { "<leader>amr", "<cmd>AmpExtrasMcpRemove<cr>", desc = "Remove Server" },
    { "<leader>amo", "<cmd>AmpExtrasMcpOauth<cr>", desc = "OAuth" },
    { "<leader>amda", "<cmd>AmpExtrasMcpDoctorAll<cr>", desc = "All Servers" },
    { "<leader>amds", "<cmd>AmpExtrasMcpDoctorSingle<cr>", desc = "Single Server" },
    { "<leader>aml", "<cmd>AmpExtrasMcpList<cr>", desc = "List Servers" },
    
    -- Prompts commands (DashX)
    { "<leader>ad", "<cmd>AmpExtrasDashX<cr>", desc = "Prompts" },
    { "<leader>ada", "<cmd>AmpExtrasDashXAdd<cr>", desc = "Add Prompt" },
    { "<leader>adm", "<cmd>AmpExtrasDashXManage<cr>", desc = "Manage Prompts" },
    { "<leader>adc", "<cmd>AmpExtrasDashXCategories<cr>", desc = "Categories" },
    
    -- Session commands
    { "<leader>axb", "<cmd>AmpExtrasSessionOpen<cr>", desc = "Blank Session" },
    { "<leader>axm", "<cmd>AmpExtrasSessionWithMessage<cr>", desc = "Session with Message" },
    { "<leader>axe", "<cmd>AmpExtrasSessionExecute<cr>", desc = "Quick Execute" },
    
    -- Permissions commands
    { "<leader>ape", "<cmd>AmpExtrasPermissionsEdit<cr>", desc = "Edit Permissions" },
    { "<leader>apl", "<cmd>AmpExtrasPermissionsList<cr>", desc = "List Permissions" },
    { "<leader>apt", "<cmd>AmpExtrasPermissionsTest<cr>", desc = "Test Permissions" },
    { "<leader>apa", "<cmd>AmpExtrasPermissionsAdd<cr>", desc = "Add Permission" },
  },
}
