return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 █     █░ ██▀███   ▄▄▄      ▄▄▄█████▓ ██░ ██ 
▓█░ █ ░█░▓██ ▒ ██▒▒████▄    ▓  ██▒ ▓▒▓██░ ██▒
▒█░ █ ░█ ▓██ ░▄█ ▒▒██  ▀█▄  ▒ ▓██░ ▒░▒██▀▀██░
░█░ █ ░█ ▒██▀▀█▄  ░██▄▄▄▄██ ░ ▓██▓ ░ ░▓█ ░██ 
░██▒██▓ ░██▓ ▒██▒ ▓█   ▓██▒  ▒██▒ ░ ░▓█▒░██▓ 
░ ▓░▒ ▒  ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░  ▒ ░░    ▒ ░░▒░▒
  ▒ ░ ░    ░▒ ░ ▒░  ▒   ▒▒ ░    ░     ▒ ░▒░ ░
  ░   ░    ░░   ░   ░   ▒     ░       ░  ░░ ░
  ░       ░           ░  ░          ░  ░  ░  
]],
        },
      },
    },
    keys = {
      -- Disable default <leader>. for scratch buffer (we use it for code actions)
      { "<leader>.", false },
      { "<leader>S", false },

      -- Snacks explorer keybinding (manual open, not auto)
      {
        "<leader>pv",
        function()
          require("snacks").explorer()
        end,
        desc = "Explorer (Snacks)",
      },
    },
  },
}
