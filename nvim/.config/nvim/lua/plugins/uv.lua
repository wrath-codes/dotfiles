return {
  {
    "benomahony/uv.nvim",
    ft = "python",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      require("uv").setup({
        auto_activate_venv = true,
        notify_activate_venv = true,
        auto_commands = true,
        picker_integration = true,

        keymaps = {
          prefix = "<leader>v", -- Main prefix for uv commands
          commands = true, -- Show uv commands menu
          run_file = true, -- Run current file
          run_selection = true, -- Run selected code
          run_function = true, -- Run function
          venv = true, -- Environment management
          init = true, -- Initialize uv project
          add = true, -- Add a package
          remove = true, -- Remove a package
          sync = true, -- Sync packages
          sync_all = true, -- Sync all packages, extras and groups
        },

        -- Execution options
        execution = {
          -- Python run command template
          run_command = "uv run python",

          -- Show output in notifications
          notify_output = true,

          -- Notification timeout in ms
          notification_timeout = 10000,
        },
      })
    end,
  },
}
