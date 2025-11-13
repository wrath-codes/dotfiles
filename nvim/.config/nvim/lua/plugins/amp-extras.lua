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
  dir = "/Users/wrath/projects/amp-extras-rs",
  name = "amp-extras-rs",
  lazy = false,
  config = function()
    -- Auto-start WebSocket server when Neovim starts
    local amp = require('amp_extras')
    
    -- Start server
    local result, err = amp.server_start()
    if err then
      vim.notify("amp-extras: Failed to start server: " .. err, vim.log.levels.ERROR)
      return
    end
    
    if result then
      -- Setup notifications
      local notif_result, notif_err = amp.setup_notifications()
      if notif_err then
        vim.notify("amp-extras: Failed to setup notifications: " .. notif_err, vim.log.levels.WARN)
      end
      
      vim.notify(
        string.format("amp-extras: WebSocket server started on port %d", result.port),
        vim.log.levels.INFO
      )
    end

    -- Register which-key groups
    local wk = require("which-key")
    wk.add({
      { "<leader>a", group = "Amp", mode = { "n", "v" } },
      { "<leader>as", group = "Send", mode = { "n", "v" } },
      { "<leader>ax", group = "Server" },
    })
  end,
  keys = {
    -- Send commands (visual mode) - Now using Rust-registered commands
    { "<leader>ash", ":'<,'>AmpSendSelection<cr>", desc = "Selection (Content)", mode = "v" },
    { "<leader>asl", ":'<,'>AmpSendSelectionRef<cr>", desc = "Selection (Ref)", mode = "v" },

    -- Send commands (normal mode) - Now using Rust-registered commands
    { "<leader>asb", "<cmd>AmpSendBuffer<cr>", desc = "Buffer (Content)" },
    { "<leader>asf", "<cmd>AmpSendFileRef<cr>", desc = "File (Ref)" },
    { "<leader>asr", "<cmd>AmpSendLineRef<cr>", desc = "Line (Ref)" },

    -- Server commands
    { "<leader>axs", "<cmd>AmpServerStart<cr>", desc = "Start Server" },
    { "<leader>axx", "<cmd>AmpServerStop<cr>", desc = "Stop Server" },
    { "<leader>axc", "<cmd>AmpServerStatus<cr>", desc = "Server Status" },
  },
}
