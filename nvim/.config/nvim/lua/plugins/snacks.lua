if vim.g.vscode then return {} end

return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      dashboard = {
        preset = {
          header = [[
██╗    ██╗██████╗  █████╗ ████████╗██╗  ██╗
██║    ██║██╔══██╗██╔══██╗╚══██╔══╝██║  ██║
██║ █╗ ██║██████╔╝███████║   ██║   ███████║
██║███╗██║██╔══██╗██╔══██║   ██║   ██╔══██║
╚███╔███╔╝██║  ██║██║  ██║   ██║   ██║  ██║
 ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
]],
        },
      },
    },
    keys = {
      -- Disable default <leader>. for scratch buffer (we use it for code actions)
      { "<leader>.",  false },
      { "<leader>S",  false },

      -- Disable default <leader>e (we'll remap it)
      { "<leader>E",  false },
      { "<leader>fe", false },
      { "<leader>fE", false },

      -- Snacks explorer keybindings
      {
        "<leader>e",
        function()
          require("snacks").explorer({
            hidden = true,
            ignored = true,
          })
        end,
        desc = "Explorer (Snacks)",
      },
    },
  },
}
