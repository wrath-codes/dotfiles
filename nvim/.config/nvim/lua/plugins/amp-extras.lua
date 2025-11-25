-- TEMPORARILY DISABLED: Migrating to amp-extras-rs (Rust implementation)
-- Uncomment this when you want to switch back to the Lua version
--[[
return {
  -- Use local development version
  dir = "/Users/wrath/projects/amp-extras.nvim",
  name = "amp-extras.nvim",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio", -- Required: for async/parallel CLI operations
    "folke/snacks.nvim",
    "kkharji/sqlite.lua", -- SQLite backend (faster than JSON)
    "rktjmp/fwatch.nvim", -- File watching for auto-reload
  },
  opts = {
    autostart = true,
    picker = "snacks",
    paths = {
      saved_threads = "~/amp-extras/saved_threads",
    },
    cache = {
      show_progress = true,        -- Show rebuild progress notifications
      builtin_concurrency = 5,     -- Parallel builtin fetching (reduced from 10 due to nio hanging)
      ttl_minutes = 30,            -- Cache TTL in minutes (default: 30)
    },
  },
  config = function(_, opts)
    require("amp-extras").setup(opts)

    -- Register which-key groups
    local wk = require("which-key")
    wk.add({
      { "<leader>a", group = "Amp", mode = { "n", "v" } },
      { "<leader>ad", group = "DashX Prompts" },
      { "<leader>as", group = "Send", mode = { "n", "v" } },
      { "<leader>at", group = "Threads/Tools" },
      { "<leader>ato", group = "Tools" },
      { "<leader>al", group = "Account" },
      { "<leader>am", group = "MCP" },
      { "<leader>ama", group = "Add" },
      { "<leader>amd", group = "Doctor" },
      { "<leader>ax", group = "Session" },
    })
  end,
  keys = {
    -- Send commands
    { "<leader>asm", "<cmd>AmpExtrasSend<cr>", desc = "Message" },
    { "<leader>asb", "<cmd>AmpExtrasSendBuffer<cr>", desc = "Buffer" },
    { "<leader>ash", "<cmd>AmpExtrasPromptSelection<cr>", desc = "Selection", mode = "v" },
    { "<leader>asl", "<cmd>AmpExtrasPromptRef<cr>", desc = "Line Ref", mode = { "n", "v" } },
    { "<leader>asf", "<cmd>AmpExtrasPromptFileRef<cr>", desc = "File Ref" },
    { "<leader>asp", "<cmd>AmpExtrasDashXYank<cr>", desc = "Yank to Prompt", mode = "v" },

    -- Thread commands
    { "<leader>ath", "<cmd>AmpExtrasThreadsList<cr>", desc = "Threads" },

    -- Tools commands
    { "<leader>atom", "<cmd>AmpExtrasToolsPermissions<cr>", desc = "Manage Permissions" },
    { "<leader>atot", "<cmd>AmpExtrasToolsTestAll<cr>", desc = "Test All Permissions" },

    -- Account commands
    { "<leader>ali", "<cmd>AmpExtrasLogin<cr>", desc = "Login" },
    { "<leader>alo", "<cmd>AmpExtrasLogout<cr>", desc = "Logout" },
    { "<leader>au", "<cmd>AmpExtrasUpdate<cr>", desc = "Update" },
    { "<leader>av", "<cmd>AmpExtrasVersion<cr>", desc = "Version" },

    -- MCP commands
    { "<leader>amac", "<cmd>AmpExtrasMcpAddCommand<cr>", desc = "Add Server (Command)" },
    { "<leader>amai", "<cmd>AmpExtrasMcpAddInteractive<cr>", desc = "Add Server (Interactive)" },
    { "<leader>amr", "<cmd>AmpExtrasMcpRemove<cr>", desc = "Remove Server" },
    { "<leader>amo", "<cmd>AmpExtrasMcpOauth<cr>", desc = "OAuth" },
    { "<leader>amda", "<cmd>AmpExtrasMcpDoctorAll<cr>", desc = "All Servers" },
    { "<leader>amds", "<cmd>AmpExtrasMcpDoctorSingle<cr>", desc = "Single Server" },
    { "<leader>aml", "<cmd>AmpExtrasMcpList<cr>", desc = "List Servers" },

    -- Prompts commands (DashX) - All features in picker
    { "<leader>adl", "<cmd>AmpExtrasDashX<cr>", desc = "List Prompts" },
    { "<leader>ada", "<cmd>AmpExtrasDashXAdd<cr>", desc = "Add Prompt" },
    { "<leader>ade", "<cmd>AmpExtrasDashXExecute<cr>", desc = "Quick Execute" },
    { "<leader>adr", "<cmd>AmpExtrasDashXRefresh<cr>", desc = "Refresh Cache" },

    -- Session commands
    { "<leader>axb", "<cmd>AmpExtrasSessionOpen<cr>", desc = "Blank Session" },
    { "<leader>axm", "<cmd>AmpExtrasSessionWithMessage<cr>", desc = "Session with Message" },
  },
}
--]]

-- amp-extras-rs (Rust implementation)
return {
  dir = "/Users/wrath/projects/amp-extras.nvim",
  name = "amp-extras.nvim",
  lazy = false,
  dependencies = { "sourcegraph/amp.nvim" },
  -- opts = {
  --   -- prefix = "<leader>a", -- Default prefix
  --   keymaps = {
  --     -- Send commands (true = enable with default keymap, string = custom keymap, false = disable)
  --     send_selection = true, -- <leader>ash
  --     send_selection_ref = true, -- <leader>asl
  --     send_buffer = true, -- <leader>asb
  --     send_file_ref = true, -- <leader>asf
  --     send_line_ref = true, -- <leader>asr
  --     send_message = true, -- <leader>asm
  --     login = true, -- <leader>ali
  --     logout = true, -- <leader>alo
  --     update = true, -- <leader>au
  --   },
  --   lualine = {
  --     enabled = true,
  --   },
  -- },
  -- config = function(_, opts)
  config = function()
    require("amp_extras").setup({})

    -- Register which-key groups
    local wk = require("which-key")
    wk.add({
      { "<leader>a", group = "Amp", mode = { "n", "v" } },
      { "<leader>as", group = "Send", mode = { "n", "v" } },
      { "<leader>al", group = "Account" },
      { "<leader>ap", group = "Prompts" },
      { "<leader>ai", group = "Interactive" },
    })
  end,
}
