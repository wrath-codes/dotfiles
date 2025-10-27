return {
  {
    "mawkler/modicator.nvim",
    event = "BufEnter",
    dependencies = "catppuccin/nvim",
    opts = {
      show_warnings = false,
      highlights = {
        defaults = {
          bold = true,
          italic = false,
        },
      },
      integration = {
        lualine = {
          enabled = true,
          mode_section = nil,
          highlight = "bg",
        },
      },
    },
  },
}
